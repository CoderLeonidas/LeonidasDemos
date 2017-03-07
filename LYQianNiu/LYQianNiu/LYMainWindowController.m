//
//  LYMainWindowController.m
//  LYQianNiu
//
//  Created by Leonidas on 2017/3/6.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "LYMainWindowController.h"
#import "LYMainViewContainer.h"
@interface LYMainWindowController ()

@property (nonatomic, strong) LYMainViewContainer *mainViewContainer;
@end

@implementation LYMainWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    [self setupMainWindowState];
    
    self.mainViewContainer.view.frame = self.window.contentView.bounds;
    self.window.contentView = self.mainViewContainer.view;
}

- (NSString *)windowNibName {
    return @"LYMainWindowController";
}


//设置窗口外观状态
- (void)setupMainWindowState {
    self.window.titlebarAppearsTransparent = YES;
    self.window.titleVisibility = NSWindowTitleHidden;
    self.window.styleMask |= NSWindowStyleMaskTitled |NSWindowStyleMaskUnifiedTitleAndToolbar |NSWindowStyleMaskFullSizeContentView;
}

#pragma mark - Lazy Loading 

- (LYMainViewContainer *)mainViewContainer {
    if (!_mainViewContainer) {
        _mainViewContainer = [[LYMainViewContainer alloc] initWithNibName:@"LYMainViewContainer" bundle:nil];
        _mainViewContainer.view.autoresizingMask = 1|2|4|8|16|32;
    }
    return _mainViewContainer;
}

@end
