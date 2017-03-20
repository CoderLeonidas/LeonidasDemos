

//
//  LYChattingCellView.m
//  LYQianNiu
//
//  Created by Leonidas on 2017/3/20.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "LYChattingCellView.h"
#import "LYChattingCellModel.h"
#import "NSImage+LY.h"
#import "LYFlippedView.h"
@interface LYChattingCellView ()
//消息整体
@property (nonatomic, strong) LYFlippedView *originalView;
//时间
@property (nonatomic, strong) NSTextField *timeLabel;
//头像
@property (nonatomic, strong) NSButton *avatarBtn;
//气泡
@property (nonatomic, strong) NSImageView *bubbleImageView;
//内容
@property (nonatomic, strong) NSTextView *contentTextView;

@end
@implementation LYChattingCellView

+ (instancetype)cellWithTableView:(NSTableView *)tableView {
    if (!tableView) return nil;
    static NSString *identifier = @"LYChattingCellView";
    LYChattingCellView *cellView = [tableView makeViewWithIdentifier:identifier owner:nil];
    if (!cellView) {
        
        cellView = [[LYChattingCellView alloc] init];
        cellView.identifier = identifier;
        [LYTool changeBGColor:[NSColor yellowColor] inView:cellView];
    }
    
    return cellView;
}


- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    
    //消息整体
    LYFlippedView *originalView = [[LYFlippedView alloc] init];
    [self addSubview:originalView];
    self.originalView = originalView;
    //时间
    NSTextField *timeLabel = [[NSTextField alloc] init];
    timeLabel.font = LYChattingCellTimeFont;
    [self.originalView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    //头像
    NSButton *avatarBtn = [[NSButton alloc] init];
    [self.originalView addSubview:avatarBtn];
    self.avatarBtn = avatarBtn;
    //气泡
    NSImageView *bubbleImageView = [[NSImageView alloc] init];
    [self.originalView addSubview:bubbleImageView];
    self.bubbleImageView = bubbleImageView;
    //内容
    NSTextView *contentTextView = [[NSTextView alloc] init];
    contentTextView.font = LYChattingCellContentFont;
    [self.originalView addSubview:contentTextView];
    self.contentTextView = contentTextView;
    
    return self;
}

- (void)setCellFrame:(LYChattingCellFrame *)cellFrame {
    _cellFrame = cellFrame;
    LYChattingCellModel *cellModel = cellFrame.cellModel;
    //消息整体
    self.originalView.frame = cellFrame.originalViewF;
    //时间
    self.timeLabel.frame = cellFrame.timeViewF;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd hh:mm:ss";
    NSString *dateStr = [dateFormatter stringFromDate:[NSDate date]];
    self.timeLabel.stringValue = dateStr;
//    self.timeLabel.stringValue;
    //头像
    self.avatarBtn.frame = cellFrame.avatarViewF;
    self.avatarBtn.image = cellModel.avatar;
    //气泡
    self.bubbleImageView.frame = cellFrame.bubbleViewF;
    NSImage *image = cellModel.outgoing ? [NSImage imageNamed:@"bubble_left@2x"] :[NSImage imageNamed:@"bubble_right@2x"];
    
    image = [image stretchableImageWithSize:cellFrame.bubbleViewF.size edgeInsets:NSEdgeInsetsMake(5,5,5,5)];
    self.bubbleImageView.image = image;
    //内容
    self.contentTextView.frame = cellFrame.contentViewF;
    self.contentTextView.string = cellModel.message;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
}



@end
