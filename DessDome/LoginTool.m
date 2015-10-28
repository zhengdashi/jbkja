//
//  LoginTool.m
//  DessDome
//
//  Created by Jack on 15/6/30.
//  Copyright (c) 2015年 zhr. All rights reserved.
//
#define kLoginUrl @"pub/router.do?method=clm.system.login"

#import "LoginTool.h"
#import "MyHttpRequest.h"
#import "Account.h"

//@class Account;
@implementation LoginTool
+(void)loginWithUsername:(NSString *)username andPassword:(NSString *)password success:(void (^)(Account *account, NSString *, NSString *))success fail:(void (^)(NSError *))fail{
    NSDictionary  *dic = @{
                           @"account":username,
                           @"password":password
                           };
    MyCommonHttpRequest(dic, kLoginUrl, ^(id responseObject) {
        if (success) {
            if ([responseObject[@"executeStatus"]intValue]==0) {
                NSDictionary  * dic = responseObject[@"values"];
                Account *account =[[Account alloc]initWithDict:dic];
                success(account,nil,nil);
            }else{
                
            }
        }
        
        
    }, ^(NSError *error, NSString *responseString) {
        
    });
    
    
}



@end
