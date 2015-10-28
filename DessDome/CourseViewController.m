//
//  CourseViewController.m
//  DessDome
//
//  Created by Jack on 15/9/9.
//  Copyright (c) 2015年 zhr. All rights reserved.
//

#import "CourseViewController.h"
#import "CourseDetailView.h"
#import "Course.h"
#import "IntroCourseView.h"
#import "CommentCoureView.h"
#import "CourseInfoView.h"
#import "CourseTool.h"
#import "CourseComment.h"
#import "MyAVPlayerController.h"
#import "MyNavController.h"
#import "UMSocial.h"


#define kScrollWidth _courScrollView.frame.size.width
#define kScrollHeight _courScrollView.frame.size.height

@interface CourseViewController ()<CourseDeatilViewDelegate,CommentCoureViewDelegate,UMSocialUIDelegate>
@property (strong, nonatomic) CourseDetailView *courseDetaileView;
@property (weak, nonatomic) IBOutlet UIScrollView *courScrollView;
@property (strong, nonatomic) IntroCourseView *introView;
@property (strong, nonatomic) CommentCoureView *commentView;
@property (strong, nonatomic) CourseInfoView *courseView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *courseLayout;
@property (strong, nonatomic) NSLayoutConstraint *detaileLayout;
@property (strong, nonatomic) CourseDetail *detail;


@end

@implementation CourseViewController

