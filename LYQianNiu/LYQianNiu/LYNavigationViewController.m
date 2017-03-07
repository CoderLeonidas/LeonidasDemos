//
//  LYNavigationViewController.m
//  LYQianNiu
//
//  Created by Leonidas on 2017/3/7.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "LYNavigationViewController.h"

@interface LYNavigationViewController ()
@property (weak) IBOutlet NSButton *avataBtn;
- (IBAction)avataBtnClicked:(id)sender;

@end

@implementation LYNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //TODO: 调整背景色
    self.view.wantsLayer = YES;
    self.view.layer.backgroundColor = [NSColor colorWithRed:27 green:146 blue:237 alpha:0.5].CGColor;
    
}

- (IBAction)avataBtnClicked:(id)sender {
    NSLog(@"avataBtnClicked");
}
@end
