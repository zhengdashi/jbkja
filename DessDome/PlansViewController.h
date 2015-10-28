//
//  PlansViewController.h
//  DessDome
//
//  Created by Jack on 15/9/23.
//  Copyright (c) 2015年 zhr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlansViewController : UIViewController

@property (copy, nonatomic) NSString  *categoryId;
@property (assign, nonatomic) BOOL isHidden;
@property (assign, nonatomic) BOOL isInternal;
@property (assign, nonatomic) BOOL isLecturer;
@end
