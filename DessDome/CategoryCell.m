//
//  CategoryCell.m
//  DessDome
//
//  Created by Jack on 15/9/22.
//  Copyright (c) 2015年 zhr. All rights reserved.
//

#import "CategoryCell.h"
#import "CourseCategory.h"

@interface CategoryCell ()
@property (weak, nonatomic) IBOutlet UIImageView *titImage;
@property (weak, nonatomic) IBOutlet UILabel *titName;

@end


@implementation CategoryCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)setIndex:(NSIndexPath *)index{
    switch (index.section) {
        case 0:{
            if (index.row == 0) {
                _titImage.image = [UIImage imageNamed:@"circle1"];
            }else if (index.row == 1){
                _titImage.image = [UIImage imageNamed:@"circle2"];
            }else if (index.row == 2){
                _titImage.image = [UIImage imageNamed:@"circle8"];
            }else if (index.row == 3){
                _titImage.image = [UIImage imageNamed:@"circle3"];
            }else{
                _titImage.image = [UIImage imageNamed:@"circle4"];
            }
        }
            break;
        case 1:{
            if (index.row == 0) {
                _titImage.image = [UIImage imageNamed:@"circle5"];
            }else{
                _titImage.image = [UIImage imageNamed:@"circle6"];
            }
        }
            break;
        default:
            break;
    }

}
-(void)setCategory:(CourseCategory *)category{
    _category = category;
    _titName.text = category.categoryName;
}
+(instancetype)cell{
    return [[NSBundle mainBundle] loadNibNamed:@"CategoryCell" owner:nil options:nil][0];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
