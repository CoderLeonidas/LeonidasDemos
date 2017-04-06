//
//  Movie.m
//  UnitTest
//
//  Created by Leonidas on 2017/4/7.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "Movie.h"

@implementation Movie
- (id)initWithTitle:(NSString *)title
          priceCode:(int)priceCode {
    self = [super init];
    if (self) {
        _title = title;
        _priceCode = priceCode;
    }
    return self;
}
@end
