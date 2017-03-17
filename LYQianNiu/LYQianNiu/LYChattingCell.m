//
//  LYChattingCell.m
//  LYQianNiu
//
//  Created by Leonidas on 2017/3/17.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "LYChattingCell.h"

@interface LYChattingCell ()
@property (strong) IBOutlet LYChattingCell *celllView;

@property (weak) IBOutlet NSScrollView *contentAreaView;//内容区域
@end

@implementation LYChattingCell

- (instancetype)init {
    if (self = [super init]) {
        NSString* nibName = NSStringFromClass([self class]);
        if ([[NSBundle mainBundle] loadNibNamed:nibName
                                          owner:self
                                topLevelObjects:nil]) {
            [self.celllView setFrame:[self bounds]];
            [self addSubview:self.celllView];
            //加这句是为了禁用textview的编辑，聊天气泡中不需要支持编辑
            [self.contentTextView setEditable:NO];
        }
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

@end
