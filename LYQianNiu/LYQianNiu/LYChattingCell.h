//
//  LYChattingCell.h
//  LYQianNiu
//
//  Created by Leonidas on 2017/3/17.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LYChattingCellModel.h"
@interface LYChattingCell : NSTableCellView

//外部传入参数
@property (nonatomic, strong) LYChattingCellModel *model;//模型
@property (nonatomic, assign) CGFloat cellWidth;
//外部读取参数
@property (nonatomic, assign, readonly) CGFloat cellHeight;//根据内容计算出的cell高度
@end
