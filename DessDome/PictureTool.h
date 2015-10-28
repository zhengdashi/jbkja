//
//  PictureTool.h
//  DessDome
//
//  Created by Jack on 15/9/7.
//  Copyright (c) 2015年 zhr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PictureTool : NSObject
/**
 *  获得图片
 *
 *  @param success 成功
 *  @param fail    失败
 */
+(void)pictureListBySuccess:(void(^)(NSArray  *pictureList,NSString  *errorCode,NSString  *errorMsg))success Fail:(void(^)(NSString *error))fail;
/**
 *  获得图片对象
 *
 *  @param array 数组
 */
+(void)addPicturListArray:(NSArray *)array;
/**
 *  获取图片数组
 *
 *  @return jieguo
 */
+(NSArray  *)picturArray;
/**
 *  删除实例
 */
+(void)deleGateArray;

@end
