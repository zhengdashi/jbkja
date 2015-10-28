//
//  MyOnlyToolClass.h
//  DessDome
//
//  Created by zhr on 15/7/7.
//  Copyright (c) 2015年 zhr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyOnlyToolClass : NSObject
/**
 *  提示信息
 */
+(void)showAlert:(NSString *)title message:(NSString *)message;

/**
 *  含delegate的提示框
 */
+ (void)showAlert:(NSString *)title message:(NSString *)message delegate:(id)delegate;
/**
 *  验证邮箱格式
 */
+ (BOOL)checkMailIsValidate:(NSString *)mail;
/**
 *  校验身份证
 */
+(BOOL)checkIdentityCardNo:(NSString*)cardNo;
/**
 *  判断是否包含特殊字符
 */
+ (BOOL)isIncludeSpecialChaaract:(NSString *)str;
/**
 *  获得文件大小
 */
long long ZHGetFileSize(NSString *path);

@end
