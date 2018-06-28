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

- (void)testQueue {
    
    dispatch_queue_t serialQueue = dispatch_queue_create("com.sohu.www", NULL);
    
    //串行并行是针对任务的，对应GCD里的block
    //同步异步是针对队列的，对应线程
    //异步串行（子线程里同步执行任务）
    dispatch_async(serialQueue, ^{
        NSLog(@"异步线程为%@",[NSThread currentThread]);
    });
    
    // TODO: 正常不应该是死锁么，为什么这里执行了
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
    
    // TODO: (ARC下已经解决了队列的释放问题)
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

- (void)testBarrier {
    
    /*
     打印结果是：
     
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
  
    
}

- (void)testSyncMain {
    
    /*
     * 同步主队列会crash
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
    dispatch_sync(queue, ^{
        // 追加任务2
        for(int i =0; i <2; ++i) {
            [NSThread sleepForTimeInterval:2];// 模拟耗时操作
            NSLog(@"2---%@",[NSThread currentThread]); // 打印当前线程
        }
    });
    
    dispatch_sync(queue, ^{
        // 追加任务3
        for(int i =0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];
            // 模拟耗时操作
            NSLog(@"3---%@",[NSThread currentThread]);
            // 打印当前线程
        }
    });
    NSLog(@"syncMain---end");
    
}
        
 


@end
