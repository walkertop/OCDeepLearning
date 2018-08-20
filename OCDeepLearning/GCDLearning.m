//
//  GCDLearning.m
//  OCDeepLearning
//
//  Created by walker彬 on 2017/7/11.
//  Copyright © 2017年 walker彬. All rights reserved.
//

#import "GCDLearning.h"


struct GCDQueue {
//    static dispatch_queue_t serialQueue = dispatch_queue_create("com.sohu.www", NULL);
};

@implementation GCDLearning

//单例
// 单例使用dispatch_once的好处是：
// dispatch_once比synchronized要更高效，它没有使用重量级的同步机制。若是那样的话，每次运行代码前都要获取锁，相反此函数采用“原子访问”来查询标记，以判断其对应的代码是否之前执行过。

+ (instancetype)sharedInstance {
    static GCDLearning *sharedInstance = nil;
    static dispatch_once_t onceToken;
//    @synchronized (self) {
//        if (!sharedInstance) {
//            sharedInstance = [[self alloc] init];
//        }
//    }
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)testQueue {
    
    dispatch_queue_t serialQueue = dispatch_queue_create("com.sohu.www", NULL);
    //串行并行是针对任务的，对应GCD里的block
    //同步异步是针对队列的，对应线程
    //异步串行（子线程里同步执行任务）
    dispatch_async(serialQueue, ^{
        NSLog(@"异步线程为%@",[NSThread currentThread]);
    });
    
    //同步串行队列
    dispatch_sync(serialQueue, ^{
        NSLog(@"同步串行线程为%@",[NSThread currentThread]);
    });
    
    // 异步并发队列
    dispatch_queue_t concurrentQueue = dispatch_queue_create("test.gcd.async", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(concurrentQueue, ^{
        NSLog(@"当前第一个线程为%@",[NSThread currentThread]);
    });
    dispatch_async(concurrentQueue, ^{
        NSLog(@"当前第二个线程为%@",[NSThread currentThread]);
    });
}

- (void)testGroup {
    /*
     打印结果是：
     将任务1和任务3放在group中，
     先执行任务1，3结束后，执行任务2
     */
    
    dispatch_queue_t globalQueue = dispatch_queue_create("test.gcd.group", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();

    dispatch_group_async(group, globalQueue, ^{
        NSLog(@"Group第1个任务，当前线程为%@",[NSThread currentThread]);
    });
    
    dispatch_group_async(group, globalQueue, ^{
        sleep(5);
        NSLog(@"Group第3个任务延迟5秒执行，当前线程为%@",[NSThread currentThread]);
    });

    dispatch_group_notify(group, globalQueue, ^{
        dispatch_group_async(group, globalQueue, ^{
            NSLog(@"Group第2个任务，当前线程为%@",[NSThread currentThread]);
        });
    });
}

- (void)testGroupOfEnterLeaveAndWait {
    //log结果：
    // 因为等待最长为3秒，所以先执行任务1，后执行组外的任务3，后执行5秒的任务2
    // 如果超时时长为大于执行任务的时长，则会执行完1，再执行2，最后执行3
    //NOTE: wait传入的是一个dispatch_time的参数，而不要直接传数字
    dispatch_group_t group2 = dispatch_group_create();
    dispatch_queue_t globalQueue = dispatch_queue_create("test.gcd.group", DISPATCH_QUEUE_CONCURRENT);

    dispatch_group_enter(group2);
    dispatch_group_async(group2, globalQueue, ^{
        NSLog(@"Group2组内的第1个任务，当前线程为%@",[NSThread currentThread]);
    });
    
    dispatch_group_async(group2, globalQueue, ^{
        sleep(5);
        NSLog(@"Group2组内的第2个任务，延迟5秒执行，当前线程为%@",[NSThread currentThread]);
    });
    
    dispatch_group_leave(group2);
    
    long a = dispatch_group_wait(group2, dispatch_time(DISPATCH_TIME_NOW, 6.0 * NSEC_PER_SEC));
    NSLog(@"时间%ld",a);
    
    dispatch_group_async(group2, globalQueue, ^{
        NSLog(@"Group2组外的第三个任务，当前线程为%@",[NSThread currentThread]);
    });
}

- (void)testBarrier {
    
    /*
     打印顺序是：
     barrier之前的dispatch-1
     barrier之前的dispatch-2
     dispatch-barrier
     barrier之后的dispatch-3
     barrier之后的dispatch-4
     */
    
    dispatch_queue_t concurrentQueue = dispatch_queue_create("test.gcd.barrier", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(concurrentQueue, ^(){
        NSLog(@"barrier之前的dispatch-1");
    });
    dispatch_async(concurrentQueue, ^(){
        NSLog(@"barrier之前的dispatch-2");
    });
    dispatch_barrier_async(concurrentQueue, ^(){
        NSLog(@"dispatch-barrier");
    });
    dispatch_async(concurrentQueue, ^(){
        NSLog(@"barrier之后的dispatch-3");
    });
    dispatch_async(concurrentQueue, ^(){
        NSLog(@"barrier之后的dispatch-4");
    });
}

- (void)testWait {
    dispatch_queue_t queue = dispatch_queue_create("alibaba-inc.com", NULL);

    dispatch_async(queue, ^{
        // 异步
        [NSThread sleepForTimeInterval:2];// 模拟耗时操作
        NSLog(@"异步队列---%@",[NSThread currentThread]); // 打印当前线程
    });
    
    dispatch_sync(queue, ^{
        // 同步
        [NSThread sleepForTimeInterval:2];
        // 模拟耗时操作
        NSLog(@"3---%@",[NSThread currentThread]);
        // 打印当前线程
    });
}

- (void)testSyncMain {
    
    NSLog(@"syncMain---begin");
    /*
     * 同步主队列会crash
     * crash信息：Thread 1: EXC_BAD_INSTRUCTION (code=EXC_I386_INVOP, subcode=0x0)
     */
    
    NSLog(@"currentThread---%@",[NSThread currentThread]);
    // 打印当前线程NSLog(@"syncMain---begin");
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    dispatch_sync(queue, ^{// 追加任务1
        for(int i =0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];
        // 模拟耗时操作
            NSLog(@"1---%@",[NSThread currentThread]);
            // 打印当前线程
        }
    });
    NSLog(@"syncMain---end");
}

@end
