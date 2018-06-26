//
//  AppDelegate+Addtions.m
//  OCDeepLearning
//
//  Created by walker on 2018/6/5.
//  Copyright © 2018年 walker彬. All rights reserved.
//

#import "AppDelegate+Addtions.h"
#import "TestViewController.h"
#import "OCBaseTableViewController.h"
#import "MainViewController.h"
#import "ThirdViewController.h"

//@interface AppDelegate (Addtions)
//
//@property (nonatomic, readwrite, strong) NSManagedObjectModel *managedObjectModel;
//
//@end


@implementation AppDelegate (Addtions)

- (void)setupRootVC {
    UITabBarController *tabbarVC = [[UITabBarController alloc] init];
    
    MainViewController *firstVC = [[MainViewController alloc] init];
    firstVC.view.backgroundColor = [UIColor grayColor];
    firstVC.title = @"第一页";
    
    
    UITableViewController *secondTableVC = [[OCBaseTableViewController alloc] initWithStyle:UITableViewStylePlain];
    secondTableVC.title = @"第二页";
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:tabbarVC];
    
    TestViewController *testVC = [[TestViewController alloc] init];
    testVC.title = @"Test";
    testVC.navigationController.title = @"TEST";
    tabbarVC.navigationController.title = @"dsd";
    
    ThirdViewController *thirdVC = [[ThirdViewController alloc] init];
    thirdVC.title = @"第三页";
    
    tabbarVC.viewControllers = @[firstVC,secondTableVC,thirdVC,testVC];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = nav;
    
    [self.window makeKeyAndVisible];
}


@end
