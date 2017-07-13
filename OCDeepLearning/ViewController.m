//
//  ViewController.m
//  OCDeepLearning
//
//  Created by walker彬 on 2017/7/7.
//  Copyright © 2017年 walker彬. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "OCAutoReleasePool.h"
#import "AClass.h"
#import "GCDLearning.h"
#import "Person.h"
#import "Animal.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

//    [self testAutoReleasePool];
//    [self testGCD];
    [self testForwardingMethod];
    [self testResolveInstanceMethod];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// MARK: 测试自动释放池
- (void)testAutoReleasePool {
    OCAutoReleasePool *testPool = [[OCAutoReleasePool alloc] init];
    //没有加入自动释放池
//    [testPool createNumbersOfObjects];=
//    //加入自动释放池
//    [testPool createNumbersOfObjectsByautoReleasePool];
    
    //检测异步线程自动释放池
    [testPool monitorAsyncAutoReleasePool];
    //开启子线程的runloop并将NSTimer事件添加进去才可以
    [testPool testTimerInAsync];
}

// MARK: 测试GCD
- (void)testGCD {
    GCDLearning *gcd = [[GCDLearning alloc] init];
    [gcd testQueue];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [gcd testGroup];
    });
}

// MARK: 消息转发
- (void)testForwardingMethod {
    Person *person = [[Person alloc] init];
    
    //实例方法
    [person run];       //  [person run]   等于  objc_msgSend(person,@selector(run))
    [person fly];
    [person die];
    
    //类方法的消息转发
    [Person classDie];
}

// 测试动态加载方法
- (void)testResolveInstanceMethod {
    Animal *ani = [[Animal alloc] init];
    [ani swim];
}
@end




