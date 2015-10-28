//
//  PlanTool.h
//  DessDome
//
//  Created by Jack on 15/9/22.
//  Copyright (c) 2015年 zhr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlanTool : NSObject
/**
 *  获取分类
 */
+(void)planCategoryListByPlanPid:(NSString *)pid IsInternal:(BOOL)isInternal Success:(void(^)(NSArray *planArray,NSString *errorCode,NSString *errorMsg))success Fail:(void(^)(NSError * error))fail;






@end
@interface PlanTool (planCatedate)
/**
 *  添加计划分类到数据库
 *
 *  @param array      计划分类数组
 *  @param isInternal 是否企业内部
 */
+ (void)addPlanCategoryByArray:(NSArray *)array IsInternal:(BOOL)isInternal;


@end















