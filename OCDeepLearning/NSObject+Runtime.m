//
//  NSObject+Runtime.m
//  OCDeepLearning
//
//  Created by walker彬 on 2017/7/7.
//  Copyright © 2017年 walker彬. All rights reserved.
//

#import "NSObject+Runtime.h"
#import <objc/runtime.h>
#import "ViewController.h"

@implementation NSObject (Runtime)

+ (void)load {
//    [[self class] exchangeInstanceMethod:@selector(viewDidAppear:) SwizzledMethod:@selector(xxx_viewWillAppear:)];
}

#pragma mark - Method Swizzling
// 交换方法
+ (void)exchangeInstanceMethod:(SEL)originalSelector SwizzledMethod:(SEL)swizzledSelector {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        ///判断是否添加成功
        //成功则拦截，失败则交换
        BOOL didAddMethod =
        class_addMethod(class,
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

// MARK: 实现方法交换和拦截
+ (void)exchangeInstanceMethod:(SEL)originalSelector SwizzledMethod:(SEL)swizzledSelector InClass: (Class)class {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        ///判断是否添加成功
        //成功则拦截，失败则交换
        BOOL didAddMethod =
        class_addMethod(class,
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));
        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}



// MARK: swizzledSelector
- (void)xxx_viewWillAppear:(BOOL)animated {
    [self xxx_viewWillAppear:animated];
    NSLog(@"viewWillAppear: %@", self);
}
@end
