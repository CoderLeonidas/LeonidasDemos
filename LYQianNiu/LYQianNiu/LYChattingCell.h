//
//  LYChattingCell.h
//  LYQianNiu
//
//  Created by Leonidas on 2017/3/17.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LYChattingCellModel.h"
#import "LYChattingCellFrame.h"
@interface LYChattingCell : NSTableCellView

+ (instancetype)cellWithTableView:(NSTableView *)tableView;

@property (nonatomic, strong) LYChattingCellFrame *cellFrame;
@end
