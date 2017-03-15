//
//  LYChattingTool.m
//  LYQianNiu
//
//  Created by Leonidas on 2017/3/15.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "LYChattingTool.h"

@implementation LYChattingTool

@synthesize allChattingContactModels = _allChattingContactModels;

@synthesize currentChattingContactModel = _currentChattingContactModel;
singleton_implementation(LYChattingTool)

- (void)setallChattingContactModels:(XMPPUserCoreDataStorageObject *)currentChattingContactModel {
    if (!currentChattingContactModel || [currentChattingContactModel isEqualTo:_currentChattingContactModel]) return;
    
    _currentChattingContactModel = currentChattingContactModel;
    //若联系人列表中没有就将其加入
    if (![self.allChattingContactModels containsObject:currentChattingContactModel]) {
        [self.allChattingContactModels addObject:currentChattingContactModel];
    }
}

- (XMPPUserCoreDataStorageObject *)currentChattingContactModel {
    return _currentChattingContactModel;
}

- (NSMutableArray *)allChattingContactModels {
    if (!_allChattingContactModels){
        _allChattingContactModels = [NSMutableArray array];
    }
    return _allChattingContactModels;
}

@end
