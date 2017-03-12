

//
//  LYAssistantLoginViewController.m
//  LYQianNiu
//
//  Created by Leonidas on 2017/3/12.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "LYAssistantLoginViewController.h"

#define ShouldRememberPasswordKey  @"ShouldRememberPasswordKey"
#define ShouldAutoLoginKey         @"ShouldAutoLoginKey"

@interface LYAssistantLoginViewController ()
@property (weak) IBOutlet NSButton *autoLoginClickBtn;//自动登录
@property (weak) IBOutlet NSButton *rememberPassworkClickBtn;//记住秘密
@property (weak) IBOutlet NSButton *findPasswordBtn;//找回密码
@property (weak) IBOutlet NSButton *registerAccountBtn;//注册账号

@end

@implementation LYAssistantLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}


#pragma mark - IBAction
- (IBAction)rememberPassworkClickBtnClicked:(id)sender {
}

- (IBAction)autoLoginClickBtnClicked:(id)sender {
}

//TODO：跳转链接
- (IBAction)findPasswordBtnClicked:(id)sender {
}

- (IBAction)registerAccountBtnClicked:(id)sender {
}


@end
