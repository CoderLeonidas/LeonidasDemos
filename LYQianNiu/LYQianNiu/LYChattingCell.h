//
//  LYChattingCell.h
//  LYQianNiu
//
//  Created by Leonidas on 2017/3/17.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface LYChattingCell : NSTableCellView
@property (weak) IBOutlet NSButton *avatarBtn;//头像
@property (weak) IBOutlet NSTextField *timeLbl;//时间
@property (unsafe_unretained) IBOutlet NSTextView *contentTextView;//内容
@end
