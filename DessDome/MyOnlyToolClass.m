//
//  MyOnlyToolClass.m
//  DessDome
//
//  Created by zhr on 15/7/7.
//  Copyright (c) 2015年 zhr. All rights reserved.
//

#import "MyOnlyToolClass.h"
#import "NSString+Check.h"

@implementation MyOnlyToolClass
/**
 *  提示信息
 */
+(void)showAlert:(NSString *)title message:(NSString *)message{
    UIAlertView  *aler = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil, nil];
    [aler show];
}
/**
 *  含delegate的提示框
 */
+ (void)showAlert:(NSString *)title message:(NSString *)message delegate:(id)delegate{
    UIAlertView  *aler = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:delegate
                                          cancelButtonTitle:@"取消"
                                          otherButtonTitles:@"确定", nil];
    [aler show];
}
/**
 *  验证邮箱格式
 */
+ (BOOL)checkMailIsValidate:(NSString *)mail{
    return [mail checkEmail];
}
/**
 *  校验身份正好
  */
+(BOOL)checkIdentityCardNo:(NSString*)cardNo{
    if (cardNo.length != 18) {
        return  NO;
    }
    NSArray* codeArray = [NSArray arrayWithObjects:@"7",@"9",@"10",@"5",@"8",@"4",@"2",@"1",@"6",@"3",@"7",@"9",@"10",@"5",@"8",@"4",@"2", nil];
    NSDictionary* checkCodeDic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1",@"0",@"X",@"9",@"8",@"7",@"6",@"5",@"4",@"3",@"2", nil]  forKeys:[NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil]];
    
    NSScanner* scan = [NSScanner scannerWithString:[cardNo substringToIndex:17]];
    
    int val;
    BOOL isNum = [scan scanInt:&val] && [scan isAtEnd];
    if (!isNum) {
        return NO;
    }
    int sumValue = 0;
    
    for (int i =0; i<17; i++) {
        sumValue+=[[cardNo substringWithRange:NSMakeRange(i , 1) ] intValue]* [[codeArray objectAtIndex:i] intValue];
    }
    
    NSString* strlast = [checkCodeDic objectForKey:[NSString stringWithFormat:@"%d",sumValue%11]];
    
    if ([strlast isEqualToString: [[cardNo substringWithRange:NSMakeRange(17, 1)]uppercaseString]]) {
        return YES;
    }
    return  NO;

}
/**
 *  判断是否包含特殊字符
 */
+ (BOOL)isIncludeSpecialChaaract:(NSString *)str{
    
    //***需要过滤的特殊字符：~￥#&*<>《》()[]{}【】^@/￡¤￥|§¨「」『』￠￢￣~@#￥&*（）——+|《》$_€。
    NSRange urgentRange = [str rangeOfCharacterFromSet: [NSCharacterSet characterSetWithCharactersInString: @",;~￥#&*<>《》()[]{}【】^@/￡¤￥|§¨「」『』￠￢￣~@#￥&*（）——+|《》$-€"]];
    if (urgentRange.location == NSNotFound)
    {
        return NO;
    }
    return YES;
}
/**
 *  获得文件大小
 */
long long ZHGetFileSize(NSString *path){
    signed long long fileSize = 0;
    NSFileManager *fileManager = [NSFileManager new]; // default is not thread safe
    if ([fileManager fileExistsAtPath:path]) {
        NSError *error = nil;
        NSDictionary *fileDict = [fileManager attributesOfItemAtPath:path error:&error];
        if (!error && fileDict) {
            fileSize = [fileDict fileSize];
        }
    }
    return fileSize;
}


@end
