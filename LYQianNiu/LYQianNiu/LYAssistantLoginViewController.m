

//
//  LYAssistantLoginViewController.m
//  LYQianNiu
//
//  Created by Leonidas on 2017/3/12.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "LYAssistantLoginViewController.h"

NSString *const registerURLStr = @"https://reg.taobao.com/member/reg/fill_mobile.htm";
NSString *const findPwdURLStr = @"https://passport.taobao.com/ac/password_find.htm?spm=a2107.1.0.0.k0rNbq&from_site=0";

@interface LYAssistantLoginViewController ()
@property (weak) IBOutlet NSButton *findPasswordBtn;//找回密码
@property (weak) IBOutlet NSButton *registerAccountBtn;//注册账号

@end

@implementation LYAssistantLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}


#pragma mark - IBAction
//勾选后保存设置到沙盒
- (IBAction)rememberPwdCheckBoxBtnClicked:(id)sender {
    NSButton *btn = sender;
    LYUserInfo *userInfo = [LYUserInfo sharedLYUserInfo];
    userInfo.rememberPwd = btn.state;
    [userInfo saveUserInfoToSanbox];
}

- (IBAction)autoLoginCheckBoxBtnClicked:(id)sender {
    NSButton *btn = sender;
    LYUserInfo *userInfo = [LYUserInfo sharedLYUserInfo];
    userInfo.autoLogin = btn.state;
    [userInfo saveUserInfoToSanbox];
}

//点击后跳转链接
- (IBAction)findPasswordBtnClicked:(id)sender {
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:findPwdURLStr]];
}

- (IBAction)registerAccountBtnClicked:(id)sender {
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:registerURLStr]];
}


@end
