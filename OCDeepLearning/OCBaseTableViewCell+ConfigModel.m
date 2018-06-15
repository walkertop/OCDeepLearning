//
//  OCBaseTableViewCell+ConfigModel.m
//  OCDeepLearning
//
//  Created by walker on 2018/6/15.
//  Copyright © 2018年 walker彬. All rights reserved.
//

#import "OCBaseTableViewCell+ConfigModel.h"

@implementation OCBaseTableViewCell (ConfigModel)


- (void)configureDataForCell:(OCBaseCellModel *)model {
    self.customLabel.text = model.labelName;
    self.customBtn.titleLabel.text = model.btnName;
    self.customBtn.backgroundColor = [UIColor orangeColor];
}


@end

