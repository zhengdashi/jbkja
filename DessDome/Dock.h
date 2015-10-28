//
//  Dock.h
//  DessDome
//
//  Created by Jack on 15/6/30.
//  Copyright (c) 2015年 zhr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Dock : UIView
//添加选项卡（图标，文字标题）
-(void)addDockItemWithIcon:(NSString *)icon title:(NSString *)title;
@property (copy, nonatomic) void (^itemClickBlock)(int index);
@property (assign, nonatomic) int  selectedIndex;

@end
