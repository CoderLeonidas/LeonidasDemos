
//
//  LYTool.m
//  LYQianNiu
//
//  Created by Leonidas on 2017/3/8.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "LYTool.h"

@implementation LYTool

+ (void)changeBGColor:(NSColor*)aColor inView:(NSView*)aView {
    if (!aColor || !aView) return;
    
    aView.wantsLayer = YES;
    aView.layer.backgroundColor = aColor.CGColor;
}
@end
