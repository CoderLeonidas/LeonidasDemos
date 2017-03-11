//
//  LYNavigationViewController.m
//  LYQianNiu
//
//  Created by Leonidas on 2017/3/7.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "LYNavigationViewController.h"
#import "CommonDef.h"

@interface LYNavigationViewController ()
@property (weak) IBOutlet NSButton *avataBtn;
@property (weak) IBOutlet NSButton *jinRiJieDaiBtn;
@property (weak) IBOutlet NSButton *zuiJinHuiHuaBtn;
@property (weak) IBOutlet NSButton *lianXiRenBtn;
@property (weak) IBOutlet NSButton *qunZuBtn;

@end

@implementation LYNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //TODO: 调整背景色
    
}

- (IBAction)avataBtnClicked:(id)sender {
    NSLog(@"avataBtnClicked");
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


@end
