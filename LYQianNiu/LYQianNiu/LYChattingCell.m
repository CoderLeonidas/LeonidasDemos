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

#define Padding 10
#define ButtonH 40



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

@property (strong) IBOutlet LYChattingCell *cellView;
@property (weak) IBOutlet NSScrollView *contentAreaView;//内容区域
@end

@implementation LYChattingCell

- (instancetype)init {
    if (self = [super init]) {
        NSString* nibName = NSStringFromClass([self class]);
        if ([[NSBundle mainBundle] loadNibNamed:nibName
                                          owner:self
                                topLevelObjects:nil]) {
            [self.cellView setFrame:[self bounds]];
            [self addSubview:self.cellView];
            
            _newestTimeInterval = 0;
            _textWidth = 0.0;
            _textHeight = 0.0;
            
            [LYTool changeBGColor:[NSColor redColor] inView:self.timeLabel];
            [LYTool changeBGColor:[NSColor yellowColor] inView:self.bubbleImageView];
            [LYTool changeBGColor:[NSColor greenColor] inView:self.contentTextView];
            [LYTool changeBGColor:[NSColor blueColor] inView:self.avatarBtn];
            [LYTool changeBGColor:[NSColor purpleColor] inView:self.cellView];
        }
    }
    return self;
}

- (BOOL)isFlipped {
    return YES;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

- (void)setModel:(LYChattingCellModel *)model {
    if ([model isEqualTo:_model]) return;
    _model = model;
    
    NSFont *font = [NSFont systemFontOfSize:[NSFont smallSystemFontSize]];
    CGSize size = CGSizeMake(self.cellWidth, MAXFLOAT);
    size = [self.model.message boundingRectWithSize:size font:font maxWidth:self.cellWidth];
    _textHeight = size.height;
    _textWidth = size.width;
    //文字的最大宽度决定textview的宽度
    if ( _textWidth > self.cellWidth*0.7){
        _textWidth = self.cellWidth*0.7;
    }
    [self setViews];
    //[self setViewsFrame];
}

- (void)setViews {
    //时间
    [self setTimeLabel];
    //头像
    [self setAvatarBtn];
    //气泡
    [self setBubbleImageView];
    //文本
    [self setContentTextView];
}

- (void)setTimeLabel {
    //TODO 时间戳获取有问题
//    NSTimeInterval timeInterval = self.model.timeStamp.timeIntervalSince1970;
//    if (timeInterval - _newestTimeInterval > 120 ) {//时间间隔大约2min显示时间标签
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyy-MM-dd hh:mm:ss";
//        NSString *dateStr = [dateFormatter stringFromDate:self.model.timeStamp];
    
    NSString *dateStr = [dateFormatter stringFromDate:[NSDate date]];
    if (dateStr) {
        [self.timeLabel setHidden:NO];
        self.timeLabel.stringValue = dateStr;
    }
//        _newestTimeInterval = timeInterval;
//    }
}

- (void)setAvatarBtn {
    if (self.model.avatar) {
        self.avatarBtn.image = self.model.avatar;
    }
}

- (void)setBubbleImageView {
    NSImage *bubbleImage = self.model.outgoing ? [NSImage imageNamed:@"bubble_left@2x"] :[NSImage imageNamed:@"bubble_right@2x"];
//    bubbleImage.resizingMode =  NSImageResizingModeStretch;
//    bubbleImage.capInsets = NSEdgeInsetsMake(5,5,5,5);
    bubbleImage = [bubbleImage stretchableImageWithSize:NSMakeSize(_textWidth + 2*Padding, _textHeight+2*Padding) edgeInsets:NSEdgeInsetsMake(5,5,5,5)];
    self.bubbleImageView.image = bubbleImage;
}

- (void)setContentTextView {
    if (self.model.message){
        self.contentTextView.string = self.model.message;
        self.contentTextView.backgroundColor = [NSColor clearColor];
    }
}

//使用Marsonry进行布局

- (void)setViewsFrame {
    //容器本身
    [self.cellView mas_makeConstraints:^(MASConstraintMaker *make) {

    }];
    
    WS(weakSelf);
    if (!self.timeLabel.isHidden) {
        //时间标签
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.cellView).with.offset(Padding);
            make.right.equalTo(weakSelf.cellView).with.offset(Padding);
            make.height.mas_equalTo(20);
        }];
    }
    //头像
    [self.avatarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(@40);
        make.left.mas_equalTo(Padding);
        make.top.equalTo(weakSelf.timeLabel.mas_bottom).with.offset(10);
    }];
    
    //气泡
    [self.bubbleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.avatarBtn);
        make.left.equalTo(weakSelf.avatarBtn.mas_right).with.offset(10);
        make.bottom.equalTo(weakSelf.cellView).with.offset(Padding);
        make.width.equalTo(weakSelf.contentTextView.mas_width).with.offset(Padding *3);
    }];
    
    //文本
    [self.contentAreaView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.avatarBtn).with.offset(5);
        make.left.equalTo(weakSelf.avatarBtn).with.offset(20);
        make.height.mas_equalTo(_textHeight);
        make.width.mas_equalTo(_textWidth);
    }];
    
}


@end
