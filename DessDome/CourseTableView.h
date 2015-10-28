//
//  CourseTableView.h
//  DessDome
//
//  Created by Jack on 15/9/10.
//  Copyright (c) 2015年 zhr. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    ShowDetaileIntroduction,//简介
    ShowDetaileChapter,//章节
    ShowDetaileComment//评论
}ShowDetaileType;


@interface CourseTableView : UITableView{
    
}
@property (assign, nonatomic) ShowDetaileType showType;
@end
