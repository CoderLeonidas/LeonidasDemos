//
//  Demand.m
//  UnitTest
//
//  Created by Leonidas on 2017/4/7.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "Demand.h"
#import "Movie.h"

@implementation Demand
- (id)initWithMovie:(Movie *)movie
         timePeriod:(TimePeriodEnum)timePeriod {
    self = [super init];
    if (self) {
        _movie = movie;
        _timePeriod = timePeriod;
    }
    return self;
}
@end
