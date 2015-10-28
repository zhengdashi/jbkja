//
//  UIScrollView+Plus.m
//  QD
//
//  Created by Jack on 15/4/14.
//  Copyright (c) 2015年 深圳企大信息技术有限公司. All rights reserved.
//

#import "UIScrollView+Plus.h"

@implementation UIScrollView (Plus)

- (void)killScroll
{
    CGPoint offset = self.contentOffset;
    offset.x -= 1.0;
    offset.y -= 1.0;
    [self setContentOffset:offset animated:NO];
    offset.x += 1.0;
    offset.y += 1.0;
    [self setContentOffset:offset animated:NO];
}

@end
