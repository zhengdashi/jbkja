//
//  HomeViewController.m
//  DessDome
//
//  Created by Jack on 15/6/30.
//  Copyright (c) 2015年 zhr. All rights reserved.
//

#import "HomeViewController.h"
#import "AFNetworking.h"
#import "HomeView.h"
#import "CourseTool.h"
#import "HomeViewCell.h"
#import "CourseViewController.h"


@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
}

@property (strong, nonatomic) HomeView                    *titView;
@property (weak, nonatomic) IBOutlet UITableView        *homeTable;
@property (strong, nonatomic) NSArray *courseArray;
@property (strong, nonatomic) NSOperation *operation;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"企大公开课";
    self.titView = [[NSBundle mainBundle] loadNibNamed:@"HomeView" owner:nil options:nil][0];
    _homeTable.tableHeaderView = self.titView;
    
    //请求数据
    [self requestCourses];
}
-(void)viewDidAppear:(BOOL)animated{
    self.hidesBottomBarWhenPushed = YES;
}

#pragma mark - tableViewData Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.courseArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeViewCell  * cell = [tableView dequeueReusableCellWithIdentifier:@"HomeViewCell"];
    if (!cell) {
        cell = [HomeViewCell cell];
    }

    cell.cour = self.courseArray[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView  * view  = [[UIView alloc] init];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UILabel  * lab = [[UILabel alloc] init];
    lab.text = @"    热门课程";
    lab.frame = CGRectMake(0, 0, 100, 40);
    [view addSubview:lab];
    return view;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CourseViewController   * courseView = [[CourseViewController alloc] init];
    Course  * cour = self.courseArray[indexPath.row];
    courseView.cours = cour;
    
    [self.navigationController pushViewController:courseView animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 请求数据
-(void)requestCourses{
    if (_operation && _operation.isExecuting) {
        return;
    }
    self.operation = [CourseTool courseListWithType:@"R" OriginalType:@"Q" CategoryId:@"-11" PageNo:1 andPageSize:10 Success:^(NSArray *CourseList, BOOL hasMore, int totalCount, NSString *errorCode, NSString *errorMsg) {
        if (errorCode == nil) {
            self.courseArray = CourseList;
            [self.homeTable reloadData];
        }
        
    } Fail:^(NSError *error) {
        
    }];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end























