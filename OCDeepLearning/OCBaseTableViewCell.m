//
//  OCBaseTableViewCell.m
//  OCDeepLearning
//
//  Created by walker on 2018/6/15.
//  Copyright © 2018年 walker彬. All rights reserved.
//

#import "OCBaseTableViewCell.h"


@interface OCBaseTableViewCell ()


@end

@implementation OCBaseTableViewCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}


- (void) setupUI {
    self.customBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.customBtn.frame = CGRectMake(10, 10, 30, 30);
    
    [self.contentView addSubview:self.customBtn];
    
    self.customLabel = [[UILabel alloc] init];
    self.customLabel.frame = CGRectMake(100, 0, 200, 40);
    
    [self.contentView addSubview:self.customLabel];
}

#pragma mark - lazy



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
