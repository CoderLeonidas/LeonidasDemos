//
//  LYView.m
//  LYQianNiu
//
//  Created by Leonidas on 2017/3/6.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "LYView.h"
@interface LYView ()
@end

@implementation LYView
//绘制白色view背景
- (void)drawRect:(NSRect)dirtyRect {
    [[NSColor whiteColor] setFill];
    NSRectFill(dirtyRect);
    [super drawRect:dirtyRect];
}

@end
