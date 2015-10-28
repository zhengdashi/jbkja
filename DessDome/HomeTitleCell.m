//
//  HomeTitleCell.m
//  DessDome
//
//  Created by Jack on 15/9/8.
//  Copyright (c) 2015年 zhr. All rights reserved.
//

#import "HomeTitleCell.h"

@interface HomeTitleCell (){
    
}
@property (weak, nonatomic) IBOutlet UIImageView *titImage;
@property (weak, nonatomic) IBOutlet UILabel *titLable;

@end

@implementation HomeTitleCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setIndex:(NSInteger)index{
    switch (index) {
        case 0:
            _titImage.image = [UIImage imageNamed:@"circle1"];
            break;
        case 1:
            _titImage.image = [UIImage imageNamed:@"circle2"];
            break;
        case 2:
            _titImage.image = [UIImage imageNamed:@"circle3"];
            break;
        case 3:
            _titImage.image = [UIImage imageNamed:@"circle7"];
            break;
        default:
            break;
    }
}

@end
