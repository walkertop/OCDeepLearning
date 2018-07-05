//
//  TestViewController.m
//  OCDeepLearning
//
//  Created by walker on 2018/6/5.
//  Copyright © 2018年 walker彬. All rights reserved.
//

#import "TestViewController.h"
#import "NSObject+Runtime.h"
@interface TestViewController ()
@property(nonatomic, strong) UIButton *exitButton;      // 测试退出命令
@property(nonatomic, strong) UIButton *addressButton;   // 测试不同类型的内存地址

@property(nonatomic, strong) UIView *blueView;
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
    [self.view addSubview:self.blueView];
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

- (UIView *)blueView {
    if (!_blueView) {
        _blueView = [[UIView alloc] initWithFrame:CGRectMake(0, 400, 300, 300)];
        _blueView.backgroundColor = [UIColor blueColor];
    }
    return _blueView;
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
//    exit(0);
    [self testAsyncDelayScheduledAction];
}

- (void) alertMemberPointer {
    NSNumber *testNumber = @1;
    NSInteger testInt = 1;
    NSArray *testNumArr = @[@1,@2];
    NSArray *testStringArr = @[@"a",@"b"];
    
//    [self excuteTimeRecycleAction];
}

- (void)testAsyncDelayScheduledAction {
    dispatch_queue_t queue = dispatch_queue_create("test.delayperformSelctor", NULL);
    
    dispatch_async(queue, ^{
//        [self performSelector:@selector(changeBackgroundColor) withObject:nil afterDelay:2];
        [self performSelector:@selector(changeBackgroundColor) withObject:nil afterDelay:2 inModes:@[NSRunLoopCommonModes]];
        
    });
}

- (void)excuteTimeRecycleAction {
    
//    NSTimer *timer1 = [NSTimer timerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        NSLog(@"主线程里打印timer");
//    }];
////    [timer1 fire];
//    [[NSRunLoop currentRunLoop] addTimer:timer1 forMode:NSDefaultRunLoopMode];

    [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSLog(@"主线程里打印timer");
    }];
    
    dispatch_queue_t queue = dispatch_queue_create("test.delayperformSelctor2", NULL);
    
    dispatch_async(queue, ^{
     
        NSLog(@"nsrunloop的相关信息%@",[NSRunLoop currentRunLoop]);

//        NSTimer *timer2 = [NSTimer timerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
//            NSLog(@"当前线程是%@打印timer",[NSThread currentThread]);
//        }];
//        [[NSRunLoop currentRunLoop] addTimer:timer2 forMode:NSRunLoopCommonModes];
        [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
//            NSLog(@"当前线程是%@打印timer",[NSThread currentThread]);
            NSLog(@"NSRunloop的相关信息%@",[NSRunLoop currentRunLoop]);
        }];
        
        [NSTimer scheduledTimerWithTimeInterval:2 repeats:NO block:^(NSTimer * _Nonnull timer) {
            NSLog(@"repeats==NO的NSRunloop的相关信息%@",[NSRunLoop currentRunLoop]);
        }];
        
        NSLog(@"nsrunloop的相关信息%@",[NSRunLoop currentRunLoop]);
        [[NSRunLoop currentRunLoop] run];
    });
    
}

- (void)changeBackgroundColor {
    self.view.backgroundColor = [UIColor redColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSSet *set1 = [event touchesForView:self.view];
    NSSet *set2 = [event touchesForView:self.exitButton];
    NSSet *set3 = [event touchesForView:self.addressButton];
    NSSet *set4 = [event touchesForView:self.blueView];
    NSSet *windowSet = [event touchesForWindow:[UIApplication sharedApplication].keyWindow];
}





@end
