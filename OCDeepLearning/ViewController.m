//
//  ViewController.m
//  OCDeepLearning
//
//  Created by walker彬 on 2017/7/7.
//  Copyright © 2017年 walker彬. All rights reserved.
//

#import "ViewController.h"
#import "OCAutoReleasePool.h"
#import <objc/runtime.h>
#import "AClass.h"
#import "GCDLearning.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

//    [self testAutoReleasePool];
//    [self testGCD];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// MARK: 测试自动释放池
- (void)testAutoReleasePool {
    OCAutoReleasePool *testPool = [[OCAutoReleasePool alloc] init];
    //没有加入自动释放池
//    [testPool createNumbersOfObjects];
    
//    //加入自动释放池
//    [testPool createNumbersOfObjectsByautoReleasePool];
    
    //检测异步线程自动释放池
    [testPool monitorAsyncAutoReleasePool];
}

// MARK: 测试GCD
- (void)testGCD {
    GCDLearning *gcd = [[GCDLearning alloc] init];
    [gcd testQueue];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [gcd testGroup];
    });
}

@end




