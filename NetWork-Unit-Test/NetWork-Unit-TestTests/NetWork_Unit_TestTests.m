//
//  NetWork_Unit_TestTests.m
//  NetWork-Unit-TestTests
//
//  Created by Leonidas on 2017/4/7.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <AFNetworking.h>
#import <OCMock.h>
#import "AFHTTPSessionManager.h"
@interface NetWork_Unit_TestTests : XCTestCase

@end

@implementation NetWork_Unit_TestTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}
- (void)testNetwork {
    id mockManager = [OCMockObject mockForClass:[AFHTTPSessionManager class]];
    
    [[[mockManager expect] andDo:^(NSInvocation *invocation) {
        
        void (^successBlock)(NSURLSessionDataTask *task, id responseObject) = nil;
        
        [invocation getArgument:&successBlock atIndex:(2+3)];
        
        successBlock([[NSURLSessionDataTask alloc] init], @{@"keyTest":@"valueTest"});
        
    }] POST:[OCMArg any] parameters:nil progress:[OCMArg any] success:[OCMArg any] failure:[OCMArg any]];
    
    
    [mockManager POST:@"any path" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        XCTAssertEqual(@"valueTest", responseObject[@"keyTest"]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

@end
