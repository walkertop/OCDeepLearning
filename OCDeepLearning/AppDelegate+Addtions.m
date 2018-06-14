//
//  AppDelegate+Addtions.m
//  OCDeepLearning
//
//  Created by walker on 2018/6/5.
//  Copyright © 2018年 walker彬. All rights reserved.
//

#import "AppDelegate+Addtions.h"
#import "TestViewController.h"

@implementation AppDelegate (Addtions)



- (void)setupRootVC {
    UITabBarController *tabbarVC = [[UITabBarController alloc] init];
    
    UIViewController *firstVC = [[UIViewController alloc] init];
    firstVC.view.backgroundColor = [UIColor grayColor];
    firstVC.title = @"第一页";
    
    
    UITableViewController *secondTableVC = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
    secondTableVC.title = @"第二页";
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:tabbarVC];
    
    TestViewController *testVC = [[TestViewController alloc] init];
    testVC.title = @"Test";
    testVC.navigationController.title = @"TEST";
    tabbarVC.navigationController.title = @"dsd";
    
    tabbarVC.viewControllers = @[firstVC,secondTableVC,testVC];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = nav;
    
    [self.window makeKeyAndVisible];
}
@end
