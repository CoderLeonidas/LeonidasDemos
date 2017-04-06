//
//  Customer.m
//  UnitTest
//
//  Created by Leonidas on 2017/4/7.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "Customer.h"
#import "Demand.h"
#import "Movie.h"
@interface Customer () {
    NSString *_name;
    NSMutableArray *_demands;
}
@end
@implementation Customer
- (id)initCustomerWithName:(NSString *)name {
    self = [super init];
    if (self) {
        _name = name;
    }
    return self;
}

- (void)addDemand:(Demand *)demand {
    if (!_demands) {
        _demands = [[NSMutableArray alloc] init];
    }
    [_demands addObject:demand];
}

- (NSString *)statement {
    double totalAmount = 0;
    int frequentDemandPotnts = 0;
    NSMutableString *result = [NSMutableString stringWithFormat:@"%@的点播清单\\\\n", _name];
    for (Demand *aDemand in _demands) {
        double thisAmount = 0;
        
        // 根据不同电影定价：
        switch (aDemand.movie.priceCode) {
            case MovieEnumRegular:
                thisAmount += 2; // 普通电影2元一次
                break;
                
            case MovieEnumNewRelease:
                thisAmount += 3; // 新电影3元一次
                break;
                
            case MovieEnumChildrens:
                thisAmount += 1.5; // 儿童电影1.5元一次
        }
        
        // 根据不同时段定价：
        if (aDemand.timePeriod == TimePeriodEnumWorkDaytime)
            thisAmount *= 1.0; // 工作日全价
        else if (aDemand.timePeriod == TimePeriodEnumWeekend) {
            thisAmount *= 0.5; // 周末半价
        } else if (aDemand.timePeriod == TimePeriodEnumWorkNight){
            thisAmount *= 1.5; // 下班1.5倍
        }
        
        frequentDemandPotnts++;
        // 周末点播新片积分翻倍：
        if ((aDemand.movie.priceCode == MovieEnumNewRelease) &&
            aDemand.timePeriod == TimePeriodEnumWeekend) {
            frequentDemandPotnts++;
        }
        
        [result appendFormat:@"\\\\t%@\\\\t%@ 元\\\\n", aDemand.movie.title, @(thisAmount)];
        totalAmount += thisAmount;
    }
    
    [result appendFormat:@"费用总计 %@ 元\\\\n", @(totalAmount).stringValue];
    [result appendFormat:@"获得积分 %@", @(frequentDemandPotnts).stringValue];
    
    return result;
}

@end
