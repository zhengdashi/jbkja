//
//  HomeViewCell.m
//  DessDome
//
//  Created by Jack on 15/9/9.
//  Copyright (c) 2015年 zhr. All rights reserved.
//

#import "HomeViewCell.h"
#import "Course.h"
#import "UIImageView+WebCache.h"

@interface HomeViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *titImage;
@property (weak, nonatomic) IBOutlet UILabel *titLab;
@property (weak, nonatomic) IBOutlet UIImageView *scoreImage;
@property (weak, nonatomic) IBOutlet UILabel *dateLab;


@end


@implementation HomeViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setCour:(Course *)cour{
    _cour = cour;
    [self.titImage sd_setImageWithURL:[NSURL URLWithString:cour.imgPath] placeholderImage:nil];
    self.titLab.text = cour.name;
    self.dateLab.text = cour.releaseDate;
    
    self.scoreImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"star_%d",cour.grade]];
    
    
}

+(instancetype)cell{
    return [[NSBundle mainBundle] loadNibNamed:@"HomeViewCell" owner:nil options:nil][0];
}
@end























