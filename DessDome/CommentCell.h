//
//  CommentCell.h
//  DessDome
//
//  Created by Jack on 15/9/14.
//  Copyright (c) 2015年 zhr. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CourseComment;

@protocol CommentCellDelegate <NSObject>

-(void)clickCourseChapterCell:(CourseComment *)comment;
@end


@interface CommentCell : UITableViewCell

@property (strong, nonatomic) CourseComment *comment;
@property (assign, nonatomic) id<CommentCellDelegate>delegate;
-(void)setCourseComment:(CourseComment *)comment andIndex:(NSInteger)index andIsShowDownload:(BOOL)isDownload;

+(instancetype)cell;
@end
