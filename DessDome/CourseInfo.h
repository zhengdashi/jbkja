//
//  CourseInfo.h
//  DessDome
//
//  Created by Jack on 15/9/17.
//  Copyright (c) 2015年 zhr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CourseInfo : NSManagedObject

@property (nonatomic, retain) NSString * createDate;
@property (nonatomic) int32_t grad;
@property (nonatomic, retain) NSString * remark;
@property (nonatomic, retain) NSString * userName;
@property (nonatomic, retain) NSString * courseId;
@property (nonatomic, retain) NSString * oiginType;
@property (nonatomic, retain) NSString * totalcou;

@end
