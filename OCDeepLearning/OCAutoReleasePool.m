//
//  OCAutoReleasePool.m
//  OCDeepLearning
//
//  Created by walker彬 on 2017/7/7.
//  Copyright © 2017年 walker彬. All rights reserved.
//

#import "OCAutoReleasePool.h"
#import "ViewController.h"

@implementation OCAutoReleasePool

- (void)createNumbersOfObjects {
//    NSDate *currentTime = [NSDate date];
//    NSLog(@"%@",currentTime);
//
//    // 获取系统当前时间
//    NSDate * date = [NSDate date];
//    NSTimeInterval sec = [date timeIntervalSinceNow];
//    NSDate * currentDate = [[NSDate alloc] initWithTimeIntervalSinceNow:sec];
//    
    for (int i = 0; i <= 10000; i++) {
        NSArray *array = [NSArray arrayWithObjects:@"1",@"2", nil];
//        UIImage *image = [UIImage imageNamed:@"add_friend_icon_addgroup"];
    }
    
}

- (void)createNumbersOfObjectsByautoReleasePool {
    
    
    @autoreleasepool {
        for (int i = 0; i <= 10000; i++) {
            UIImage *image = [UIImage imageNamed:@"add_friend_icon_addgroup"];
        }
    }

}

//检测异步线程的autoReleasePool
- (void)monitorAsyncAutoReleasePool {
    dispatch_queue_t queue = dispatch_queue_create("aa", NULL);
    //异步线程全局队列
//    dispatch_async(queue, ^{
//        [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
//            NSLog(@"打印时间源事件");
//
//        }];
//        
//        NSMutableArray *array = [NSMutableArray array];
//        @autoreleasepool {
//            [array addObject:@"111"];
//        }
//        NSLog(@"%@",array);
//        
//    });
    
    ViewController *vc = [[ViewController alloc] init];
    
    [NSTimer scheduledTimerWithTimeInterval:3 target:vc selector:@selector(changeBackgroundColor) userInfo:@"改变背景颜色" repeats:NO];

//    dispatch_async(dispatch_get_main_queue(), ^{
//        NSLog(@"当前线程为%@",[NSThread currentThread]);
//        [NSTimer scheduledTimerWithTimeInterval:2 repeats:YES block:^(NSTimer * _Nonnull timer) {
//            NSLog(@"次队列为异步主线程");
//        }];
//
//        
//        ViewController *vc = [[ViewController alloc] init];
//        
//        [NSTimer scheduledTimerWithTimeInterval:3 target:vc selector:@selector(changeBackgroundColor) userInfo:@"改变背景颜色" repeats:NO];
//    });
}

@end

#import <objc/runtime.h>


@implementation OCAutoReleasePool (Runtime)

//+ (void)load {
//    ViewController *vc = [[ViewController alloc] init];
//    Method m1 = class_getInstanceMethod(vc, @selector(changeBackgroundColor));
//    Method m2 = class_getInstanceMethod(vc, @selector(exchangeMethod));
//    method_exchangeImplementations(m1, m2);
//}

@end

