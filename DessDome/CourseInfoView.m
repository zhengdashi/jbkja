//
//  CourseInfoView.m
//  DessDome
//
//  Created by Jack on 15/9/10.
//  Copyright (c) 2015年 zhr. All rights reserved.
//

#import "CourseInfoView.h"
#import "CourseDetail.h"
#import "CourseTool.h"
#import "CourseInfo.h"
#import "CourseInfoCell.h"

@interface CourseInfoView ()<UITableViewDataSource,UITableViewDelegate>{
    
}
@property (strong, nonatomic) NSOperation *operation;
@property (strong, nonatomic) NSArray *infoArray;
@property (strong, nonatomic) NSMutableDictionary *isDictionary;

@end

@implementation CourseInfoView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height) style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.tableFooterView = [[UIView alloc] init];
        [self addSubview:self.tableView];
        self.isDictionary = [NSMutableDictionary dictionary];
    }
    return self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.infoArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CourseInfo  * info = self.infoArray[indexPath.row];
    NSString *indexKey = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    BOOL isExpand = [self.isDictionary[indexKey] boolValue];
    return [self countCellRow:info.remark isExcel:isExpand];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CourseInfoCell  * cell  =[tableView dequeueReusableCellWithIdentifier:@"CourseInfoCell"];
    if (!cell) {
        cell = [CourseInfoCell cell];
    }
    BOOL  isCell = [self.isDictionary[[NSString stringWithFormat:@"%ld",(long)indexPath.row]] boolValue];
    [cell setCourseInfo:self.infoArray[indexPath.row] isEnxcel:isCell];
    __weak typeof(self) weakSelf = self;
    [cell setCourseInfoBlock:^{
        NSString *indexKey = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
        BOOL isExpand = [weakSelf.isDictionary[indexKey] boolValue];
        //NSLog(@"-------------------");
        [weakSelf changeIndexPath:indexPath isExcel:isExpand];
    }];
    
   // NSLog(@"-----%d",isCell);
    //cell.courseInfo = self.infoArray[indexPath.row];
    return cell;
}

-(void)changeIndexPath:(NSIndexPath *)indexPath isExcel:(BOOL)isExc{
    NSString  *  isKey = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    [self.isDictionary setObject:[NSNumber numberWithBool:!isExc] forKey:isKey];
    [self.tableView beginUpdates];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    [self.tableView endUpdates];
}

//请求课程评论
-(void)updateCourseInfoifCourseComment:(CourseDetail *)comment{
    _detail = comment;
    self.operation = [CourseTool courseCommentWithDeate:comment PageNo:1 PageSize:10 Success:^(NSArray *array, BOOL hasMore, int totalCount, NSString *errorCode, NSString *errorMsg) {
        if (errorCode ==nil) {
           // NSLog(@"----%@",array);
            self.infoArray = array;
            [self.tableView reloadData];
        }
        
    } Fail:^(NSError *error) {
        
    }];
}
-(CGFloat)countCellRow:(NSString *)reamk isExcel:(BOOL)isExc{
    CGRect  rect = [reamk boundingRectWithSize:CGSizeMake(260, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];
    CGFloat  height = rect.size.height;
    if (height >50) {
        if (isExc) {
            return 44+height+40;
        }else{
            return 50 + 44+40;
        }
        
        
    }else{
       return 44+height+5;
    }
}

@end




























