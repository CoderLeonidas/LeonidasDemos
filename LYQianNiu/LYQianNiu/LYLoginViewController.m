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
@interface LYLoginViewController ()
@property (weak) IBOutlet NSImageView *imageView;
@property (nonatomic, strong) LYMainWindowController *mainWC;
@property (nonatomic, strong) LYAssistantLoginViewController *assistantLoginVC;
@end

@implementation LYLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.assistantLoginVC.view];
}

#pragma mark - IBAction

//箭头按钮控制辅助VC的显隐
- (IBAction)arrowBtnClicked:(id)sender {
    NSButton *btn = sender;
    if (btn.state) {
        [self testAnimationWithHidded:btn.state Effect:NSViewAnimationFadeOutEffect];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            self.assistantLoginVC.view.hidden = NO;
//        });NSViewAnimationFadeOutEffect
    } else {
        [self testAnimationWithHidded:btn.state Effect:NSViewAnimationFadeInEffect];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            self.assistantLoginVC.view.hidden = YES;
//        });
    }
    
}

- (IBAction)loginBtnClicked:(id)sender {
    //登录成功，关闭登录窗口
    [self.mainWC showWindow:self];
    [self.view.window close];
    
    // 判断用户的登录状态，YES 直接来到主界面
//    if ([LYUserInfo sharedLYUserInfo].loginStatus) {
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

- (LYAssistantLoginViewController*) assistantLoginVC{
    if (!_assistantLoginVC) {
        _assistantLoginVC = [[LYAssistantLoginViewController alloc] init];
        
        CGFloat W = 240.0;
        CGFloat H = 70.0;
        CGFloat X = (self.view.frame.size.width - self.imageView.frame.size.width- W) * 0.5 + self.imageView.frame.size.width;
        CGFloat Y = 30.0;
        _assistantLoginVC.view.frame = NSMakeRect(X, Y, W, H);
    }
    return _assistantLoginVC;
}


//使用NSViewAnimation
- (void)testAnimationWithHidded:(BOOL)hidden Effect:(NSString*)effectStr {
    //属性字典
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    //设置目标对象
    [dict setObject:self.assistantLoginVC.view forKey:NSViewAnimationTargetKey];
    self.assistantLoginVC.view.hidden = hidden;

    //设置动画效果
    [dict setObject:effectStr forKey:NSViewAnimationEffectKey];
    
    //设置动画
    NSViewAnimation *animation = [[NSViewAnimation alloc] initWithViewAnimations:[NSArray arrayWithObject:dict]];
    
    //启动动画
    [animation startAnimation];
}



@end
