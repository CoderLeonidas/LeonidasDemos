//
//  People+Associated.h
//  runtime3
//
//  Created by Leonidas on 2017/4/11.
//  Copyright © 2017年 Leon. All rights reserved.
// 通过分类并结合runtime的关联对象，给People添加属性和回调(如果不用关联对象就会报错)

#import "People.h"

typedef void (^CodingCallBack)();

@interface People (Associated)

@property (nonatomic, strong) NSNumber *associatedBust;//胸围
@property (nonatomic, copy) CodingCallBack associatedCallBack;//写代码
@end
