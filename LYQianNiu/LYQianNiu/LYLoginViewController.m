//
//  LYLoginViewController.m
//  LYQianNiu
//
//  Created by Leonidas on 2017/3/6.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "LYLoginViewController.h"
#import "LYMainWindowController.h"

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
}

#pragma mark - Lazy Loading 

-(LYMainWindowController *)mainWC {
    if (!_mainWC) {
        
        _mainWC = [[LYMainWindowController alloc] initWithWindowNibName:@"LYMainWindowController"];
        //不用下面方法创建，这个方法创建出来的window是nil
//        _mainWC = [[LYMainWindowController alloc] initWithWindowNibName:@"LYMainWindowController" owner:self];
//        [_mainWC.window setFrame: NSMakeRect(500, 500, 900, 600) display:YES];
    }
    
    return _mainWC;
}




@end
