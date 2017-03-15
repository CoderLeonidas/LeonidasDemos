//
//  LYChattingTool.h
//  LYQianNiu
//
//  Created by Leonidas on 2017/3/15.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

@interface LYChattingTool : NSObject

singleton_interface(LYChattingTool);
@property (nonatomic, strong, readonly) NSMutableArray *allChattingContactModels;//今天已经聊过天的店铺
@property (nonatomic, strong) XMPPUserCoreDataStorageObject *currentChattingContactModel;//当前正在聊天的店小二的信息

@end
