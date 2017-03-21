//
//  LYChattingCell.m
//  LYQianNiu
//
//  Created by Leonidas on 2017/3/17.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "LYChattingCell.h"
#import "Masonry.h"
#import "NSString+LY.h"
#import "NSImage+LY.h"
#import "LYFlippedView.h"

#import "LYScrollView.h"

@interface LYChattingCell () {
    NSTimeInterval _newestTimeInterval;//最近显示过时间标签的时间戳
    CGFloat _textHeight;//文本内容高度
    CGFloat _textWidth;//文本内容宽度
}

//cell消息展示控件
@property (weak) IBOutlet NSButton *avatarBtn;//头像
@property (weak) IBOutlet NSTextField *timeLabel;//时间
@property (unsafe_unretained) IBOutlet NSTextView *contentTextView;//内容
@property (weak) IBOutlet NSImageView *bubbleImageView;//气泡
@property (weak) IBOutlet LYScrollView *contentTextViewArea;

@property (strong) IBOutlet LYFlippedView *cellView;
@end

@implementation LYChattingCell

+ (instancetype)cellWithTableView:(NSTableView *)tableView {
    if (!tableView) return nil;
    static NSString *identifier = @"LYChattingCell";
    LYChattingCell *cellView = [tableView makeViewWithIdentifier:identifier owner:nil];
    if (!cellView) {
        
        cellView = [[LYChattingCell alloc] init];
        cellView.identifier = identifier;
        [LYTool changeBGColor:[NSColor yellowColor] inView:cellView];
    }
    
    return cellView;
}

- (instancetype)init {
    if (self = [super init]) {
        NSString* nibName = NSStringFromClass([self class]);
        if ([[NSBundle mainBundle] loadNibNamed:nibName
                                          owner:self
                                topLevelObjects:nil]) {
            [self.cellView setFrame:[self bounds]];
            [self addSubview:self.cellView];
        }
    }
    return self;
}


- (void)setCellFrame:(LYChattingCellFrame *)cellFrame {
    _cellFrame = cellFrame;
    LYChattingCellModel *cellModel = cellFrame.cellModel;
    //消息整体
    self.cellView.frame = cellFrame.originalViewF;
    //时间
    self.timeLabel.frame = cellFrame.timeViewF;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd hh:mm:ss";
    NSString *dateStr = [dateFormatter stringFromDate:self.cellFrame.cellModel.timeStamp];
    self.timeLabel.stringValue = dateStr;
    //头像
    self.avatarBtn.frame = cellFrame.avatarViewF;
    self.avatarBtn.image = cellModel.avatar;
    //气泡
    self.bubbleImageView.frame = cellFrame.bubbleViewF;
    NSImage *image = !cellModel.outgoing ? [NSImage imageNamed:@"bubble_left@2x"] :[NSImage imageNamed:@"bubble_right@2x"];
    
    image = [image stretchableImageWithSize:cellFrame.bubbleViewF.size edgeInsets:NSEdgeInsetsMake(5,5,5,5)];
    self.bubbleImageView.image = image;
    
    [self.bubbleImageView addSubview:self.contentTextViewArea];
    
    //内容
    self.contentTextViewArea.frame = cellFrame.contentViewF;
    if ( cellModel.message) {
        self.contentTextView.string = cellModel.message;
    }
    
}

@end
