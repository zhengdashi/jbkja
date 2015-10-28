//
//  IntroCourseCell.h
//  DessDome
//
//  Created by Jack on 15/9/14.
//  Copyright (c) 2015年 zhr. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CourseDetail;

@interface IntroCourseCell : UITableViewCell
@property (strong, nonatomic) CourseDetail *detail;
+(instancetype)cell;

@end
