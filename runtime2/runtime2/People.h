//
//  People.h
//  runtime2
//
//  Created by Leonidas on 2017/4/11.
//  Copyright © 2017年 Leon. All rights reserved.
// 获取对象所有的属性名称和属性值、获取对象所有成员变量名称和变量值、获取对象所有的方法名和方法参数数量

#import <Foundation/Foundation.h>

@interface People : NSObject
{
    NSString *_occupation;
    NSString *_nationality;
}

@property (nonatomic, copy) NSString *name;
@property (nonatomic) NSUInteger age;

- (NSDictionary *)allProperties;
- (NSDictionary *)allIvars;
- (NSDictionary *)allMethods;

@end
