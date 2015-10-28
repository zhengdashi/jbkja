//
//  CommentCoureView.h
//  DessDome
//
//  Created by Jack on 15/9/10.
//  Copyright (c) 2015年 zhr. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Course;
@class CourseDetail;
@class CourseComment;
@protocol CommentCoureViewDelegate <NSObject>
-(void)didClickCommentCoureTableCourseDetail:(CourseComment *)courseComment;

@end


@interface CommentCoureView : UIView
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) CourseDetail *detail;
@property (strong, nonatomic) Course *cour;
@property (assign, nonatomic) id<CommentCoureViewDelegate> delegate;

-(void)updateCommentCourseViewCourseDetail:(CourseDetail *)courseDetail;


@end
