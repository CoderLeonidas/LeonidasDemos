
//
//  NSColor+LY.m
//  LYQianNiu
//
//  Created by Leonidas on 2017/3/15.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "NSColor+LY.h"

@implementation NSColor (LY)
+ (NSColor *)colorWithR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue Alpha:(CGFloat)alpha {
    return [NSColor colorWithRed:red/255.0 green:green/255.0  blue:blue/255.0  alpha:alpha/1.0];
}
@end
