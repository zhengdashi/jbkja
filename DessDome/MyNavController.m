//
//  MyNavController.m
//  DessDome
//
//  Created by Jack on 15/6/30.
//  Copyright (c) 2015年 zhr. All rights reserved.
//
#define kGetColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define iOS8  [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0
#define iOS7  [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0
#import "MyNavController.h"

@interface MyNavController ()

@end

@implementation MyNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.translucent = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
+ (void)initialize{
    UINavigationBar  * navBar = [UINavigationBar appearance];
    UIBarButtonItem  * barItem = [UIBarButtonItem appearance];
    NSString  *navBarBg = nil;
    if (iOS7) {
        [navBar setBarTintColor:kGetColor(29, 35, 49)];
        if (iOS8) {
             navBar.translucent = NO;
        }
    }else{
        navBarBg = @"navigation_background";
        [barItem setBackgroundImage:[UIImage imageNamed:@"nav_button_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [navBar setBackgroundImage:[UIImage imageNamed:navBarBg] forBarMetrics:UIBarMetricsDefault];
    }
    [navBar setTitleTextAttributes:@{
                                     NSForegroundColorAttributeName : [UIColor whiteColor]
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
