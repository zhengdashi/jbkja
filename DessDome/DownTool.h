//
//  DownTool.h
//  DessDome
//
//  Created by Jack on 15/7/2.
//  Copyright (c) 2015年 zhr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DownTool : NSObject
/**
 *  存储当前数据库操作
 */
+(void)saveDatabase;
/**
 *  获取某个对象的实例
 *
 *  @param entityName 实体名称
 *  @param format     筛选格式
 *
 *  @return 查询结果
 */
+(NSArray *)getDataByEntityName:(NSString *)entityName PredicateWhitFrome:(NSString *)format;
/**
 *  删除数据
 *
 *  @param entityName 实体名称
 *  @param format     筛选格式
 */
+(void)deleteDataByEntityName:(NSString *)entityName PredicateWhitFrome:(NSString *)format;
/**
 *  删除某些数据
 *
 *  @param array 实体数组
 */
+(void)deleteDataByArray:(NSArray *)array;

@end
