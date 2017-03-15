//
//  LYRightViewContainer.m
//  LYQianNiu
//
//  Created by Leonidas on 2017/3/8.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "LYRightViewContainer.h"
#import "LYWelcomeView.h"

#import "LYTopAreaViewController.h"
#import "LYChattingAreaViewController.h"

@interface LYRightViewContainer ()
@property (nonatomic, strong) LYWelcomeView *welcomeView;
@property (nonatomic, strong) LYTopAreaViewController *topAreaViewController;
@property (nonatomic, strong) LYChattingAreaViewController *chattingAreaViewController;

@end

@implementation LYRightViewContainer

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setViews];
}

- (void)viewWillAppear {
    [super viewWillAppear];
}

- (void) setViews {
    //未有联系人选中时，显示欢迎界面
//    self.welcomeView.frame = self.view.bounds;
//    [self.view addSubview:self.welcomeView];
    CGFloat w = self.view.bounds.size.width;
    CGFloat topAreaH = 70;
    CGFloat chattingAreaH = self.view.bounds.size.height - topAreaH;
    self.chattingAreaViewController.view.frame = NSMakeRect(0, 0, w, chattingAreaH);
    self.topAreaViewController.view.frame = NSMakeRect(0, chattingAreaH, w, topAreaH);
    
    [self.view addSubview:self.chattingAreaViewController.view];
    [self.view addSubview:self.topAreaViewController.view];
}


#pragma mark - Lazy Loading

- (LYWelcomeView*) welcomeView{
    if (!_welcomeView) {
        _welcomeView = [[LYWelcomeView alloc] init];
    }
    return _welcomeView;
}

- (LYTopAreaViewController*) topAreaViewController{
    if (!_topAreaViewController) {
        _topAreaViewController = [[LYTopAreaViewController alloc] init];
    }
    return _topAreaViewController;
}


- (LYChattingAreaViewController*) chattingAreaViewController{
    if (!_chattingAreaViewController) {
        _chattingAreaViewController = [[LYChattingAreaViewController alloc] init];
    }
    return _chattingAreaViewController;
}

@end
