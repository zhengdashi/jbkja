//
//  CourseInfoCell.h
//  DessDome
//
//  Created by Jack on 15/9/17.
//  Copyright (c) 2015年 zhr. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CourseInfo;
@interface CourseInfoCell : UITableViewCell{
    
}
@property (strong, nonatomic) CourseInfo *courseInfo;

-(void)setCourseInfo:(CourseInfo *)courseInfo isEnxcel:(BOOL)isEnx;
-(void)setCourseInfoBlock:(void(^)())block;

+(instancetype)cell;

@end
