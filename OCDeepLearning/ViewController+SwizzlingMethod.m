//
//  ViewController+SwizzlingMethod.m
//  OCDeepLearning
//
//  Created by walker彬 on 2017/7/12.
//  Copyright © 2017年 walker彬. All rights reserved.
//

#import "ViewController+SwizzlingMethod.h"
#import <objc/runtime.h>

@implementation ViewController (SwizzlingMethod)


+ (void)load {
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

@end
