//
//  CourseViewController.h
//  DessDome
//
//  Created by Jack on 15/9/9.
//  Copyright (c) 2015年 zhr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseTableView.h"
@class Course;
@interface CourseViewController : UIViewController
@property (strong, nonatomic) CourseTableView *tableView;

@property (strong, nonatomic) Course *cours;
@end
