//
//  LYNavigationViewController.m
//  LYQianNiu
//
//  Created by Leonidas on 2017/3/7.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "LYNavigationViewController.h"
#import "CommonDef.h"
#import "LYAvatarImageView.h"
@interface LYNavigationViewController ()
@property (weak) IBOutlet NSView *avatarArea;
@property (weak) IBOutlet NSButton *jinRiJieDaiBtn;
@property (weak) IBOutlet NSButton *zuiJinHuiHuaBtn;
@property (weak) IBOutlet NSButton *lianXiRenBtn;
@property (weak) IBOutlet NSButton *qunZuBtn;
@property (nonatomic, strong) LYAvatarImageView *avatarView;
@end

@implementation LYNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //TODO: 调整背景色
}

- (void)viewWillAppear {

    [self addAvatarView];
}

- (void)addAvatarView {
    self.avatarView.frame = NSMakeRect(0, 0, 44 , 44);
    self.avatarView.styleMask = LYAvatarImageViewStyleMaskOnlineStatus | LYAvatarImageViewStyleMaskClose;
    self.avatarView.autoresizingMask = 1|2|4|8|16|32;
    [self.avatarArea addSubview:self.avatarView];
}

- (IBAction)jinRiJieDaiBtnClicked:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:LYJinRiJieDaiBtnClickNotification object:self];
}

- (IBAction)lianXiRenBtnClicked:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:LYLianXiRenBtnClickNotification object:self];
}

- (IBAction)zuiJinHuiHuaBtnClicked:(id)sender  {
    [[NSNotificationCenter defaultCenter] postNotificationName:LYZuiJinHuiHuaBtnClickNotification object:self];
}

- (IBAction)qunZuBtnClicked:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:LYQunZuBtnClickNotification object:self];
}


- (LYAvatarImageView*) avatarView{
    if (!_avatarView) {
        _avatarView = [[LYAvatarImageView alloc] init];
    }
    return _avatarView;
}

@end
