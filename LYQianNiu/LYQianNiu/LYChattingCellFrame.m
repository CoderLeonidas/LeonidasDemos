
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
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
    });
}

- (void)calculateFrames {
    CGSize contentSize = CGSizeMake(_cellWidth, MAXFLOAT);
    contentSize = [self.cellModel.message boundingRectWithSize:contentSize font:LYChattingCellContentFont maxWidth:_cellWidth];
    contentSize.width += 12;//+12 是因为textview在文字左右还有月6像素的padding
    NSString *dateStr = [self.dateFormatter stringFromDate:self.cellModel.timeStamp];
    CGSize timeSize = CGSizeMake(_cellWidth, MAXFLOAT);
    timeSize = [dateStr boundingRectWithSize:timeSize font:LYChattingCellTimeFont maxWidth:_cellWidth];
    timeSize.width += 12;
   
    //时间
    NSRect  timeLabelFrame = (CGRect){{(self.cellWidth - timeSize.width)*0.5, Padding}, timeSize};
    self.timeViewF = timeLabelFrame;
    
    BOOL outgoing = _cellModel.outgoing;
    
    //头像
    CGFloat avatarX = !outgoing?Padding:_cellWidth - Padding - AvatarHW;
    CGFloat avatarY = CGRectGetMaxY(self.timeViewF) + Padding;
    self.avatarViewF = NSMakeRect(avatarX, avatarY, AvatarHW, AvatarHW);
    
    //气泡
    CGFloat bubbleW = Padding + contentSize.width + Padding;
    CGFloat bubbleH = Padding + contentSize.height + Padding;
    CGFloat bubbleX = !outgoing?Padding + self.avatarViewF.size.width + Padding:_cellWidth-Padding-AvatarHW-Padding-bubbleW;
    CGFloat bubbleY = self.avatarViewF.origin.y;
    self.bubbleViewF = NSMakeRect(bubbleX, bubbleY, bubbleW, bubbleH);
    
    //消息正文
    CGFloat contentX =  Padding;
    CGFloat contentY =   Padding;
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
