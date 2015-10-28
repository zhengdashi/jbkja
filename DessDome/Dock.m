//
//  Dock.m
//  DessDome
//
//  Created by Jack on 15/6/30.
//  Copyright (c) 2015年 zhr. All rights reserved.
//
#define kGetColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#import "Dock.h"
#import "DockItem.h"

@interface Dock (){
    DockItem  *_currentItem;
}

@end

@implementation Dock

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kGetColor(245, 245, 245);
    }
    return self;
}
#pragma mark - 添加item
-(void)addDockItemWithIcon:(NSString *)icon title:(NSString *)title{
    DockItem  * item = [DockItem buttonWithType:UIButtonTypeCustom];
    [self addSubview:item];
    [item setTitle:title forState:UIControlStateNormal];
    [item setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [item setTitleColor:kGetColor(0, 160, 232) forState:UIControlStateSelected];
    [item setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [item setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",icon]] forState:UIControlStateSelected];
   
    
    [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchDown];
    
    [self adjustDockItemsFrame];
}
#pragma mark - 点击了某个item
-(void)itemClick:(DockItem *)item{
    _currentItem.selected = NO;
    item.selected = YES;
    _currentItem = item;
    if (_itemClickBlock) {
        _itemClickBlock(item.tag);
    }
    
}
-(void)adjustDockItemsFrame{
    int count = self.subviews.count;
    CGFloat itemWidth = self.frame.size.width / count;
    CGFloat itemHeight = self.frame.size.height;
    
    for (int i = 0; i<count; i++) {
        DockItem *item = self.subviews[i];
        item.frame = CGRectMake(i * itemWidth, 0, itemWidth, itemHeight);
        item.autoresizingMask = UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleRightMargin;
        if (i == 0) {
            item.selected = YES;
            _currentItem = item;
        }
        
        item.tag = i;
    }
}
#pragma mark 重写设置选中索引的方法
- (void)setSelectedIndex:(int)selectedIndex
{
    // 1.条件过滤
    if (selectedIndex < 0 || selectedIndex >= self.subviews.count) return;
    
    // 2.赋值给成员变量
    _selectedIndex = selectedIndex;
    
    // 3.对应的item
    DockItem *item = self.subviews[selectedIndex];
    
    // 4.相当于点击了这个item
    [self itemClick:item];
}







/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
