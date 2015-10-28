//
//  VerticalAlignmentUILabel.h
//  xingxing
//
//  Created by Jack on 14/11/10.
//  Copyright (c) 2014年 hb. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    VerticalAlignmentTop = 0, // default
    VerticalAlignmentMiddle,
    VerticalAlignmentBottom,
} VerticalAlignment;

@interface VerticalAlignmentUILabel : UILabel{
@private
    VerticalAlignment _verticalAlignment;
}

@property (nonatomic) VerticalAlignment verticalAlignment;  

@end
