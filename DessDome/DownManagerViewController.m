//
//  DownManagerViewController.m
//  DessDome
//
//  Created by Jack on 15/6/30.
//  Copyright (c) 2015年 zhr. All rights reserved.
//
#define kGetColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define kBlueTextColor kGetColor(0,160,232)

#import "DownManagerViewController.h"
#import "Masonry.h"
#import "KAProgressLabel.h"
#import "TitleView.h"
#import "UIDevice-Hardware.h"

@interface DownManagerViewController ()<TitleViewDelegate>{

}
@property (weak, nonatomic) IBOutlet TitleView *titleView;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *moryView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *butitemLayout;
@property (strong, nonatomic) UIView *backView;
@property (strong, nonatomic) UILabel *useMemeryLab;


@end

@implementation DownManagerViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSoutView];

   
    

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self updateDisk];
}


#pragma mark - 显示手机容量
- (void)updateDisk{
    UIDevice  *currentDevice = [UIDevice currentDevice];
//    剩余
    double  total = [[currentDevice totalDiskSpace] doubleValue];
//    已占用
    double  free = [[currentDevice freeDiskSpace] doubleValue];
//    比例
    double  prx = ((total - free)/total)*self.moryView.frame.size.width;
    if (self.backView==nil) {
        self.backView = [[UIView alloc] init];
        self.backView.backgroundColor = [UIColor blackColor];
    }
    self.backView.frame = CGRectMake(0, 0, prx, 20);
    [self.moryView addSubview:self.backView];
    
    if (self.useMemeryLab==nil) {
        self.useMemeryLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
        self.useMemeryLab.textColor = [UIColor whiteColor];
        self.useMemeryLab.font = [UIFont systemFontOfSize:14];
    }
    if ([[self memeryString:free] floatValue]<0.3) {
        self.useMemeryLab.text = @"磁盘空间不足";
        self.useMemeryLab.textColor = [UIColor redColor];
    }else{
        self.useMemeryLab.text = [NSString stringWithFormat:@"   已占用 %@G 剩余：%@G",[self memeryString:(total - free)],[self memeryString:free]];
    }
    
    [self.moryView addSubview:self.useMemeryLab];
    
}
-(NSString *)memeryString:(float)totalSize{
    return [NSString stringWithFormat:@"%1.f",totalSize/1024/1024/1024];
}


#pragma mark - titView
//titleView
-(void)loadSoutView{
    UIImage  *image = [UIImage imageNamed:@"title_background"];
    UIImage  *backimage = [image stretchableImageWithLeftCapWidth:image.size.width*0.5 topCapHeight:image.size.height*0.5];
    
    UIButton  *leftBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBut setTitle:@"已下载" forState:UIControlStateNormal];
    leftBut.titleLabel.font = [UIFont systemFontOfSize:15];
    [leftBut setTitleColor:kTitleGrayTextColor forState:UIControlStateNormal];
    [leftBut setTitleColor:kBlueTextColor forState:UIControlStateSelected];
    [leftBut setBackgroundImage:backimage forState:UIControlStateSelected];
    
    UIButton  *rigBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [rigBut setTitle:@"已下载" forState:UIControlStateNormal];
    rigBut.titleLabel.font = [UIFont systemFontOfSize:15];
    [rigBut setTitleColor:kTitleGrayTextColor forState:UIControlStateNormal];
    [rigBut setTitleColor:kBlueTextColor forState:UIControlStateSelected];
    [rigBut setBackgroundImage:backimage forState:UIControlStateSelected];
    
    [_titleView addTab:leftBut];
    [_titleView addTab:rigBut];
    
    _titleView.delegate = self;
    
}

- (void)clickTitleViewAtIndex:(int)index andTab:(UIButton *)tab{
    
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
