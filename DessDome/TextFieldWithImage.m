//
//  TextFieldWithImage.m
//  Lecturer
//
//  Created by 张鹏 on 14-3-8.
//  Copyright (c) 2014年 Qida. All rights reserved.
//

#import "TextFieldWithImage.h"

@interface TextFieldWithImage ()
{
    UIImageView *_imageView;
}
@end

@implementation TextFieldWithImage

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(CGRect)textRectForBounds:(CGRect)bounds
{
    CGRect frame = bounds;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
//        frame.origin.y += 10;
    }
    frame.origin.x += 40;
    frame.size.width -=40;
    return frame;
}
-(CGRect)placeholderRectForBounds:(CGRect)bounds
{
    CGRect frame = bounds;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
//        frame.origin.y += 10;
    }
    frame.origin.x += 40;
    frame.size.width -=40;
    return frame;
}

-(CGRect)editingRectForBounds:(CGRect)bounds
{
    CGRect frame = bounds;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
//        frame.origin.y += 10;
    }
    frame.origin.x += 40;
    frame.size.width -=40;
    return frame;
}



-(void)setImageUrl:(NSString *)imageUrl
{
    _imageView = [[UIImageView alloc]init];
   
        _imageView.frame = CGRectMake(10, 10, 20, 20);
    
    [self addSubview:_imageView];
    self.backgroundColor = [UIColor whiteColor];
    _imageView.image = [UIImage imageNamed:imageUrl];
}

@end
