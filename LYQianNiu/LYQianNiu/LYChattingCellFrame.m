
//
//  LYChattingCellFrame.m
//  LYQianNiu
//
//  Created by Leonidas on 2017/3/20.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "LYChattingCellFrame.h"
#import "LYChattingCellModel.h"
#import "NSString+LY.h"

#define Padding 10
#define AvatarHW 28
#define TimeH 28
@interface LYChattingCellFrame () {
    NSTimeInterval _newestTimeInterval;//最近显示过时间标签的时间戳

}
@property (nonatomic, assign) CGFloat cellWidth;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;//防止重复创建
@end

@implementation LYChattingCellFrame

- (void)setCellModel:(LYChattingCellModel *)cellModel {
// TODO   如何判断两个对象一样？
    _cellModel = cellModel;
    
    [self calculateFrames];
}

- (void)calculateFrames {
    CGSize contentSize = CGSizeMake(_cellWidth, MAXFLOAT);
    contentSize = [self.cellModel.message boundingRectWithSize:contentSize font:LYChattingCellContentFont maxWidth:_cellWidth];
    NSString *dateStr = [self.dateFormatter stringFromDate:self.cellModel.timeStamp];
    CGSize timeSize = CGSizeMake(_cellWidth, MAXFLOAT);
    timeSize = [dateStr boundingRectWithSize:timeSize font:LYChattingCellTimeFont maxWidth:_cellWidth];
    
    //时间
    self.timeViewF = (CGRect){{(self.cellWidth - timeSize.width)*0.5, Padding}, timeSize};
    
    //头像
    CGFloat avatarY = CGRectGetMaxY(self.timeViewF) + Padding;
    self.avatarViewF = NSMakeRect(Padding, avatarY, AvatarHW, AvatarHW);
    
    //气泡
    CGFloat bubbleX = Padding + self.avatarViewF.size.width + Padding;
    CGFloat bubbleY = self.avatarViewF.origin.y;
    CGFloat bubbleW = Padding + contentSize.width + Padding;
    CGFloat bubbleH = Padding + contentSize.height + Padding;
    self.bubbleViewF = NSMakeRect(bubbleX, bubbleY, bubbleW, bubbleH);
    
    
    //    self.cellModel. = [bubbleImage stretchableImageWithSize:NSMakeSize(_textWidth + 2*Padding, _textHeight+2*Padding) edgeInsets:NSEdgeInsetsMake(5,5,5,5)];
    
    //消息正文
    CGFloat contentX = bubbleX + Padding;
    CGFloat contentY = bubbleY + Padding;
    self.contentViewF = (CGRect){{contentX, contentY}, contentSize};
    //消息整体
    CGFloat originalX = 0;
    CGFloat originalY = 0;
    CGFloat originalW = self.cellWidth;
    CGFloat originalH = CGRectGetMaxY(self.bubbleViewF) + Padding;
    self.originalViewF = NSMakeRect(originalX, originalY, originalW, originalH);
    
    //cell的高度
    self.cellHeight = CGRectGetMaxY(self.originalViewF);
}

- (void)setCellWidth:(CGFloat)cellWidth {
    _cellWidth = cellWidth;
}

- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.dateFormat = @"yyyy-MM-dd hh:mm:ss";
    }
    return _dateFormatter;
}
@end
