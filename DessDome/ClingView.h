//
//  ClingView.h
//  HDEMO
//
//  Created by Jack on 15/2/9.
//  Copyright (c) 2015年 qida. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CLAnimationDuration 0.4 //动画执行时间

@interface ClingView : UIView

@property (strong, nonatomic)UIScrollView *clingScrollView;
@property (assign, nonatomic)CGFloat minShowHeight;
@property (assign, nonatomic)CGFloat maxShowHeight;

- (instancetype)initWithFrame:(CGRect)frame ClingScrollView:(UIScrollView *)aScrollView;

/**
 *  展开
 */
- (void)showExpand;

/**
 *  收缩
 */
- (void)showShrink;

@end
