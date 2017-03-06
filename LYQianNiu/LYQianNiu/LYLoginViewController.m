//
//  LYLoginViewController.m
//  LYQianNiu
//
//  Created by Leonidas on 2017/3/6.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "LYLoginViewController.h"
#import "LYLoginViewController.h"

@interface LYLoginViewController ()
@property (nonatomic, strong) LYLoginViewController *loginVC;
@end

@implementation LYLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - Lazy Loading 

-(LYLoginViewController *)loginVC {
    if (!_loginVC) {
        _loginVC = [[LYLoginViewController alloc] initWithNibName:@"LYLoginViewController" bundle:nil];
        
        NSRect frame = self.view.window.frame;
        [_loginVC.view setFrame:frame];
    }
    return _loginVC;
}


@end
