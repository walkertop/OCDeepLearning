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
    [self exchangeViewDidLoad];
}


- (void)exchangeViewDidLoad {
    //    Method m1 = class_getInstanceMethod([ViewController class], @selector(viewDidAppear:));
    //    Method m2 = class_getInstanceMethod([ViewController class], @selector(gb_viewDidAppear:));
    //
    ////    IMP p1 = method_getImplementation(m1);
    ////    IMP p2 = method_getImplementation(m2);
    ////    NSLog(@"Imp分别是%p,/n %p",p1,p2);
    //    ///p1和m1对应的是两个地址
    //
    //    NSLog(@"method分别是%p,/n %p",m1,m2);
    //
    //    method_exchangeImplementations(m1, m2);
    
    Method m3 = class_getInstanceMethod([ViewController class], @selector(viewDidLoad));
    Method m4 = class_getInstanceMethod([ViewController class], @selector(gb_viewDidLoad));
    
    //    IMP p3 = method_getImplementation(m3);
    //    IMP p4 = method_getImplementation(m4);
    //    NSLog(@"Imp分别是%p,/n %p",p1,p2);
    ///p1和m1对应的是两个地址
    
    //    NSLog(@"method分别是%p,/n %p",m3,m4);
    
    method_exchangeImplementations(m3, m4);
}

//- (void)gb_viewDidAppear:(BOOL)animated {
//    [self gb_viewDidAppear:YES];
//    NSLog(@"方法交换成功");
//}


- (void)gb_viewDidLoad {
    [self gb_viewDidLoad];
    NSLog(@"类的名字是%@",[self class]);
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
