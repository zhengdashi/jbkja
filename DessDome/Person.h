//
//  Person.h
//  DessDome
//
//  Created by Jack on 15/7/2.
//  Copyright (c) 2015年 zhr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Person : NSManagedObject

@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSString * firstname;
@property (nonatomic, retain) NSString * lastname;

@end
