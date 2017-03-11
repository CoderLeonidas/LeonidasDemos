//
//  WCUserInfo.m
//  WeChat
//
//  Created by Leon on 17/3/4.
//  Copyright (c) 2017年 Leon. All rights reserved.
//

#import "WCUserInfo.h"

#define UserKey @"user"
#define LoginStatusKey @"LoginStatus"
#define PwdKey @"pwd"



@implementation WCUserInfo

singleton_implementation(WCUserInfo)

-(void)saveUserInfoToSanbox{

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.user forKey:UserKey];
    [defaults setBool:self.loginStatus forKey:LoginStatusKey];
    [defaults setObject:self.pwd forKey:PwdKey];
    [defaults synchronize];
}

-(void)loadUserInfoFromSanbox{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.user = [defaults objectForKey:UserKey];
    self.loginStatus = [defaults boolForKey:LoginStatusKey];
    self.pwd = [defaults objectForKey:PwdKey];
}


-(NSString *)jid{
    return [NSString stringWithFormat:@"%@@%@",self.user,domain];
}
@end
