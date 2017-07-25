//
//  OCAutorelease.m
//  OCDeepLearning
//
//  Created by walker彬 on 2017/7/24.
//  Copyright © 2017年 walker彬. All rights reserved.
//

#import "OCAutorelease.h"

@implementation OCAutorelease

- (void) testAutoRelease {
//    id oc = [[NSObject alloc] init];
//    
//    id __strong oc2 = [[NSObject alloc] init];
//    {
//        id oc3 = [[NSObject alloc] init];
//    }
//    @autoreleasepool {
//        id obj = [[NSObject alloc] init];
//    }
//    id __strong bbb = @"111";
//    id __autorelease cc = @"11";
    
    
//    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
//
//    id obj = [[NSObject alloc] init];
//    [obj autorelease];
//
//    [pool drain];
    
    
    ///autorelease到底做了什么
/*
 //自动释放池的原理：
 调用autorelease实际是把autorelease加入到自动释放池中
 
 - (id)autorelease {
 [NSAutoreleasePool addObject:self];
 }
 
 + (void)addObject: (id) obj {
 NSAutoreleasePool *pool = 取得正在使用的NSAutoreleasePool对象;
 if (pool != nil) {
 [pool addObject: obj];
 } else {
 不存在pool，无法调用autorelease
 }
 }
 调用autorelease，对象会被追加到自动释放池NSAutoreleasePool中的数组中，当自动释放池的pool执行[pool drain]方法时，会释放掉自动释放池中的数组，代码操作如下
 - (void)drain {
 [self dealloc];
 }
 
 - (void)dealloc {
 [self emptyPool];
 [array release];
 }
 - (void)emptyPool {
 for (id obj in array) {
 [obj release];
 }
 }
 */
    
    
    
}
// MARK: 引用计数器的原理
/*
     通过散列表来表示引用计数器表简直为内存地址，对应的value是引用计数
 */

// MARK: 类方法的引用计数
@end
