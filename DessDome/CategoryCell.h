//
//  CategoryCell.h
//  DessDome
//
//  Created by Jack on 15/9/22.
//  Copyright (c) 2015年 zhr. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CourseCategory;

@interface CategoryCell : UITableViewCell
@property (strong, nonatomic) NSIndexPath *index;
@property (strong, nonatomic) CourseCategory *category;
+(instancetype)cell;

@end
