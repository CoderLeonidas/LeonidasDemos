

//
//  LYChattingCellModel.m
//  LYQianNiu
//
//  Created by Leonidas on 2017/3/17.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "LYChattingCellModel.h"

@implementation LYChattingCellModel

//TODO timeStamp 先返回假数据 获取有问题
- (NSDate*) timeStamp{
    if (!_timeStamp) {
        _timeStamp = [NSDate date];
    }
    return _timeStamp;
}

@end
