//
//  OCFuntionStyleViewController.m
//  OCDeepLearning
//
//  Created by walker on 2018/6/27.
//  Copyright © 2018年 walker彬. All rights reserved.
//
/*
 * 定义各种功能，Demo的入口，便于统一管理
 */

#import "OCFuntionStyleViewController.h"

static NSString* const kFuntionStyle = @"funtionStyle";



@interface OCFuntionStyleViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) UITableView *funtionStyleTableView;
@property(nonatomic, strong) NSArray *funtionStyleArray;

@end

@implementation OCFuntionStyleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.funtionStyleArray = @[@"NSUserDefaults方案",@"Plist方案",@"KeyChains方案",@"NSCoder/NSDecoder方案",@"CoreData方案"];
    [self.funtionStyleTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kFuntionStyle];
    [self.view addSubview:self.funtionStyleTableView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - lazy
- (UITableView *)funtionStyleTableView {
    if (!_funtionStyleTableView) {
        _funtionStyleTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _funtionStyleTableView.delegate = self;
        _funtionStyleTableView.dataSource = self;
    }
    return _funtionStyleTableView;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.funtionStyleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kFuntionStyle forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kFuntionStyle];
    }
    cell.textLabel.text = self.funtionStyleArray[indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 100, 30)];
    label.text = @"数据库储存";
    return label;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
}

@end
