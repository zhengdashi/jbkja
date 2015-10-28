//
//  LoginViewController.m
//  DessDome
//
//  Created by Jack on 15/6/30.
//  Copyright (c) 2015年 zhr. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginTool.h"
#import "MainViewController.h"
@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *pswText;
@property (weak, nonatomic) IBOutlet UITextField *zhangText;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"登录";
}
- (IBAction)longDownButClick:(id)sender {
    [LoginTool loginWithUsername:_zhangText.text andPassword:_pswText.text success:^(Account *account, NSString *errorCode, NSString *errorMsg) {
        if (account) {
            NSLog(@"登录成功 ");
            [MainViewController showMain];
        }
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    

}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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
