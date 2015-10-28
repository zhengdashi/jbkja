//
//  CourseInfoView.h
//  DessDome
//
//  Created by Jack on 15/9/10.
//  Copyright (c) 2015年 zhr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseDetail.h"

@class CourseDetail;
@interface CourseInfoView : UIView
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) CourseDetail *detail;
/**
 *  请求课程评论
 *
 *  @param comment 课程详情
 */
-(void)updateCourseInfoifCourseComment:(CourseDetail *)comment;

@end
