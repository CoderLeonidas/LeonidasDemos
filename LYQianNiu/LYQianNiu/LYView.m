//
//  LYView.m
//  LYQianNiu
//
//  Created by Leonidas on 2017/3/6.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "LYView.h"

@implementation LYView

- (void)drawRect:(NSRect)dirtyRect {
    [[NSColor whiteColor] setFill];
    NSRectFill(dirtyRect);
    [super drawRect:dirtyRect];
}

@end
