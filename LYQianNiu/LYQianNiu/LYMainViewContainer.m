//
//  LYMainViewContainer.m
//  LYQianNiu
//
//  Created by Leonidas on 2017/3/7.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "LYMainViewContainer.h"
#import "LYNavigationViewController.h"
#import "LYRightContainerViewController.h"
@interface LYMainViewContainer ()
@property (weak) IBOutlet NSView *leftContrainerView;
@property (weak) IBOutlet NSView *rightContainerView;

@property (nonatomic, strong) LYNavigationViewController *naviVC;
@property (nonatomic, strong) LYRightContainerViewController *rightContainerVC;

@end

@implementation LYMainViewContainer

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setViews];
}

- (void)setViews {
    self.naviVC.view.frame = self.leftContrainerView.bounds;
    [self.leftContrainerView addSubview:self.naviVC.view];
    
    self.rightContainerVC.view.frame = self.rightContainerView.bounds;
    [self.rightContainerView addSubview:self.rightContainerVC.view];
}

#pragma mark - Lazy Loading

- (LYNavigationViewController *)naviVC {
    if (!_naviVC) {
        _naviVC = [[LYNavigationViewController alloc] init];
    }
    return _naviVC;
}

- (LYRightContainerViewController *)rightContainerVC {
    if (!_rightContainerVC) {
        _rightContainerVC = [[LYRightContainerViewController alloc] init];
    }
    return _rightContainerVC;
}

@end
