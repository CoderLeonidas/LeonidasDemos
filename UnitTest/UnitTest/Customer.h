//
//  Customer.h
//  UnitTest
//
//  Created by Leonidas on 2017/4/7.
//  Copyright © 2017年 Leon. All rights reserved.
// 顾客类

#import <Foundation/Foundation.h>

@class Demand;
@interface Customer : NSObject
- (id)initCustomerWithName:(NSString *)name;
- (void)addDemand:(Demand *)demand;
- (NSString *)statement;
@end
