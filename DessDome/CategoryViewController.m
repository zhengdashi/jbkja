//
//  CategoryViewController.m
//  DessDome
//
//  Created by Jack on 15/6/30.
//  Copyright (c) 2015年 zhr. All rights reserved.
//

#import "CategoryViewController.h"
#import "Masonry.h"
#import "AVPlayerViewController.h"
#import "MyNavController.h"
#import "CategoryTool.h"
#import "CategoryCell.h"
#import "CourseCategory.h"
#import "PlansViewController.h"
#import "AVPlayerViewController.h"


@interface CategoryViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *groArray;
@property (strong, nonatomic) NSArray *intrArray;
@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //[self.playerBut ];
    self.title = @"分类";
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    
    
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"sousuo"] style:UIBarButtonItemStylePlain target:self action:@selector(searchBarButClick)];
    [CategoryTool categoryListBySuccess:^(NSArray *category, NSString *errorCode, NSString *errorMsg) {
        if (!errorCode) {
            self.groArray = [category subarrayWithRange:NSMakeRange(0, category.count-2)];
            self.intrArray = [category subarrayWithRange:NSMakeRange(self.groArray.count, 2)];
            [self.tableView reloadData];
        }
        
    } Fail:^(NSError *error) {
        
    }];
    
}
#pragma mark - tableDelegate data
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section ==0) {
        return self.groArray.count;
    }else{
        return self.intrArray.count;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CourseCategory  * category;
     UILabel  * lab = [[UILabel alloc] init];
    lab.backgroundColor = [UIColor groupTableViewBackgroundColor];
    lab.font = [UIFont systemFontOfSize:14];
    if (section ==0) {
        category = [_groArray firstObject];
        lab.text = category.title;
    }else{
        category = [_intrArray firstObject];
        lab.text = category.title;
    }
    
   
    return lab;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CategoryCell  * cell = [tableView dequeueReusableCellWithIdentifier:@"CategoryCell"];
    if (!cell) {
        cell = [CategoryCell cell];
    }
    if (indexPath.section==0) {
        cell.category = _groArray[indexPath.row];
        cell.index = indexPath;
    }else{
        cell.category = _intrArray[indexPath.row];
        cell.index = indexPath;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section ==0) {
        if (indexPath.row<_groArray.count-1) {
            CourseCategory   *category = _groArray[indexPath.row];
            PlansViewController  * plans = [[PlansViewController alloc] init];
            plans.navigationItem.title = category.categoryName;
            plans.categoryId = category.categoryId;
            plans.isHidden =category.isHidden;
            if (indexPath.row == _groArray.count - 2) {
                plans.isLecturer = YES;
                plans.categoryId = @"0";
            }
            [self.navigationController pushViewController:plans animated:YES];
        }
    }else{
        AVPlayerViewController  * avpl = [[AVPlayerViewController alloc] init];
        [self.navigationController pushViewController:avpl animated:YES];
        
        
    }
}


#pragma mark - 搜索
-(void)searchBarButClick{
    
}













































-(void)butClick{
    AVPlayerViewController * mediaPlayer = [[AVPlayerViewController  alloc] initWithNibName:@"AVPlayerViewController" bundle:nil];
    MyNavController  * nav = [[MyNavController alloc] initWithRootViewController:mediaPlayer];
    [self presentViewController:nav animated:YES completion:nil];
}

-(void)bourt{
    UIButton  * but = [UIButton buttonWithType:UIButtonTypeCustom];
    [but addTarget:self action:@selector(butClick) forControlEvents:UIControlEventTouchUpInside];
    [but setTitle:@"视频播放" forState:UIControlStateNormal];
    but.backgroundColor = [UIColor redColor];
    [self.view addSubview:but];
    __weak typeof(self) weakSelf = self;
    [but mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf.view);
        make.size.mas_equalTo(CGSizeMake(150, 80));
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
