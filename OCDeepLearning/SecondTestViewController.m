//
//  SecondTestViewController.m
//  OCDeepLearning
//
//  Created by walker on 2018/6/26.
//  Copyright © 2018年 walker彬. All rights reserved.
//

#import "SecondTestViewController.h"

@interface SecondTestViewController ()

@end

@implementation SecondTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)changeBackgroundColor:(NSInteger)a {
    self.view.backgroundColor = [UIColor redColor];
    int num = arc4random() % 255;
    
    [NSTimer scheduledTimerWithTimeInterval:3 repeats:YES block:^(NSTimer * _Nonnull timer) {
        self.view.backgroundColor = [UIColor colorWithRed:num green:num blue:num alpha:1];
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