-(void)dealloc{
    [_introView.tableView removeObserver:self forKeyPath:@"contentOffset"];
    [_commentView.tableView removeObserver:self forKeyPath:@"contentOffset"];
    [_courseView.tableView removeObserver:self forKeyPath:@"contentOffset"];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self navControler];
    //布局UI
    [self createContentView];
    //获得简介
    [self requestRount];
}
-(void)navControler{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"system_back"] style:UIBarButtonItemStyleDone target:self action:@selector(backTrack)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"share"] style:UIBarButtonItemStylePlain target:self action:@selector(backShare)];
}
-(void)backTrack{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)backShare{
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"5628a8d0e0f55a09ad000526"
                                      shareText:@"你要分享的文字"
                                     shareImage:[UIImage imageNamed:@"icon.png"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQzone,UMShareToQQ,UMShareToRenren,UMShareToDouban,UMShareToEmail,UMShareToSms,UMShareToFacebook, nil]
                                       delegate:self];
}
-(BOOL)isDirectShareInIconActionSheet{
    return YES;
}
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response{
    //判断分享是否成功
    if (response.responseCode ==UMSResponseCodeSuccess) {
        NSLog(@"------is----%@",[[response.data allKeys] objectAtIndex:0]);
    }
    
}
#pragma mark - 数据载入
-(void)requestRount{
    __weak typeof(self) weakSelf = self;
    [CourseTool courseDetailWithID:self.cours Success:^(CourseDetail *courseDetail, NSString *errorCode, NSString *errorMsg) {
        if (!errorCode) {
            weakSelf.detail = courseDetail;
           
            [weakSelf.introView courseDetail:_detail];
            weakSelf.commentView.cour = _cours;
            [weakSelf.commentView updateCommentCourseViewCourseDetail:_detail];
            [weakSelf.courseView updateCourseInfoifCourseComment:_detail];
            
        }
        
        
        
    } Fail:^(NSError *error) {
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    self.navigationController.navigationBar.translucent = YES;
}
-(void)createContentView{
    self.courseDetaileView = [CourseDetailView detailView];
    self.courseDetaileView.delegate = self;
    self.courseDetaileView.translatesAutoresizingMaskIntoConstraints = NO;
    self.courseDetaileView.cours = self.cours;
    [self.view addSubview:_courseDetaileView];
    
    self.detaileLayout = [NSLayoutConstraint constraintWithItem:_courseDetaileView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    NSArray  * courseHorizon = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_courseDetaileView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_courseDetaileView)];
    NSArray  * courseVertical = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_courseDetaileView(==height)]-0-[_courScrollView]" options:0 metrics:@{@"height":[NSNumber numberWithFloat:_courseDetaileView.bounds.size.height]} views:NSDictionaryOfVariableBindings(_courseDetaileView,_courScrollView)];
    [self.view addConstraint:_detaileLayout];
    [self.view addConstraints:courseHorizon];
    [self.view addConstraints:courseVertical];
    [self.view removeConstraint:_courseLayout];
    
   
    //简介
    self.introView = [[IntroCourseView alloc] initWithFrame:CGRectMake(0, 0,kScrollWidth,kScrollHeight)];
    [_courScrollView addSubview:self.introView];
    [self.introView.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
    //章节
    self.commentView = [[CommentCoureView alloc] initWithFrame:CGRectMake(kScrollWidth, 0, kScrollWidth, kScrollHeight)];
    _commentView.delegate = self;
    [_courScrollView addSubview:self.commentView];
    [self.commentView.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
    //评论
    self.courseView = [[CourseInfoView alloc] initWithFrame:CGRectMake(2*kScrollWidth, 0, kScrollWidth, kScrollHeight)];
    [_courScrollView addSubview:self.courseView];
    [self.courseView.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
    
    
//    NSArray  * horizontal = [NSLayoutConstraint  constraintsWithVisualFormat:@"H:|-0-[_introView(==_courScrollView)]-0-[_commentView(==_courScrollView)]-0-[_courseView(==_courScrollView)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_introView,_commentView,_courseView,_courScrollView)];
//    NSArray  * verticale1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_introView(==_courScrollView)]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_introView,_courScrollView)];
//    NSArray  * verticale2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_commentView(==_courScrollView)]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_commentView,_courScrollView)];
//    NSArray  * verticale3 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_courseView(==_courScrollView)]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_courseView,_courScrollView)];
//    [_courScrollView addConstraints:horizontal];
//    [_courScrollView addConstraints:verticale1];
//    [_courScrollView addConstraints:verticale2];
//    [_courScrollView addConstraints:verticale3];
    
    _courScrollView.contentSize = CGSizeMake(3*_courScrollView.bounds.size.width, _courScrollView.bounds.size.height);
    _courScrollView.scrollEnabled = NO;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    UITableView  * currentTable;
    int index = _courScrollView.contentOffset.x/kScrollWidth;
    if (index==0) {
        currentTable = _introView.tableView;
    }else if (index ==1){
        currentTable = _commentView.tableView;
    }else{
        currentTable = _courseView.tableView;
    }
    if (object == currentTable) {
        CGPoint  newContent = [change[@"new"] CGPointValue];
        __weak typeof(self) weakSelf = self;
        if (newContent.y>0 && !currentTable.isDecelerating) {
            [UIView animateWithDuration:0.3 animations:^{
                weakSelf.detaileLayout.constant = -82;
                
                [self.view layoutIfNeeded];
            }];
        }else if (newContent.y<0 && !currentTable.isDecelerating){
            [UIView animateWithDuration:0.3 animations:^{
                weakSelf.detaileLayout.constant = 0;
                
                [self.view layoutIfNeeded];
            }];
            
        }
    }
}

#pragma mark - courseDelegate
-(void)courseDetaeilViewClickTit:(NSInteger)index{
    if (index==0) {
        
        _courScrollView.contentOffset = CGPointMake(index*_courScrollView.bounds.size.width, 0);
        
        
    }else if (index == 1){
        
        _courScrollView.contentOffset = CGPointMake(index*_courScrollView.bounds.size.width, 0);
    }else{
        
        _courScrollView.contentOffset = CGPointMake(index*_courScrollView.bounds.size.width, 0);
    }
   
}

#pragma mark - commentDelegate
-(void)didClickCommentCoureTableCourseDetail:(CourseComment *)courseComment{
    MyAVPlayerController  * myPlayerView = [[MyAVPlayerController alloc] init];
    myPlayerView.courseComment = courseComment;
    MyNavController   * nav = [[MyNavController alloc] initWithRootViewController:myPlayerView];
    [self presentViewController:nav animated:YES completion:nil];
    
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























