//
//  TableViewCell.m
//  DessDome
//
//  Created by Jack on 15/7/14.
//  Copyright (c) 2015年 zhr. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(id)cell{
    return [[NSBundle mainBundle] loadNibNamed:@"TableViewCell" owner:nil options:nil][0];
}

@end
