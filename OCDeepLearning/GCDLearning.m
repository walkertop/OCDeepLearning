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
        NSLog(@"当前线程为%@",[NSThread currentThread]);
    });
    
    // TODO: 正常不应该是死锁么，为什么这里执行了
    //同步串行队列
    dispatch_sync(serialQueue, ^{
        NSLog(@"当前线程为%@",[NSThread currentThread]);
    });
    
    // 异步并发队列
    dispatch_queue_t concurrentQueue = dispatch_queue_create("dd", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(concurrentQueue, ^{
        NSLog(@"当前第一个线程为%@",[NSThread currentThread]);
    });
    dispatch_async(concurrentQueue, ^{
        NSLog(@"当前第二个线程为%@",[NSThread currentThread]);
    });
    
    // TODO: (ARC下已经解决了队列的释放问题)
}

- (void)testGroup {
    
    //先打印1,3 再执行打印2
    dispatch_queue_t globalQueue = dispatch_queue_create("com.betteristop.www", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();

    dispatch_group_async(group, globalQueue, ^{
        NSLog(@"Group第1个任务，当前线程为%@",[NSThread currentThread]);
        
    });
    
    dispatch_group_async(group, globalQueue, ^{
        sleep(5);
        NSLog(@"Group第3个任务，当前线程为%@",[NSThread currentThread]);

    });

    dispatch_group_notify(group, globalQueue, ^{
        
        dispatch_group_async(group, globalQueue, ^{
            NSLog(@"Group第2个任务，当前线程为%@",[NSThread currentThread]);
        });
    });
    
    

    
}

- (void)testBarrier {
    
}

- (void)testWait {
    
}



@end
