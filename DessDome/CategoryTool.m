//
//  CategoryTool.m
//  DessDome
//
//  Created by Jack on 15/9/21.
//  Copyright (c) 2015年 zhr. All rights reserved.
//

#import "CategoryTool.h"
#import "CourseCategory.h"
#import "DownTool.h"
#define kGetCategoryUrl @"router.do?method=clm.res.category.get"
@implementation CategoryTool

+(void)categoryListBySuccess:(void (^)(NSArray *, NSString *errorCode, NSString *errorMsg))success Fail:(void (^)(NSError *))fail{
    NSDictionary  *dic = @{
                           @"token":kToken
                           };
    MyCommonHttpRequest(dic, kGetCategoryUrl, ^(id responseObject) {
        if ([responseObject[@"executeStatus"]intValue]==0) {
           
            NSArray  * array = responseObject[@"values"];
            
            [CategoryTool deleteAllCategory];
            [CategoryTool addCategoryByArray:array];
            NSArray  * goryArray = [CategoryTool fetchArray];
            success(goryArray,nil,nil);
        }
        
    }, ^(NSError *error, NSString *responseString) {
        
        
    });
}
+(void)deleteAllCategory{
    [DownTool deleteDataByEntityName:@"CourseCategory" PredicateWhitFrome:nil];
}
+(void)addCategoryByArray:(NSArray *)array{
    for (NSDictionary  * dict in array) {
        NSArray  * arr = dict[@"content"];
        for (NSDictionary  * dic in arr) {
            CourseCategory   * category = [NSEntityDescription insertNewObjectForEntityForName:@"CourseCategory" inManagedObjectContext:kAppDelegate.managedObjectContext];
            category.categoryId = [NSString stringWithFormat:@"%@",dic[@"id"]];
            category.categoryName = dic[@"categoryName"];
            category.isHidden = [dic[@"isHidden"] boolValue];
            category.title = dict[@"title"];
            [DownTool saveDatabase];
        }
    }
}
+(NSArray *)fetchArray{
    return [DownTool getDataByEntityName:@"CourseCategory" PredicateWhitFrome:nil];
}
@end










