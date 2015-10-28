//
//  IntroCourseView.h
//  DessDome
//
//  Created by Jack on 15/9/10.
//  Copyright (c) 2015年 zhr. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CourseDetail;
@interface IntroCourseView : UIView
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) CourseDetail *detail;

-(void)courseDetail:(CourseDetail *)detail;
@end
