//
//  OCBaseTableViewController.m
//  OCDeepLearning
//
//  Created by walker on 2018/6/15.
//  Copyright © 2018年 walker彬. All rights reserved.
//

#import "OCBaseTableViewController.h"
#import "OCBaseTableViewCell.h"
#import "OCBaseTableViewCell+ConfigModel.h"
#import "OCBaseCellModel.h"

static NSString* const kBaseIdentifier = @"baseIdentifier";

@interface OCBaseTableViewController ()

@end

@implementation OCBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    [self.tableView registerClass:[OCBaseTableViewCell class] forCellReuseIdentifier:kBaseIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OCBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kBaseIdentifier forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[OCBaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kBaseIdentifier];
    }
    
    
    
    // Configure the cell...
    OCBaseCellModel *baseModel = [[OCBaseCellModel alloc] init];
    baseModel.btnName = @"按钮";
    baseModel.labelName = @"文本";
    
    [cell configureDataForCell:baseModel];

    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
