//
//  CourseComment.h
//  DessDome
//
//  Created by Jack on 15/9/14.
//  Copyright (c) 2015年 zhr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CourseComment : NSManagedObject

@property (nonatomic, retain) NSString * contentType;
@property (nonatomic, retain) NSString * commentId;
@property (nonatomic) int32_t crsId;
@property (nonatomic) int32_t itemNum;
@property (nonatomic, retain) NSString * itemTitle;
@property (nonatomic, retain) NSString * itemUrl;
@property (nonatomic, retain) NSString * lessonStatus;
@property (nonatomic, retain) NSString * parentId;
@property (nonatomic, retain) NSString * sectionType;
@property (nonatomic, retain) NSString * type;
@property (nonatomic) float downloadProgress;
@property (nonatomic) int32_t downloadStatus;
@property (nonatomic) int64_t fileSize;
@property (retain, nonatomic) NSString *originType;
@property (nonatomic, retain) NSString * courseId;
@end
