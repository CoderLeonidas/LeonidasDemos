//
//  NSString+LY.h
//  LYQianNiu
//
//  Created by Leonidas on 2017/3/19.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LY)
/**
 *  @brief  根据字符串的宽(或高)和字体的大小计算字符串的size
 *  @param  size 给定字符串的宽或高
 *  @param  font 字体属性
 *  @return 字符串的宽和高
 */
- (CGSize)boundingRectWithSize:(CGSize)size font:(NSFont *)font;

/**
 *  @brief  根据字符串字体的大小(和最大宽度)计算字符串的size
 *  @param  size        给定字符串的(最小)高
 *  @param  font        字体属性
 *  @param  maxWidth    字符串最大的宽度
 *  @return 字符串的宽和高
 */
- (CGSize)boundingRectWithSize:(CGSize)size font:(NSFont *)font maxWidth:(CGFloat)maxWidth;

@end
