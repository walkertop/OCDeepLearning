//
//  OCSaveDataTableViewController.m
//  OCDeepLearning
//
//  Created by walker on 2018/6/27.
//  Copyright © 2018年 walker彬. All rights reserved.
//

#import "OCSaveDataTableViewController.h"

static NSString* const kOCSaveDataIdentifier = @"OCSaveDataIdentifier";

@interface OCSaveDataTableViewController ()
@property(nonatomic, strong) NSArray *saveStyleArray;

@end

@implementation OCSaveDataTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kOCSaveDataIdentifier];
    self.saveStyleArray = @[@"NSUserDefaults方式",@"Plist方式",@"NSCoder和NSDecoder方式",@"数据库方式"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.saveStyleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kOCSaveDataIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kOCSaveDataIdentifier];
        cell.textLabel.text = self.saveStyleArray[indexPath.row];
    }
    return cell;
}

@end
