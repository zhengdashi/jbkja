//
//  MainViewController.m
//  DessDome
//
//  Created by Jack on 15/6/30.
//  Copyright (c) 2015年 zhr. All rights reserved.
//
#define kDockHeight 49
#define kContentFrame CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - kDockHeight)

#define KDockFrame CGRectMake(0, self.view.bounds.size.height - kDockHeight, self.view.bounds.size.width, kDockHeight)
#import "MainViewController.h"
#import "MyNavController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "DockItem.h"
#import "Dock.h"
#import "HomeViewController.h"
#import "CategoryViewController.h"
#import "DownManagerViewController.h"
#import "MyHadeViewController.h"
@interface MainViewController ()<UISplitViewControllerDelegate,UINavigationControllerDelegate>{
    Dock        *_dock;
    UIView      *_contentView;


}

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addDock];
    
    [self createChildViewControllers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}
-(void)viewDidAppear:(BOOL)animated{
    self.hidesBottomBarWhenPushed = YES;
}

-(void)addDock{
    // 1.添加dock
    Dock *dock = [[Dock alloc] init];
    dock.frame = CGRectMake(0, self.view.bounds.size.height-49, self.view.bounds.size.width, 49);
   // dock.backgroundColor = [UIColor redColor];
    dock.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:dock];
    
    [dock addDockItemWithIcon:@"b1" title:@"首页"];
    [dock addDockItemWithIcon:@"b2" title:@"分类"];
    [dock addDockItemWithIcon:@"b3" title:@"下载"];
    [dock addDockItemWithIcon:@"b4" title:@"我的"];
    __weak MainViewController *main = self;
    dock.itemClickBlock = ^(int index){
        [main selecteControllerAtIndex:index];
    };
    _dock = dock;
    
    _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-49)];
    _contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_contentView];

}
#pragma mark - 添加到导航试图控制器
- (void)createChildViewControllers{
    
    HomeViewController *homeViewController = [[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
    CategoryViewController *categoryViewController = [[CategoryViewController alloc] initWithNibName:@"CategoryViewController" bundle:nil];
    DownManagerViewController *downManagerViewController = [[DownManagerViewController alloc]initWithNibName:@"DownManagerViewController" bundle:nil];
    MyHadeViewController *myQDViewController = [[MyHadeViewController alloc]initWithNibName:@"MyHadeViewController" bundle:nil];
    [self addChildViewController:homeViewController];
    [self addChildViewController:categoryViewController];
    [self addChildViewController:downManagerViewController];
    [self addChildViewController:myQDViewController];
    [self selecteControllerAtIndex:0];
    
}
- (void)addChildViewController:(UIViewController *)childController
{
    MyNavController *nav = [[MyNavController alloc] initWithRootViewController:childController];
    nav.delegate = self;
    [super addChildViewController:nav];
}
#pragma mark - 导航控制器的delegate
-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    UIViewController  * root = navigationController.viewControllers[0];
    if (viewController !=root) {
        navigationController.view.frame = self.view.bounds;
        [_dock removeFromSuperview];
        
        CGRect dockFrame = _dock.frame;
        if ([root.view isKindOfClass:[UIScrollView class]]) {
            UIScrollView  *scrollview = (UIScrollView *)root.view;
            dockFrame.origin.y = scrollview.contentOffset.y + root.view.frame.size.height - 49;
            
        }else{
            dockFrame.origin.y = root.view.frame.size.height-49;
        }
        _dock.frame = dockFrame;
        [root.view addSubview:_dock];
    }
    
}
-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //跟控制器
    UIViewController  * root = navigationController.viewControllers[0];
    if (viewController == root) {
        //更改导航控制器
        navigationController.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-49);
        //让Dock从root上移除
        [_dock removeFromSuperview];
        
        _dock.frame = CGRectMake(0, self.view.bounds.size.height - kDockHeight, self.view.bounds.size.width, 49);
        [self.view addSubview:_dock];
    }
    
    
}

#pragma makr - 选中index位置对应的子控制器
- (void)selecteControllerAtIndex:(int)index{
    UINavigationController *new = self.childViewControllers[index];
    if (new == _selectedViewController)
    {
        return;
    }
    
    [_selectedViewController.view removeFromSuperview];
    new.view.frame = _contentView.bounds;
    [_contentView addSubview:new.view];
    _selectedViewController = new;
    
    
    
}


+(void)showLogin{
    LoginViewController  * loginView = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    MyNavController  * navi = [[MyNavController alloc] initWithRootViewController:loginView];
    UIWindow  * window = [UIApplication sharedApplication].windows[0];
    window.rootViewController = navi;
    
}
+(void)showMain{
    MainViewController *mainViewController = [[MainViewController alloc] init];
    // NSLog(@"------%@",NSHomeDirectory());
    UIWindow  * window = [UIApplication sharedApplication].windows[0];
    window.rootViewController = mainViewController;
}
#pragma mark - 限制屏幕旋转
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;//只支持这一个方向(正常的方向)
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
