//
//  LYHttpTool.h
//  LYQianNiu
//
//  Created by Leonidas on 2017/3/16.
//  Copyright © 2017年 Leon. All rights reserved.
//  文件上传下载工具

#import <Foundation/Foundation.h>

typedef void (^LYHttpToolProgressBlock)(CGFloat progress);
typedef void (^LYHttpToolCompletionBlock)(NSError *error);

@interface LYHttpTool : NSObject


/**
 上传数据
 */
- (void)uploadData:(NSData *)data
               url:(NSURL *)url
     progressBlock:(LYHttpToolProgressBlock)progressBlock
        completion:(LYHttpToolCompletionBlock)completionBlock;

/**
 下载数据
 */
- (void)downloadFromURL:(NSURL *)url
          progressBlock:(LYHttpToolProgressBlock)progressBlock
             completion:(LYHttpToolCompletionBlock)completionBlock;

- (NSString *)fileSavePath:(NSString *)fileName;

@end
