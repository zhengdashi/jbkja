//
//  NSString+Check.h
//  DessDome
//
//  Created by Jack on 15/7/7.
//  Copyright (c) 2015年 zhr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Check)
/**
 *  验证手机格式
 */
- (BOOL)checkPhoneNumber;
/**
 *  验证邮箱格式
 */
- (BOOL)checkEmail;

@end
