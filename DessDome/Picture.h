//
//  Picture.h
//  DessDome
//
//  Created by Jack on 15/9/7.
//  Copyright (c) 2015年 zhr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Picture : NSManagedObject

@property (nonatomic, retain) NSString * gotoType;
@property (nonatomic, retain) NSString * imgUrl;
@property (nonatomic, retain) NSString * crsId;
@property (nonatomic, retain) NSString * originType;

@end
