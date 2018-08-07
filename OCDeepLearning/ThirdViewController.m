//
//  ThirdViewController.m
//  OCDeepLearning
//
//  Created by walker on 2018/6/26.
//  Copyright © 2018年 walker彬. All rights reserved.
//

#import "ThirdViewController.h"
#import "SecondTestViewController.h"
#import "CTMediator.h"

static NSString* const kCustomIdentifier = @"customIdentifier";

@interface ThirdViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) UITableView *customTableView;

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.customTableView];
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

#pragma mark - lazy
- (UITableView *)customTableView {
    if (!_customTableView) {
        _customTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _customTableView.delegate = self;
        _customTableView.dataSource = self;
        
        [self.customTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCustomIdentifier];
        
    }
    return _customTableView;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCustomIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCustomIdentifier];
    }

    cell.textLabel.text = [NSString stringWithFormat:@"第%ld个cell",indexPath.row];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [[CTMediator sharedInstance] performTarget:@"SecondTestViewController" action:@"changeBackgroundColor" params:nil shouldCacheTarget:NO];
    }
}


- (void)addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context {
    
}

- (void)dealloc {
    
}

@end
