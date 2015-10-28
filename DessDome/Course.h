//
//  Course.h
//  DessDome
//
//  Created by Jack on 15/9/9.
//  Copyright (c) 2015年 zhr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Course : NSManagedObject

@property (nonatomic, retain) NSString * courseId;
@property (nonatomic) int32_t grade;
@property (nonatomic, retain) NSString * imgPath;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * originType;
@property (nonatomic, retain) NSString * releaseDate;
@property (nonatomic, retain) NSString * courseType;

@end
