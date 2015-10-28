//
//  DockItem.m
//  DessDome
//
//  Created by Jack on 15/6/30.
//  Copyright (c) 2015年 zhr. All rights reserved.
//
#define kImageRation 0.7
#import "DockItem.h"

@implementation DockItem
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:9];
        //保整图片不变形
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        //取消点击效果
        self.adjustsImageWhenHighlighted = YES;
        [self setBackgroundImage:[UIImage imageNamed:@"bg_biji2"] forState:UIControlStateSelected];
    }
    
    return self;
}
#pragma mark 返回是按钮内部UILabel的边框
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = contentRect.size.height * kImageRation - 5;
    CGFloat titleHeight = contentRect.size.height - titleY;
    return CGRectMake(0, titleY, contentRect.size.width, titleHeight);
}

#pragma mark 返回是按钮内部UIImageView的边框
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(5, 5, contentRect.size.width -10, contentRect.size.height * kImageRation -10);
}










/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
