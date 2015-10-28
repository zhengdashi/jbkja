//
//  CourseInfoCell.m
//  DessDome
//
//  Created by Jack on 15/9/17.
//  Copyright (c) 2015年 zhr. All rights reserved.
//

#import "CourseInfoCell.h"
#import "CourseInfo.h"

typedef void(^CourseInfoBlock)();

@interface CourseInfoCell (){
    
}
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UIImageView *gradImage;
@property (weak, nonatomic) IBOutlet UILabel *dateLab;
@property (weak, nonatomic) IBOutlet UILabel *commentLab;
@property (weak, nonatomic) IBOutlet UIButton *unfoldBut;
@property (copy, nonatomic) CourseInfoBlock  courseBlock;


@end

@implementation CourseInfoCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)setCourseInfoBlock:(void (^)())block{
    self.courseBlock = block;
}
- (IBAction)spreadLab:(id)sender {
    if (self.courseBlock) {
        self.courseBlock();
    }
}

-(void)setCourseInfo:(CourseInfo *)courseInfo isEnxcel:(BOOL)isEnx{
    CGRect  rect = [self rectFloatNString:courseInfo.remark floa:13];
    CGRect  rec = self.commentLab.frame;
    if (rect.size.height>50) {
        
        _unfoldBut.hidden = NO;
        if (isEnx) {
            rec.size.height = rect.size.height;
            NSLog(@"----");
        }else{
            rec.size.height = 50;
            NSLog(@"++++");
        }
    }else{
        rec.size.height = rect.size.height;
        _unfoldBut.hidden = YES;
    }
    self.commentLab.frame = rec;
    CGRect  butRect = _unfoldBut.frame;
    butRect.origin.y = CGRectGetMaxY(rec) + 5;
    _unfoldBut.frame = butRect;
    
    _nameLab.text = courseInfo.userName;
    
    _gradImage.image = [UIImage imageNamed:[NSString  stringWithFormat:@"star_%dsmall",courseInfo.grad]];
    _commentLab.font = [UIFont systemFontOfSize:13];
    _commentLab.text = courseInfo.remark;
    
    
}


+(instancetype)cell{
    return [[NSBundle mainBundle] loadNibNamed:@"CourseInfoCell" owner:nil options:nil][0];
}

-(CGRect)rectFloatNString:(NSString *)string floa:(CGFloat)flo{
    CGRect  rect = [string boundingRectWithSize:CGSizeMake(260, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:flo]} context:nil];
    return rect;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end













