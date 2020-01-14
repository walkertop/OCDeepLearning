//
//  LearnDatasourceClass.m
//  OCDeepLearning
//
//  Created by walker on 2018/8/17.
//  Copyright © 2018年 walker彬. All rights reserved.
//

#import "LearnDatasourceClass.h"

static NSString *const kFirstNotificationName = @"firstNotificationName";
static NSString *const kSecondNotificationName = @"secondNotificationName";
static NSString *const kThirdNotificationName = @"thirdNotificationName";

@interface LearnDatasourceClass()

@property(nonatomic, strong) NSMutableArray *allNotifyArray;   // 获取所有的通知


@end

@implementation LearnDatasourceClass

/*
 
 1. 通知默认是同步的
 2. 如果通知的线程是异步的，即post和接收的都是，可以使用
     addObserverForName:<#(nullable NSNotificationName)#> object:<#(nullable id)#> queue:<#(nullable NSOperationQueue *)#> usingBlock:<#^(NSNotification * _Nonnull note)block#>
     方法
 3. 如果通知的name填写为nil,则会接收所有的通知、（所以可以利用trick,获取所有的通知）
 */

+ (instancetype)sharedInstance {
    static LearnDatasourceClass *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

#pragma mark - 通知
- (void)postNotify {
    [self addObserveNotify];
    
    NSString *firstString  = @"这是第1个通知";
    NSString *secondString = @"这是第2个通知";
    NSString *thirdString  = @"这是第3个通知";
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kFirstNotificationName object:firstString];
    [[NSNotificationCenter defaultCenter] postNotificationName:kSecondNotificationName object:secondString];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:kThirdNotificationName object:thirdString];
        NSLog(@"发送通知的线程是%@", [NSThread currentThread]);
    });

//    // 第一种方式执行通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(firstNotification:) name:kFirstNotificationName object:nil];
//
//    // 第二种方式执行通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(secondNotification:) name:nil object:nil];
//
//    // 第3种方式执行通知（第三个是子线程发送的通知，如果想在主线程中收到信息，则应该指定具体的队列
//    [[NSNotificationCenter defaultCenter] addObserverForName:kThirdNotificationName object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
//        NSLog(@"接收通知的线程是%@", [NSThread currentThread]);
//        NSLog(@"通知的信息是%@",note);
//    }];
    
//    [[NSNotificationCenter defaultCenter] addObserverForName:kThirdNotificationName object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
//        NSLog(@"接收通知的线程是%@", [NSThread currentThread]);
//        NSLog(@"通知的信息是%@",note);
//    }];
}

- (void)addObserveNotify {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(firstNotification:) name:kFirstNotificationName object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(secondNotification:) name:kSecondNotificationName object:nil];

    [[NSNotificationCenter defaultCenter] addObserverForName: kThirdNotificationName object:nil queue:NSOperationQueue.mainQueue usingBlock:^(NSNotification * _Nonnull note) {
        NSLog(@"queue == mainQueue,此时的通知的信息%@,当前线程是%@",note.userInfo, [NSThread currentThread]);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:kThirdNotificationName object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        NSLog(@"queue == nil, 此时的通知的信息%@,当前线程是%@",note.userInfo, [NSThread currentThread]);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:kThirdNotificationName object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
           NSLog(@"通知的信息%@",note.userInfo);
       }];
}

- (void)firstNotification:(NSNotification *)notify {
    NSLog(@"第1个通知的通知详情%@",notify);
}

- (void)secondNotification:(NSNotification *)notify {
    
    [self.allNotifyArray addObject:notify.name];
    NSLog(@"第2个通知的通知详情%@",notify);
}

- (void)thirdNotification:(NSNotification *)notify {
    NSLog(@"第3个通知的通知详情%@",notify);
}


#pragma mark - KVO
- (void)addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context {
    
}









#pragma mark - lazy load
- (NSMutableArray *)allNotifyArray {
    if (!_allNotifyArray) {
        _allNotifyArray = [NSMutableArray array];
    }
    return _allNotifyArray;
}


- (void)learnKVO {
    self.KVOString = @"old";
    [self.KVOString addObserver:self forKeyPath:@"KVOString" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    self.KVOString = @"new";

}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"KVOString"]) {
        NSLog(@"KVO的值是%@",change);
    }
}

- (void)willChangeValueForKey:(NSString *)key {
    if ([key isEqualToString:@"KVOString"]) {
        NSLog(@"key%@",key);
    }
}

- (void)didChangeValueForKey:(NSString *)key {
    if ([key isEqualToString:@"KVOString"]) {
        NSLog(@"key%@",key);
    }
}

- (void)dealloc {
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.KVOString removeObserver:self forKeyPath:@"KVOString"];
}

@end
