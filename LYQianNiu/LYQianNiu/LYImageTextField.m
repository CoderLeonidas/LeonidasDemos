//
//  LYImageTextField.m
//  LYQianNiu
//
//  Created by Leonidas on 2017/3/8.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "LYImageTextField.h"
@interface LYImageTextField ()

@property (weak) IBOutlet NSTextField *searchTextField;
@property (weak) IBOutlet NSImageView *imageView;

@end

@implementation LYImageTextField

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackGroundView];
}

#pragma mark - Setter & Getter

- (void)setImage:(NSImage *)image {
    if (!image) return;
    _image = image;
    self.imageView.image = _image;
}

#pragma mark - Private

- (void)setBackGroundView {
    //设置圆角
    self.view.wantsLayer = YES;
    self.view.layer.cornerRadius = 4;
    //背景色
    [LYTool changeBGColor:[NSColor clearColor] inView:self.imageView];
}

@end
