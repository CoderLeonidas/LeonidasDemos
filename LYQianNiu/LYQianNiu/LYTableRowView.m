//
//  LYTableRowView.m
//  LYQianNiu
//
//  Created by Leonidas on 2017/3/15.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "LYTableRowView.h"
#import "NSColor+LY.h"
@implementation LYTableRowView

- (void)drawSelectionInRect:(NSRect)dirtyRect {
        NSRect selectionRect = NSInsetRect(self.bounds, 0, 0);
    [[NSColor colorWithR:211 G:211 B:211 Alpha:1] setFill];
//    [[NSColor redColor] setFill];
    NSBezierPath *selectionPath = [NSBezierPath bezierPathWithRoundedRect:selectionRect xRadius:0 yRadius:0];
        [selectionPath fill];
}

@end
