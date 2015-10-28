//
//  Account.h
//  DessDome
//
//  Created by Jack on 15/6/30.
//  Copyright (c) 2015年 zhr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject<NSCoding>
@property (nonatomic,copy)NSString *userId;        // --用户Id，用以区分不同的用户
@property (nonatomic, copy)NSString *username;     // --登录时输入的用户名
@property (nonatomic, copy)NSString *password;     // --登录时输入的密码
@property (nonatomic,copy)NSString *fullName;      // --用户的名称，比如管理员
@property (nonatomic,copy)NSString *bindPhone;      // --绑定的手机号码
@property (nonatomic,copy)NSString *sex;
@property (nonatomic,copy)NSString *siteName;      // --用户所属的公司名字
@property (nonatomic,copy)NSString *siteId;        // --公司Id
@property (nonatomic,copy)NSString *role;          // --用户角色
@property (nonatomic,assign)BOOL isExpUser;        // --是否体验用户
@property (nonatomic, copy)NSString *token;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *photoPath;
@property (nonatomic,assign) int order;
@property (nonatomic,assign) int message;
@property (nonatomic,assign) int isAdmin;
@property (nonatomic,assign) int noReadCount; //未读分享

@property (nonatomic, copy) NSString *channel;

- (id)initWithDict:(NSDictionary *)dict;

@end
