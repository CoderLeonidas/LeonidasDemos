//
//  Movie.h
//  UnitTest
//
//  Created by Leonidas on 2017/4/7.
//  Copyright © 2017年 Leon. All rights reserved.
// 电影类


#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, MovieEnum) {
    MovieEnumChildrens = 2,
    MovieEnumRegular = 0,
    MovieEnumNewRelease = 1
};

@interface Movie : NSObject
@property(nonatomic, copy) NSString *title;
@property(nonatomic) int priceCode;

- (id)initWithTitle:(NSString *)title
          priceCode:(int)priceCode;
@end
