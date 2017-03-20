//
//  LYChattingCellView.h
//  LYQianNiu
//
//  Created by Leonidas on 2017/3/20.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LYChattingCellFrame.h"

@interface LYChattingCellView : NSView
+ (instancetype)cellWithTableView:(NSTableView *)tableView;

@property (nonatomic, strong) LYChattingCellFrame *cellFrame;

@end
