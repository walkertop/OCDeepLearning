//
//  NSObject+Extension.m
//  OCDeepLearning
//
//  Created by walker彬 on 2017/7/25.
//  Copyright © 2017年 walker彬. All rights reserved.
//

#import "NSObject+Extension.h"

@implementation NSObject (Extension)

/**
 获取当前对象的引用计数retainCount

 @param 当前对象obj
 @return retainCount
 */
+ (NSInteger)logRetainCount:(id)obj {
    uintptr_t _objc_rootRetainCount(id obj);
    NSLog(@"当前对象为:%@\n,其引用计数的retainCount为%lu",obj,_objc_rootRetainCount(obj));
    unsigned long retainCount = _objc_rootRetainCount(obj);
    return retainCount;
}

@end
