//
//  IntroCourseCell.m
//  DessDome
//
//  Created by Jack on 15/9/14.
//  Copyright (c) 2015年 zhr. All rights reserved.
//

#import "IntroCourseCell.h"
#import "CourseDetail.h"


@interface IntroCourseCell ()

@property (weak, nonatomic) IBOutlet UILabel *desiLab;//名称
@property (weak, nonatomic) IBOutlet UILabel *classifLab;//分类
@property (weak, nonatomic) IBOutlet UILabel *briefLab;//简介

@end

@implementation IntroCourseCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)setDetail:(CourseDetail *)detail{
    _detail = detail;
    _desiLab.text = detail.name;
    _classifLab.text = detail.folderName;
    CGRect  rect = [detail.desc boundingRectWithSize:CGSizeMake(self.frame.size.width, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    CGFloat  height = rect.size.height;
    CGRect  desRect = _briefLab.frame;
    desRect.size.height = height;
    _briefLab.frame = desRect;
    _briefLab.text = detail.desc;
    
    
}

+(instancetype)cell{
    return [[NSBundle mainBundle] loadNibNamed:@"IntroCourseCell" owner:nil options:nil][0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
