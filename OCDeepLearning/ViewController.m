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

//    AClass *a = [[AClass alloc] init];
//    NSLog(@"AName是%@",a.Aname);

    [self testGCD];
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


- (void)changeBackgroundColor {
//    self.view.backgroundColor = [UIColor yellowColor];
    [self.view setBackgroundColor:[UIColor redColor]];
    NSLog(@"改变背景颜色");
}

// MARK: 测试load的方法交换
- (void)exchangeMethod {
        NSLog(@"交换之后的方法");
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

#import <objc/runtime.h>


@implementation ViewController (Runtime)

//+ (void)load {
//    Method m1 = class_getInstanceMethod([ViewController class], @selector(changeBackgroundColor));
//    Method m2 = class_getInstanceMethod([ViewController class], @selector(exchangeMethod));
//    
//    NSLog(@"%p",m2);
//    NSLog(@"%p",m1);
//
//    method_exchangeImplementations(m1, m2);
//}
@end
