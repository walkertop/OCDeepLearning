////
////  NSObject+Runtime.m
////  OCDeepLearning
////
////  Created by walker彬 on 2017/7/7.
////  Copyright © 2017年 walker彬. All rights reserved.
////
//
//#import "NSObject+Runtime.h"
//#import <objc/runtime.h>
//#import "ViewController.h"
//
//@implementation NSObject (Runtime)
//
////+ (void)load {
////    Method m1 = class_getInstanceMethod([ViewController class], @selector(changeBackgroundColor));
////    Method m2 = class_getInstanceMethod([ViewController class], @selector(exchangeMethod));
////    
////    method_exchangeImplementations(m1, m2);
////}
//
//+ (void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        Class class = [self class];
//        
//        SEL originalSelector = @selector(viewWillAppear:);
//        SEL swizzledSelector = @selector(xxx_viewWillAppear:);
//        
//        Method originalMethod = class_getInstanceMethod(class, originalSelector);
//        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
//        
//        // When swizzling a class method, use the following:
//        // Class class = object_getClass((id)self);
//        // ...
//        // Method originalMethod = class_getClassMethod(class, originalSelector);
//        // Method swizzledMethod = class_getClassMethod(class, swizzledSelector);
//        
//        BOOL didAddMethod =
//        class_addMethod(class,
//                        originalSelector,
//                        method_getImplementation(swizzledMethod),
//                        method_getTypeEncoding(swizzledMethod));
//        
//        if (didAddMethod) {
//            class_replaceMethod(class,
//                                swizzledSelector,
//                                method_getImplementation(originalMethod),
//                                method_getTypeEncoding(originalMethod));
//        } else {
//            method_exchangeImplementations(originalMethod, swizzledMethod);
//        }
//    });
//}
//
//#pragma mark - Method Swizzling
//
//- (void)xxx_viewWillAppear:(BOOL)animated {
//    [self xxx_viewWillAppear:animated];
//    NSLog(@"viewWillAppear: %@", self);
//}
//
////- (void)exchangeInstanceMethod:(SEL)originalSelector SwizzledMethod:(SEL)swizzledMethod {
////    static dispatch_once_t onceToken;
////    dispatch_once(&onceToken, ^{
////        Class class = [self class];
////        
////        SEL originalSelector = @selector(originalSelector);
////        SEL swizzledSelector = @selector(swizzledMethod);
////        
////        Method originalMethod = class_getInstanceMethod(class, originalSelector);
////        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
////        
////        // When swizzling a class method, use the following:
////        // Class class = object_getClass((id)self);
////        // ...
////        // Method originalMethod = class_getClassMethod(class, originalSelector);
////        // Method swizzledMethod = class_getClassMethod(class, swizzledSelector);
////        
////        BOOL didAddMethod =
////        class_addMethod(class,
////                        originalSelector,
////                        method_getImplementation(swizzledMethod),
////                        method_getTypeEncoding(swizzledMethod));
////        
////        if (didAddMethod) {
////            class_replaceMethod(class,
////                                swizzledSelector,
////                                method_getImplementation(originalMethod),
////                                method_getTypeEncoding(originalMethod));
////        } else {
////            method_exchangeImplementations(originalMethod, swizzledMethod);
////        }
////    });
////}
//@end
