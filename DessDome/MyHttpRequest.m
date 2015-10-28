//
//  MyHttpRequest.m
//  DessDome
//
//  Created by Jack on 15/6/30.
//  Copyright (c) 2015年 zhr. All rights reserved.
//
#define kUrl @"http://napp.qida.com/app/"
//#define kUrl @"http://192.168.11.169:8080/qida-clm-app-webapp/"//郭培本地机器
//#define kUrl @"http://192.168.2.56:8080/qida-clm-app-webapp/"//张进本地机器

#define kBaseUrl [NSString stringWithFormat:@"%@",kUrl]
#import "MyHttpRequest.h"


#define kGetNoReadCount @"router.do?method=clm.user.noticebulletin.noReadCount"
#define kNoReadCountUrl @"router.do?method=clm.task.course.share.noReadCount"
#define kAccountInfoURL @"router.do?method=clm.user.info.get"

#define kDefaultTimeoutInterval 20 //默认超时时间
@implementation MyHttpRequest

/**
 *  通用请求方法,可以根据请求的线程对象作出响应管理
 *
 *  @param arguments 参数
 *  @param apiPath   接口路径
 *  @param success   请求成功回调
 *  @param fail      请求失败回调
 *
 *  @return 请求线程的对象
 */

AFHTTPRequestOperation  *MyCommonHttpRequest(id arguments,NSString *apiPaht,SuccessBlock success,FailBlock fail){
    AFHTTPRequestOperationManager  *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = kDefaultTimeoutInterval;
    //获取版本号
    //NSString  * localVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSString  *apiFullUrl = [NSString stringWithFormat:@"%@%@",kBaseUrl,apiPaht];
    AFHTTPRequestOperation  * op = [manager POST:apiFullUrl parameters:arguments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *errorCode = responseObject[@"errorCode"];
        if ([errorCode isEqualToString:@"11001003"] || [errorCode isEqualToString:@"11001015"] || [errorCode isEqualToString:@"11001008"]) {
                return;
            
        }else{
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        fail(error,operation.responseString);
    }];
    return op;
}
void QDHttpRequestExceptionHandler(ExceptionBlock exceptionBlock,id exceptionObject){
    NSInteger executeStatus = [exceptionObject[@"executeStatus"] integerValue];
    NSString *errorCode = [NSString stringWithFormat:@"%@",exceptionObject[@"errorCode"]];
    NSString *errorMsg = exceptionObject[@"errorMsg"];
    exceptionBlock(executeStatus,errorCode,errorMsg);
}
@end

















