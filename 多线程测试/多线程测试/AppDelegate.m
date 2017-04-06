//
//  AppDelegate.m
//  多线程测试
//
//  Created by Leonidas on 2017/4/6.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {

    [self mainThread_async_test];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

//主队列同步测试：会死锁
- (void)mainThread_sync_test {
    
    NSLog(@"%@",[NSThread currentThread]);
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"sync----%@",[NSThread currentThread]);
    });
    NSLog(@"%@",[NSThread currentThread]);
}


//主队列异步测试：可以正常执行所有任务，不会死锁
- (void)mainThread_async_test {
    NSLog(@"%@",[NSThread currentThread]);
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"sync----%@",[NSThread currentThread]);
    });
    NSLog(@"%@",[NSThread currentThread]);
}


@end
