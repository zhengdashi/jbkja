//
//  CategoryView.h
//  DessDome
//
//  Created by Jack on 15/9/23.
//  Copyright (c) 2015年 zhr. All rights reserved.
//

#import "ClingView.h"

@protocol CategoryViewDelegate <NSObject>

- (void)categoryTitleViewDidSelectCategory:(id)category;

- (void)categoryTitleViewDidSelectType:(int)index;

@end



@interface CategoryView : ClingView
@property (strong, nonatomic) NSArray *categorys;
@property (assign, nonatomic) id<CategoryViewDelegate>delegate;
@end
