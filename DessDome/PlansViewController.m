//
//  PlansViewController.m
//  DessDome
//
//  Created by Jack on 15/9/23.
//  Copyright (c) 2015年 zhr. All rights reserved.
//

#import "PlansViewController.h"
#import "CategoryTool.h"
#import "PlanTool.h"
#import "LecturerTool.h"
#import "PlanCategory.h"
#import "CategoryView.h"
@interface PlansViewController ()

@property (strong, nonatomic) CategoryView *category;
@property (weak, nonatomic) IBOutlet UIView *planCourseView;
@property (weak, nonatomic) IBOutlet UITableView *planTableView;

@end

@implementation PlansViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self requestRecord];
}
-(void)requestRecord{
    __weak typeof(self) weakSelf = self;
    if (_isLecturer) {
        
    }else{
        [PlanTool planCategoryListByPlanPid:_categoryId IsInternal:_isInternal Success:^(NSArray *planArray, NSString *errorCode, NSString *errorMsg) {
            if (!errorCode) {
                [weakSelf createTitleViewByCategorys:planArray];
            }
            
        } Fail:^(NSError *error) {
            
        }];
        
        
    }
}
-(void)createTitleViewByCategorys:(NSArray *)category{
    PlanCategory   * plan = [NSEntityDescription insertNewObjectForEntityForName:@"PlanCategory" inManagedObjectContext:kAppDelegate.managedObjectContext];
    plan.planCategoryId = _categoryId;
    plan.name = @"全部";
    NSMutableArray  * array = [NSMutableArray arrayWithObject:plan];
    [array addObjectsFromArray:category];
    
    self.category = [[NSBundle mainBundle] loadNibNamed:@"CategoryView" owner:nil options:nil][0];
    _category.categorys = array;
    _category.clingScrollView = _planTableView;
    
    
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
