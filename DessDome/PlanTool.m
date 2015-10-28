//
//  PlanTool.m
//  DessDome
//
//  Created by Jack on 15/9/22.
//  Copyright (c) 2015年 zhr. All rights reserved.
//
#define kPlanCategorysUrl @"router.do?method=clm.res.qida.plan.category.find"
#define kInternalPlanCategorysUrl @"router.do?method=clm.res.crs.plan.category.get"

#import "PlanTool.h"
#import "DownTool.h"
#import "PlanCategory.h"

@implementation PlanTool
//获取分类
+(void)planCategoryListByPlanPid:(NSString *)pid IsInternal:(BOOL)isInternal Success:(void (^)(NSArray *, NSString *, NSString *))success Fail:(void (^)(NSError *))fail{
    if (!pid) {
        return;
    }
    NSDictionary  * dic;
    if (isInternal) {
        dic = @{
                @"pid":pid,
                @"token":kToken
                };
    }else{
        dic = @{
                @"pid":pid,
                @"library":[NSNumber numberWithInt:0],
                @"token":kToken
                };
    }
    NSString *url = isInternal?kInternalPlanCategorysUrl:kPlanCategorysUrl;
    MyCommonHttpRequest(dic, url, ^(id responseObject) {
        if ([responseObject[@"executeStatus"] intValue]==0) {
            NSArray * values = responseObject[@"values"];
            [DownTool deleteDataByEntityName:@"PlanCategory" PredicateWhitFrome:[NSString stringWithFormat:@"pid == %@ && isInternal == %i",pid,isInternal]];
            [PlanTool addPlanCategoryByArray:values IsInternal:isInternal];
            NSArray  * playCategorys = [DownTool getDataByEntityName:@"PlanCategory" PredicateWhitFrome:[NSString stringWithFormat:@"pid == %@ && isInternal == %i",pid,isInternal]];
            success(playCategorys,nil,nil);
        }else{
            NSString *errorCode = [NSString stringWithFormat:@"%@",responseObject[@"errorCode"]];
            NSString *errorMsg = responseObject[@"errorMsg"];
            success(nil,errorCode,errorMsg);
            
        }
   
    }, ^(NSError *error, NSString *responseString) {
        
    });
    
    
}

@end

@implementation PlanTool (planCatedate)

+(void)addPlanCategoryByArray:(NSArray *)array IsInternal:(BOOL)isInternal{
    for (NSDictionary  *dic in array) {
        PlanCategory  * plan = [NSEntityDescription insertNewObjectForEntityForName:@"PlanCategory" inManagedObjectContext:kAppDelegate.managedObjectContext];
        plan.planCategoryId = [NSString stringWithFormat:@"%@",dic[@"id"]];
        plan.name = dic[@"name"];
        plan.pid = [NSString stringWithFormat:@"%@",dic[@"pid"]];
        if (!plan.pid || plan.pid.length == 0) {
            plan.pid = [NSString stringWithFormat:@"%@",dic[@"parentId"]];
        }
        
        plan.companyId = [NSString stringWithFormat:@"%@",dic[@"companyId"]];
        plan.displaySeq = [dic[@"displaySeq"] intValue];
        plan.objectCount = [dic[@"objectCount"] intValue];
        plan.isInternal = isInternal;
        [DownTool saveDatabase];
    }
}

@end














