//
//  People+Associated.m
//  runtime3
//
//  Created by Leonidas on 2017/4/11.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "People+Associated.h"

#if TARGET_IPHONE_SIMULATOR
#import <objc/objc-runtime.h>
#else
#import <objc/runtime.h>
#import <objc/message.h>
#endif

static const NSString *associatedBustKey = @"associatedBust";
static const NSString *associatedCallBackKey = @"associatedCallBack";

@implementation People (Associated)
- (void)setAssociatedBust:(NSNumber *)associatedBust {
    //设置关联对象
    objc_setAssociatedObject(self, (__bridge const void *)(associatedBustKey), associatedBust, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSNumber *)associatedBust {
    //得到关联对象
    return objc_getAssociatedObject(self, (__bridge const void *)(associatedBustKey));
}

- (void)setAssociatedCallBack:(CodingCallBack)associatedCallBack {
    objc_setAssociatedObject(self, @selector(associatedCallBack), associatedCallBack, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CodingCallBack)associatedCallBack {
    return objc_getAssociatedObject(self, @selector(associatedCallBack));
}


@end
