//
//  OCAutoReleasePool.m
//  OCDeepLearning
//
//  Created by walker彬 on 2017/7/7.
//  Copyright © 2017年 walker彬. All rights reserved.
//

#import "OCAutoReleasePool.h"
#import <objc/runtime.h>

@implementation OCAutoReleasePool

/**
 为了对比   使用自动释放池对循环创建对象的影响
 */
- (void)createNumbersOfObjects {        //未使用自动释放池，创建循环变量
    for (int i = 0; i <= 10000; i++) {
        NSArray *array = [NSArray arrayWithObjects:@"1",@"2", nil];
        NSLog(@"%@",array);
    }
}

- (void)createNumbersOfObjectsByautoReleasePool {
    @autoreleasepool {
        for (int i = 0; i <= 10000; i++) {
            NSArray *array = [NSArray arrayWithObjects:@"1",@"2", nil];
            NSLog(@"%@",array);
        }
    }
}

// TODO: - 待完成
// MARK: 检测异步线程的NSAutoReleasePool
/**
 自动释放池依赖NSRunloop，但子线程的RunLoop默认不开启
 AIM:       检测子线程中引用自动释放池是否有影响
 Result:
 */
- (void)monitorAsyncAutoReleasePool {
    dispatch_queue_t queue = dispatch_queue_create("top.betteris.www", NULL);
    //异步线程全局队列
    
    dispatch_async(queue, ^{
        NSMutableArray *array = [NSMutableArray array];
        @autoreleasepool {
            [array addObject:@"111"];
        }
        NSLog(@"%@",array);
    });
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"当前线程为%@",[NSThread currentThread]);
        [NSTimer scheduledTimerWithTimeInterval:2 repeats:YES block:^(NSTimer * _Nonnull timer) {
            NSLog(@"次队列为异步主线程");
        }];
    });
}

/**
 子线程的runloop默认不开启，而NSTimer事件必须加入NSRunLoop中才可以运行
 因此需要手动开启runloop，并把NSTimer添加进去才可以
 */
- (void)testTimerInAsync {
    dispatch_queue_t queue = dispatch_queue_create("top.betteris.www", NULL);
    //异步线程全局队列
    dispatch_async(queue, ^{
        NSRunLoop *runloop = [NSRunLoop currentRunLoop];
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            NSLog(@"%@----子线程时间源事件成功开启----",[self class]);
        }];
        [runloop addTimer:timer forMode:NSRunLoopCommonModes];
        [runloop run];
        NSMutableArray *array = [NSMutableArray array];
        @autoreleasepool {
            [array addObject:@"111"];
        }
        NSLog(@"%@",array);
    });
}

@end
