//
//  LYLoginViewController.m
//  LYQianNiu
//
//  Created by Leonidas on 2017/3/6.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "LYLoginViewController.h"
#import "LYMainWindowController.h"
#import "XMPPFramework.h"
@interface LYLoginViewController ()

@property (nonatomic, strong) LYMainWindowController *mainWC;
@end

@implementation LYLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - IBAction

- (IBAction)loginBtnClicked:(id)sender {
    //登录成功，关闭登录窗口
    [self.mainWC showWindow:self];
    [self.view.window close];
    
    // 判断用户的登录状态，YES 直接来到主界面
//    if ([WCUserInfo sharedWCUserInfo].loginStatus) {
//        // 自动登录服务
//        // 1秒后再自动登录
//#warning 一般情况下，都不会马上连接，会稍微等等
//        
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [[WCXMPPTool sharedWCXMPPTool] xmppUserLogin:nil];
//        });
//    }
}

#pragma mark - Lazy Loading 

-(LYMainWindowController *)mainWC {
    if (!_mainWC) {
        _mainWC = [[LYMainWindowController alloc] initWithWindowNibName:@"LYMainWindowController"];
        //不用下面方法创建，这个方法创建出来的window是nil
//        _mainWC = [[LYMainWindowController alloc] initWithWindowNibName:@"LYMainWindowController" owner:self];
    }
    
    return _mainWC;
}




@end
