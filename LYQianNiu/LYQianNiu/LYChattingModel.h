//
//  LYChattingModel.h
//  LYQianNiu
//
//  Created by Leonidas on 2017/3/17.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYChattingModel : NSObject
@property (nonatomic, strong) NSView *avatar;
@property (nonatomic, copy) NSString *timeStr;
@property (nonatomic, strong) XMPPMessageArchiving_Message_CoreDataObject *message;

@end
