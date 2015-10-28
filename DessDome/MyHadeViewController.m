//
//  MyHadeViewController.m
//  DessDome
//
//  Created by Jack on 15/6/30.
//  Copyright (c) 2015年 zhr. All rights reserved.
//

#import "MyHadeViewController.h"
#import "TableViewCell.h"


@interface MyHadeViewController ()<TitleViewDelegate,UITableViewDataSource,UITableViewDelegate>{
    
   
}
@property (weak, nonatomic) IBOutlet TitleView *titleView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation MyHadeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //self.navigationController.navigationBarHidden = YES;
    _titleView.hidden = YES;
    [self loadTitleView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] init];

    UIView   *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, self.view.bounds.size.width, 100);
    view.backgroundColor =[UIColor grayColor];
    _tableView.tableHeaderView = view;
    
}
#pragma mark - table DataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell  * cell = [tableView dequeueReusableCellWithIdentifier:@"tableCell"];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tableCell"];
//    }
////    NSInteger  index = indexPath.row;
//    cell.textLabel.text = [NSString stringWithFormat:@"%d",indexPath.row];
//    return cell;
    TableViewCell   *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell"];
    if (!cell) {
        cell = [TableViewCell cell];
    }
    return cell;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"---------\n%f",self.tableView.contentOffset.y);
    
    CGFloat  tableY = self.tableView.contentOffset.y;
    if (tableY>60) {
        _titleView.hidden = NO;
    }else{
        _titleView.hidden = YES;
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - titView
-(void)loadTitleView{
    UIImage   *image = [UIImage imageNamed:@"title_background"];
//    图片拉伸
    UIImage   *backgroundImage = [image stretchableImageWithLeftCapWidth:image.size.width*0.5 topCapHeight:image.size.height*0.5];
    
    UIButton  *courseBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [courseBut setTitle:@"课程" forState:UIControlStateNormal];
    courseBut.titleLabel.font = [UIFont systemFontOfSize:14];
    [courseBut setTitleColor:kTitleGrayTextColor forState:UIControlStateNormal];
    [courseBut setTitleColor:kBlueTextColor forState:UIControlStateSelected];
    [courseBut setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    
    UIButton  *obseBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [obseBut setTitle:@"评论" forState:UIControlStateNormal];
    obseBut.titleLabel.font = [UIFont systemFontOfSize:14];
    [obseBut setTitleColor:kTitleGrayTextColor forState:UIControlStateNormal];
    [obseBut setTitleColor:kBlueTextColor forState:UIControlStateSelected];
    [obseBut setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    [self.titleView addTab:courseBut];
    [self.titleView addTab:obseBut];
    self.titleView.delegate = self;
}
-(void)clickTitleViewAtIndex:(int)index andTab:(UIButton *)tab{
    
    
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
