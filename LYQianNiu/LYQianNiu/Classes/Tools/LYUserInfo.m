//
//  LYUserInfo.m
//   
//
//  Created by Leon on 17/3/4.
//  Copyright (c) 2017年 Leon. All rights reserved.
//

#import "LYUserInfo.h"

#define UserKey @"user"
#define LoginStatusKey @"LoginStatus"
#define PwdKey @"pwd"



@implementation LYUserInfo

singleton_implementation(LYUserInfo)

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
