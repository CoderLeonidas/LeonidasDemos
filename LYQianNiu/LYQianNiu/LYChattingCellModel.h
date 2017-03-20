//
//  LYChattingCellModel.h
//  LYQianNiu
//
//  Created by Leonidas on 2017/3/17.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYChattingCellModel : NSObject
@property (nonatomic, strong) NSImage *avatar;//头像
@property (nonatomic, copy) NSString *message;//消息内容
@property (nonatomic, assign) BOOL outgoing;//消息方向 YES为对方发出，NO为我发出
@property (nonatomic, copy) NSDate *timeStamp;//时间戳

@end
