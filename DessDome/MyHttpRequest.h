//
//  MyHttpRequest.h
//  DessDome
//
//  Created by Jack on 15/6/30.
//  Copyright (c) 2015年 zhr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

/**
 *  请求成功回调
 *
 *  @param responseObject 请求成功返回的数据
 */
typedef void(^SuccessBlock)(id responseObject);

/**
 *  请求异常回调
 *
 *  @param errorCode 错误代码
 *  @param errorMsg  错误信息
 */

typedef void(^ExceptionBlock)(BOOL isSuccess,NSString *errorCode ,NSString *errorMsg);

/**
 *  请求失败的回调
 *
 *  @param error          请求失败的错误
 *  @param responseString 请求失败返回信息
 */
typedef void(^FailBlock)(NSError *error,NSString *responseString);


@interface MyHttpRequest : NSObject

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
AFHTTPRequestOperation  *MyCommonHttpRequest(id arguments,NSString *apiPaht,SuccessBlock success,FailBlock fail);
/**
 *  请求通用异常处理
 *
 *  @param exceptionBlock  处理异常的block
 *  @param exceptionObject 异常请求信息
 */
void QDHttpRequestExceptionHandler(ExceptionBlock exceptionBlock,id exceptionObject);


@end






















