//
//  CategoryTool.h
//  DessDome
//
//  Created by Jack on 15/9/21.
//  Copyright (c) 2015年 zhr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryTool : NSObject
/**
 *  获得分类
 *
 *  @param success 成功
 *  @param fail    失败
 */
+(void)categoryListBySuccess:(void(^)(NSArray  *category,NSString *errorCode,NSString *errorMsg))success Fail:(void(^)(NSError  *error))fail;
/**
 *  删除对象
 */
+(void)deleteAllCategory;
/**
 *  添加实例
 *
 *  @param array 数组
 */
+(void)addCategoryByArray:(NSArray *)array;
/**
 *  返回对象示例数组
 *
 *  @return 数组
 */
+(NSArray *)fetchArray;

@end
