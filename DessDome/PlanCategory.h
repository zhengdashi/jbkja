//
//  PlanCategory.h
//  DessDome
//
//  Created by Jack on 15/9/23.
//  Copyright (c) 2015年 zhr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface PlanCategory : NSManagedObject

@property (nonatomic, retain) NSString * companyId;
@property (nonatomic) int32_t displaySeq;
@property (nonatomic) int32_t folderCount;
@property (nonatomic) BOOL isInternal;
@property (nonatomic, retain) NSString * name;
@property (nonatomic) int32_t objectCount;
@property (nonatomic, retain) NSString * pid;
@property (nonatomic, retain) NSString * planCategoryId;

@end
