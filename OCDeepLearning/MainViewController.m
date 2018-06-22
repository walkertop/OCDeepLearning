//
//  MainViewController.m
//  OCDeepLearning
//
//  Created by walker on 2018/6/15.
//  Copyright © 2018年 walker彬. All rights reserved.
//

#import "MainViewController.h"
#import "OCBaseTableViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    OCBaseTableViewController *baseTableVC = [[OCBaseTableViewController alloc] init];
    
    [self addChildViewController:baseTableVC];
    baseTableVC.tableView.frame = CGRectMake(0, 100, 300, 300);
    
    UIViewController *secondVc = [[UIViewController alloc] init];
    secondVc.view.backgroundColor = [UIColor orangeColor];
    secondVc.view.frame = CGRectMake(0, 410, 300, 300);
    [self.view addSubview:baseTableVC.tableView];
    [self.view addSubview:secondVc.view];
    
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
