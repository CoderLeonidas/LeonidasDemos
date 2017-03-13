//
//  LYUserInfo.m
//   
//
//  Created by Leon on 17/3/4.
//  Copyright (c) 2017年 Leon. All rights reserved.
//

#import "LYUserInfo.h"

#define UserKey @"User"
#define LoginStatusKey @"LoginStatus"
#define PwdKey @"Pwd"
#define AutoLoginKey @"AutoLogin"
#define RemeberPwdKey @"RemeberPwd"

@implementation LYUserInfo

singleton_implementation(LYUserInfo)

-(void)saveUserInfoToSanbox{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.user forKey:UserKey];
    [defaults setBool:self.loginStatus forKey:LoginStatusKey];
    [defaults setObject:self.pwd forKey:PwdKey];
    [defaults setBool:self.autoLogin forKey:AutoLoginKey];
    [defaults setBool:self.rememberPwd forKey:RemeberPwdKey];
    
    [defaults synchronize];
}

-(void)loadUserInfoFromSanbox{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.user = [defaults objectForKey:UserKey];
    self.loginStatus = [defaults boolForKey:LoginStatusKey];
    self.pwd = [defaults objectForKey:PwdKey];
    self.autoLogin = [defaults boolForKey:AutoLoginKey];
    self.rememberPwd = [defaults boolForKey:RemeberPwdKey];
}


-(NSString *)jid{
    return [NSString stringWithFormat:@"%@@%@",self.user,domain];
}
@end
