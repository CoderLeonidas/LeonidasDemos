//
//  LYContactTableCellView.h
//  LYQianNiu
//
//  Created by Leonidas on 2017/3/15.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LYContactModel.h"

@interface LYContactTableCellView : NSTableCellView
@property (nonatomic, strong) XMPPUserCoreDataStorageObject *model;

+ (instancetype)contactTableCellView;
@end
