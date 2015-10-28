//
//  LoginTool.h
//  DessDome
//
//  Created by Jack on 15/6/30.
//  Copyright (c) 2015年 zhr. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Account;
@interface LoginTool : NSObject
/**
 *  登录，登录成功即返回Account对象
 *
 *  @param username 用户名
 *  @param password 密码
 *  @param success  登录成功回调
 *  @param fail     登录失败回调
 */
+ (void)loginWithUsername:(NSString *)username andPassword:(NSString *)password  success:(void (^)(Account *account, NSString *errorCode ,NSString *errorMsg))success fail:(void (^)(NSError *error))fail;
@end
