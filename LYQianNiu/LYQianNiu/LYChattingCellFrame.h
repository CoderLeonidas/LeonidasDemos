//
//  LYChattingCellFrame.h
//  LYQianNiu
//
//  Created by Leonidas on 2017/3/20.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LYChattingCellModel.h"

// 时间字体
#define LYChattingCellTimeFont [NSFont systemFontOfSize:13]
// 正文字体
#define LYChattingCellContentFont [NSFont systemFontOfSize:13]

@interface LYChattingCellFrame : NSObject

@property (nonatomic, strong) LYChattingCellModel *cellModel;
//消息整体
@property (nonatomic, assign) CGRect originalViewF;
//时间
@property (nonatomic, assign) CGRect timeViewF;
//头像
@property (nonatomic, assign) CGRect avatarViewF;
//气泡
@property (nonatomic, assign) CGRect bubbleViewF;
//消息正文
@property (nonatomic, assign) CGRect contentViewF;
//cell的高度
@property (nonatomic, assign) CGFloat cellHeight;

//外部设置cell宽度
- (void)setCellWidth:(CGFloat)cellWidth;

@end
