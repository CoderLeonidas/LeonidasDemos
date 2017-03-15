    //
//  HttpTool.m
//  LYQianNiu
//
//  Created by Leonidas on 2017/3/16.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "HttpTool.h"

#define kTimeOut 5.0

@interface HttpTool() <NSURLSessionTaskDelegate, NSURLSessionDownloadDelegate> {
    //下载
    HttpToolProgressBlock _downloadProgressBlock;
    HttpToolCompletionBlock _downloadCompletionBlock;
    NSURL *_downloadURL;
    
    //上传
    HttpToolProgressBlock _uploadProgressBlock;
    HttpToolCompletionBlock _uploadCompletionBlock;
    
}

@end

@implementation HttpTool

#pragma mark - 上传

- (void)uploadData:(NSData *)data
               url:(NSURL *)url
     progressBlock:(HttpToolProgressBlock)progressBlock
        completion:(HttpToolCompletionBlock)completionBlock {
    
    NSAssert(data != nil, @"上传数据不能为空");
    NSAssert(url != nil, @"上传文件路径不能为空");
    
    _uploadProgressBlock = progressBlock;
    _uploadCompletionBlock = completionBlock;
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:kTimeOut];
    request.HTTPMethod = @"PUT";
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config  delegate:self delegateQueue:[[NSOperationQueue alloc] init]];
    NSURLSessionUploadTask *uploadTask = [session uploadTaskWithRequest:request fromData:data];
    [uploadTask resume];
}

#pragma mark - 上传代理


#pragma mark - 上传进度
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didSendBodyData:(int64_t)bytesSent totalBytesSent:(int64_t)totalBytesSent totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend {
    if (_uploadProgressBlock) {
        CGFloat progress = (CGFloat)totalBytesSent / totalBytesExpectedToSend;
        _uploadProgressBlock(progress);
    }
}

#pragma mark - 上传完成

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    if (_uploadCompletionBlock) {
        _uploadCompletionBlock(error);
        
        _uploadProgressBlock = nil;
        _uploadCompletionBlock = nil;
    }
}


#pragma mark - 下载

- (void)downloadFromURL:(NSURL *)url
          progressBlock:(HttpToolProgressBlock)progressBlock
             completion:(HttpToolCompletionBlock)completionBlock {
    NSAssert(url != nil, @"下载URL不能为空");
    
    _downloadURL = url;
    _downloadProgressBlock = progressBlock;
    _downloadCompletionBlock = completionBlock;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:kTimeOut];
    
    //session大多数使用单利即可
    NSURLResponse *response = nil;
    
    //发同步请求
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    //判断文件是否存在
    if (response.expectedContentLength <= 0) {
        if (_downloadCompletionBlock) {
            NSError *error = [NSError errorWithDomain:@"文件不存在" code:404 userInfo:nil];
            _downloadCompletionBlock(error);
            
            //清除block
            _downloadCompletionBlock = nil;
            _downloadProgressBlock = nil;
        }
        return;
    }

    NSURLSessionConfiguration *config = [NSURLSessionConfiguration  defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[[NSOperationQueue alloc] init]];
    //定义下载操作
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithRequest:request];
    [downloadTask resume];
}

#pragma mark -NSURLSessionDownloadDelegate
#pragma mark 下载完成
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    NSString *fileName = [_downloadURL lastPathComponent];
    NSString *fileSavePath = [self fileSavePath:fileName];
    //文件管理
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager copyItemAtURL:location toURL:[NSURL fileURLWithPath:fileSavePath] error:nil];
    
    if (_downloadCompletionBlock) {
        //通知下载成功，没有错误
        _downloadCompletionBlock(nil);
    
        //清空Bloc
        _downloadCompletionBlock = nil;
        _downloadProgressBlock = nil;
    }
}

#pragma mark 下载进度

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    if (_downloadProgressBlock) {
        CGFloat progress = (CGFloat)totalBytesWritten / totalBytesExpectedToWrite;
        _downloadProgressBlock(progress);
    }
}

//断点续传？？
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes {

}

- (NSString *)fileSavePath:(NSString *)fileName {
    
    NSString *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    //图片保存在沙盒的Document下
    return [document stringByAppendingString:fileName];
}

@end
