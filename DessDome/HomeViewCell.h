//
//  HomeViewCell.h
//  DessDome
//
//  Created by Jack on 15/9/9.
//  Copyright (c) 2015年 zhr. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Course;
@interface HomeViewCell : UITableViewCell
@property (strong, nonatomic) Course *cour;

+(instancetype)cell;
@end
