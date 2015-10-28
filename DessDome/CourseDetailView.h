//
//  CourseDetailView.h
//  DessDome
//
//  Created by Jack on 15/9/9.
//  Copyright (c) 2015年 zhr. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Course;
@protocol CourseDeatilViewDelegate <NSObject>
-(void)courseDetaeilViewClickTit:(NSInteger)index;

@end



@interface CourseDetailView : UIView
@property (strong, nonatomic) Course *cours;
@property (assign, nonatomic) id<CourseDeatilViewDelegate> delegate;
+(id)detailView;
@end
