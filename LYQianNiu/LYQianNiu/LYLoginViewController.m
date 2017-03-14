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
#import "LYAssistantLoginViewController.h"

@interface LYLoginViewController () <NSTextFieldDelegate>
@property (weak) IBOutlet NSImageView *leftImageView;//左侧图片
@property (weak) IBOutlet NSImageView *avatarImageView;//头像
@property (weak) IBOutlet NSTextField *accountTextField;//账号框
@property (weak) IBOutlet NSTextField *pwdTextField;//密码框
@property (weak) IBOutlet NSButton *loginBtn;//登录按钮

@property (nonatomic, strong) LYMainWindowController *mainWC;
@property (nonatomic, strong) LYAssistantLoginViewController *assistantLoginVC;
@end

@implementation LYLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initObjects];
    [self dealWithLoginMessage];
}

- (void)initObjects {
    self.accountTextField.delegate = self;
    self.pwdTextField.delegate = self;
    [self.view addSubview:self.assistantLoginVC.view];
}

#pragma mark - IBAction
//箭头按钮控制辅助VC的显隐
- (IBAction)arrowBtnClicked:(id)sender {
    NSButton *btn = sender;
    if (btn.state) {
        [self animationForView:self.assistantLoginVC.view WithHidded:btn.state Effect:NSViewAnimationFadeOutEffect];
    } else {
        [self animationForView:self.assistantLoginVC.view WithHidded:btn.state Effect:NSViewAnimationFadeInEffect];
    }
}

- (IBAction)loginBtnClicked:(id)sender {
    if (self.accountTextField.stringValue.length <= 0) {
        //提示输入账号
        return;
    }

    [self login];
}

//处理登录信息
- (void)dealWithLoginMessage {
    LYUserInfo *userInfo = [LYUserInfo sharedLYUserInfo];
    self.accountTextField.stringValue = userInfo.user ? userInfo.user :@"";
    self.assistantLoginVC.rememberPwdCheckBoxBtn.state = userInfo.rememberPwd;
    if (userInfo.rememberPwd) {
        self.pwdTextField.stringValue     = userInfo.pwd ? userInfo.pwd :@"";
    }
    self.assistantLoginVC.autoLoginCheckBoxBtn.state = userInfo.autoLogin;
    if (userInfo.autoLogin) {
        [self login];
    }
}

#pragma mark - Login

- (void)login {
    LYUserInfo *userInfo = [LYUserInfo sharedLYUserInfo];
    userInfo.user = self.accountTextField.stringValue;
    userInfo.pwd = self.pwdTextField.stringValue;
    [self loginWithUserInfo:userInfo];
}

- (void)loginWithUserInfo:(LYUserInfo *)userInfo {
    //检测网路?
    LYXMPPTool *xmppTool = [LYXMPPTool sharedLYXMPPTool];
    xmppTool.registerOperation = NO;
    __weak typeof(self) weakSelf = self;
    [xmppTool xmppUserLogin:^(XMPPResultType type) {
        [weakSelf handleWithResultType:type];
    }];
}

- (void)handleWithResultType:(XMPPResultType)resultType {
   //刷新界面需要在主线程
    dispatch_async(dispatch_get_main_queue(), ^{
        switch (resultType) {
            case XMPPResultTypeLoginSuccess:{
                [self enterMainWindow];
                LYLog(@"登录成功");
                break;
            }
            case XMPPResultTypeLoginFailure:{
                LYLog(@"登录失败");
                break;
            }
            case XMPPResultTypeNetErr:{
                LYLog(@"网络错误");
                break;
            }
            default:
                break;
        }
    });
}

- (void)enterMainWindow {
    //登录成功，关闭登录窗口
    LYUserInfo *userInfo = [LYUserInfo sharedLYUserInfo];
    userInfo.loginStatus = YES;//修改登录状态为在线(类似QQ的自定义登录状态先不做)
    [userInfo saveUserInfoToSanbox];
    
    [self.mainWC showWindow:self];
    [self.view.window close];
}

#pragma mark - Lazy Loading 

-(LYMainWindowController *)mainWC {
    if (!_mainWC) {
        _mainWC = [[LYMainWindowController alloc] initWithWindowNibName:@"LYMainWindowController"];
    }
    return _mainWC;
}

- (LYAssistantLoginViewController*) assistantLoginVC{
    if (!_assistantLoginVC) {
        _assistantLoginVC = [[LYAssistantLoginViewController alloc] init];
        CGFloat W = 240.0;
        CGFloat H = 70.0;
        CGFloat X = (self.view.frame.size.width - self.leftImageView.frame.size.width- W) * 0.5 + self.leftImageView.frame.size.width;
        CGFloat Y = 30.0;
        _assistantLoginVC.view.frame = NSMakeRect(X, Y, W, H);
    }
    return _assistantLoginVC;
}

//使用NSViewAnimation 设置一个view的显隐动画
- (void)animationForView:(NSView *)aView
              WithHidded:(BOOL)hidden
                  Effect:(NSString*)effectStr {
    //属性字典
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    //设置目标对象
    [dict setObject:aView forKey:NSViewAnimationTargetKey];
    aView.hidden = hidden;
    //设置动画效果
    [dict setObject:effectStr forKey:NSViewAnimationEffectKey];
    //设置动画
    NSViewAnimation *animation = [[NSViewAnimation alloc] initWithViewAnimations:[NSArray arrayWithObject:dict]];
    //启动动画
    [animation startAnimation];
}

#pragma mark - NSTextFieldDelegate

- (void)controlTextDidChange:(NSNotification *)obj {
    NSTextField *textField = obj.object;
    if ([textField isEqualTo:self.accountTextField]) {//若账号被清空，就连同密码也清空
        NSString *account = self.accountTextField.stringValue;
        //密码框输入时才显示登录按钮
        if (account.length <= 0 )  {
            self.pwdTextField.stringValue = @"";
        }
        
    } else if ([textField isEqualTo:self.pwdTextField]) {
        NSString *pwd = self.pwdTextField.stringValue;
        //密码框输入时才显示登录按钮
        if (pwd.length > 0 )  {
            self.loginBtn.hidden = NO;
        } else {
            self.loginBtn.hidden = YES;
        }
    }
}

- (void)controlTextDidBeginEditing:(NSNotification *)obj {
}

- (void)controlTextDidEndEditing:(NSNotification *)obj {
}

@end
