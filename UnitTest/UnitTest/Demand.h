//
//  Demand.h
//  UnitTest
//
//  Created by Leonidas on 2017/4/7.
//  Copyright © 2017年 Leon. All rights reserved.
// 点播类

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, TimePeriodEnum) {
    TimePeriodEnumWorkDaytime = 1,
    TimePeriodEnumWorkNight = 2,
    TimePeriodEnumWeekend = 3
};

@class Movie;
@interface Demand : NSObject
@property(nonatomic) Movie *movie;
@property(nonatomic, assign) int timePeriod;

- (id)initWithMovie:(Movie *)movie
timePeriod:(TimePeriodEnum)timePeriod;

@end
