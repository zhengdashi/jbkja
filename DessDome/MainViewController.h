//
//  MainViewController.h
//  DessDome
//
//  Created by Jack on 15/6/30.
//  Copyright (c) 2015年 zhr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Singleton.h"
@interface MainViewController : UIViewController
@property (nonatomic, strong, readonly) UINavigationController *selectedViewController;
singleton_interface(MainViewController)


+(void)showLogin;
+(void)showMain;
@end
