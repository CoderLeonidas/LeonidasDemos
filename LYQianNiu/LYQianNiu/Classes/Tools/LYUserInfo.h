//
//  LYUserInfo.h
//   
//
//  Created by Leon on 17/3/4.
//  Copyright (c) 2017年 Leon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

static NSString *domain = @"luoyang.local";

@interface LYUserInfo : NSObject

singleton_interface(LYUserInfo);

#pragma mark - 用户注册登录相关信息
@property (nonatomic, copy) NSString *user;//用户名
@property (nonatomic, copy) NSString *pwd;//密码

/**
 *  登录的状态 YES 登录过/NO 注销
 */
@property (nonatomic, assign) BOOL  loginStatus;

@property (nonatomic, copy) NSString *registerUser;//注册的用户名
@property (nonatomic, copy) NSString *registerPwd;//注册的密码
@property (nonatomic, copy) NSString *jid;



#pragma mark - 用户配置信息

@property (nonatomic, assign) BOOL autoLogin;//自动登录
@property (nonatomic, assign) BOOL rememberPwd;//记住密码

/**
 *  从沙盒里获取用户数据
 */
-(void)loadUserInfoFromSanbox;

/**
 *  保存用户数据到沙盒
 */
-(void)saveUserInfoToSanbox;
@end
