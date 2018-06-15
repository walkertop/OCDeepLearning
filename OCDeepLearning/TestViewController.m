//
//  TestViewController.m
//  OCDeepLearning
//
//  Created by walker on 2018/6/5.
//  Copyright © 2018年 walker彬. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()
@property(nonatomic, strong) UIButton *exitButton;      // 测试退出命令
@property(nonatomic, strong) UIButton *addressButton;   // 测试不同类型的内存地址
@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.exitButton];
    [self.view addSubview:self.addressButton];
}

#pragma mark - lazy

- (UIButton *)exitButton {
    if (!_exitButton) {
        _exitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _exitButton.frame = CGRectMake(100, 100, 50, 50);
        _exitButton.backgroundColor = [UIColor blueColor];
        _exitButton.titleLabel.text = @"点击退出";
        [_exitButton addTarget:self action:@selector(testExitCommand:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _exitButton;
}

- (UIButton *)addressButton {
    if (!_addressButton) {
        _addressButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _addressButton.frame = CGRectMake(100, 200, 50, 50);
        _addressButton.backgroundColor = [UIColor orangeColor];
        _addressButton.titleLabel.text = @"获取内存地址";
        [_addressButton addTarget:self action:@selector(alertMemberPointer) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addressButton;
}


#pragma mark - private method

- (void)testExitCommand:(UIButton *)sender {
    
//    NSTimeInterval currentDate = [NSDate timeIntervalSinceReferenceDate];
//    NSArray *a = [NSArray array];
//    @try {
//
//    }
//    @catch {
//        sender.backgroundColor  = [UIColor redColor];
//    }
//
//    @finally {
//    }
    exit(0);
}

- (void) alertMemberPointer {
    NSNumber *testNumber = @1;
    NSInteger testInt = 1;
    NSArray *testNumArr = @[@1,@2];
    NSArray *testStringArr = @[@"a",@"b"];
    
}


@end
