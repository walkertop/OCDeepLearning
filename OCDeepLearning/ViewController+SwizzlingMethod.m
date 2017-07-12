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
    Method m1 = class_getInstanceMethod([ViewController class], @selector(viewDidAppear:));
    Method m2 = class_getInstanceMethod([ViewController class], @selector(gb_viewDidAppear:));

//    IMP p1 = method_getImplementation(m1);
//    IMP p2 = method_getImplementation(m2);
//    NSLog(@"Imp分别是%p,/n %p",p1,p2);
    ///p1和m1对应的是两个地址

    NSLog(@"method分别是%p,/n %p",m1,m2);

    method_exchangeImplementations(m1, m2);
}

- (void)gb_viewDidAppear:(BOOL)animated {
    [self gb_viewDidAppear:YES];
    NSLog(@"方法交换成功");
}

@end
