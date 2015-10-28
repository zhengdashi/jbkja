//
//  IntroCourseView.m
//  DessDome
//
//  Created by Jack on 15/9/10.
//  Copyright (c) 2015年 zhr. All rights reserved.
//

#import "IntroCourseView.h"
#import "CourseDetail.h"
#import "IntroCourseCell.h"

@interface IntroCourseView ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation IntroCourseView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height) style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.tableFooterView = [[UIView alloc] init];
        [self addSubview:self.tableView];
    }
    return self;
}
//-(void)setDetail:(CourseDetail *)detail{
//    self.detail = detail;
//    [self.tableView reloadData];
//}
-(void)courseDetail:(CourseDetail *)detail{
    _detail = detail;
    [self.tableView reloadData];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_detail) {
        CGRect  rect = [_detail.desc boundingRectWithSize:CGSizeMake(self.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
        CGFloat  height = rect.size.height;
        return height;
    }
    
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    IntroCourseCell  * cell = [tableView dequeueReusableCellWithIdentifier:@"IntroCourseCell"];
    
    if (!cell) {
        cell = [IntroCourseCell cell];
    }
    cell.detail = _detail;
    return cell;
}


@end
