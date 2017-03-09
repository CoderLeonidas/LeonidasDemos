//
//  LYRightContainerViewController.m
//  LYQianNiu
//
//  Created by Leonidas on 2017/3/8.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "LYRightContainerViewController.h"
#import "LYLeftViewContainer.h"
#import "LYRightViewContainer.h"
@interface LYRightContainerViewController ()
@property (nonatomic, strong) LYLeftViewContainer *leftViewContainer;
@property (nonatomic, strong) LYRightViewContainer *rightViewContainer;

@property (weak) IBOutlet NSView *leftContainer;
@property (weak) IBOutlet NSView *rightContainer;

@end

@implementation LYRightContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
}

#define LeftContainerWidth 160

- (void)setupViews {
    self.leftViewContainer.view.frame = NSMakeRect(0, 0, LeftContainerWidth, self.view.frame.size.height);
    [self.leftContainer addSubview:self.leftViewContainer.view];
    
    
    self.rightViewContainer.view.frame = NSMakeRect(0, 0, self.view.frame.size.width - LeftContainerWidth, self.view.frame.size.height);
    [self.rightContainer addSubview:self.rightViewContainer.view];
}

- (LYLeftViewContainer *)leftViewContainer {
    if (!_leftViewContainer) {
        _leftViewContainer = [[LYLeftViewContainer alloc] init];
    }
    return _leftViewContainer;
}

- (LYRightViewContainer *)rightViewContainer {
    if (!_rightViewContainer) {
        _rightViewContainer = [[LYRightViewContainer alloc] init];
    }
    return _rightViewContainer;
}

@end
