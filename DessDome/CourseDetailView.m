//
//  CourseDetailView.m
//  DessDome
//
//  Created by Jack on 15/9/9.
//  Copyright (c) 2015年 zhr. All rights reserved.
//

#import "CourseDetailView.h"
#import "TitleView.h"
#import "Course.h"
#import "UIImageView+WebCache.h"

@interface CourseDetailView ()<TitleViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *titImage;
@property (weak, nonatomic) IBOutlet UILabel *titLab;
@property (weak, nonatomic) IBOutlet UIImageView *scoreImage;
@property (strong, nonatomic) TitleView *titleView;

@end

@implementation CourseDetailView
-(void)awakeFromNib{
   // _titView = [[TitleView alloc] initWithFrame:CGRectMake(0, 82, self.frame.size.width, self.frame.size.height)];

    [self addSubview:self.titleView];
    _titleView.frame = CGRectMake(0, 82, self.frame.size.width, self.frame.size.height);
}

-(void)setCours:(Course *)cours{
    _cours = cours;
    [_titImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",cours.imgPath]] placeholderImage:nil];
    _titLab.text = cours.name;
    _scoreImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"star_%d",cours.grade]];
    
}

#pragma mark - 显示标题栏,简介，章节，评论
-(TitleView *)titleView
{
    if (!_titleView) {
        UIImage *image = [UIImage imageNamed:@"title_background"];
        UIImage *backgroundImage = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
        
        UIButton *sortNewButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [sortNewButton setTitle:@"简介" forState:UIControlStateNormal];
        sortNewButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [sortNewButton setTitleColor:kTitleGrayTextColor forState:UIControlStateNormal];
        [sortNewButton setTitleColor:kBlueTextColor forState:UIControlStateSelected];
        [sortNewButton setBackgroundImage:backgroundImage forState:UIControlStateNormal];
        UIButton *sortHotButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [sortHotButton setTitle:@"章节" forState:UIControlStateNormal];
        sortHotButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [sortHotButton setTitleColor:kTitleGrayTextColor forState:UIControlStateNormal];
        [sortHotButton setTitleColor:kBlueTextColor forState:UIControlStateSelected];
        [sortHotButton setBackgroundImage:backgroundImage forState:UIControlStateNormal];
        UIButton *sortCommentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [sortCommentButton setTitle:@"评论" forState:UIControlStateNormal];
        sortCommentButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [sortCommentButton setTitleColor:kTitleGrayTextColor forState:UIControlStateNormal];
        [sortCommentButton setTitleColor:kBlueTextColor forState:UIControlStateSelected];
        [sortCommentButton setBackgroundImage:backgroundImage forState:UIControlStateNormal];
        _titleView = [[TitleView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 36)];
        [self.titleView addTab:sortNewButton];
        [self.titleView addTab:sortHotButton];
        [self.titleView addTab:sortCommentButton];
        self.titleView.delegate = self;
    }
    return _titleView;
}
-(void)clickTitleViewAtIndex:(int)index andTab:(UIButton *)tab{
    if ([self.delegate respondsToSelector:@selector(courseDetaeilViewClickTit:)]) {
        [self.delegate courseDetaeilViewClickTit:index];
    }
    
    
}


+(id)detailView{
    return [[NSBundle mainBundle] loadNibNamed:@"CourseDetailView" owner:nil options:nil][0];
}

@end
