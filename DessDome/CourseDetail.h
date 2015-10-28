//
//  CourseDetail.h
//  DessDome
//
//  Created by Jack on 15/9/14.
//  Copyright (c) 2015年 zhr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CourseDetail : NSManagedObject

@property (nonatomic, retain) NSString * countNote;
@property (nonatomic, retain) NSString * courseId;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSString * folderName;
@property (nonatomic, retain) NSString * grade;
@property (nonatomic, retain) NSString * imgPath;
@property (nonatomic) BOOL isHidden;
@property (nonatomic) BOOL isNew;
@property (nonatomic) BOOL isParticipate;
@property (nonatomic) BOOL isPerfect;
@property (nonatomic) int32_t isTask;
@property (nonatomic, retain) NSString * learnStatus;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * originType;
@property (nonatomic) int32_t progressRate;
@property (nonatomic, retain) NSString * status;
@property (nonatomic, retain) NSString * type;

@end
