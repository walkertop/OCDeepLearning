//
//  DPViewController.m
//  OCDeepLearning
//
//  Created by 郭彬 on 2020/3/24.
//  Copyright © 2020 walker彬. All rights reserved.
//

#import "DPViewController.h"

@interface DPViewController ()

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation DPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
}


- (void)setupUI {
    self.tableView.frame = self.view.bounds;
    [self.view addSubview: self.tableView];
}

- (UITableView *)tableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame: CGRectZero style: UITableViewStylePlain];
    tableView.rowHeight = 50;
    [tableView registerClass: [UITableViewCell class] forCellReuseIdentifier: @"dddd"];
    tableView.delegate = self;
    tableView.dataSource = self;
    return tableView;
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
