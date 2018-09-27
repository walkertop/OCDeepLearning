//
//  LearnInitializeChildClass.m
//  OCDeepLearning
//
//  Created by walker on 2018/8/16.
//  Copyright © 2018年 walker彬. All rights reserved.
//

#import "LearnInitializeChildClass.h"


static NSInteger kSomeInteger = 4;
static NSArray *kSomeArray;

//static NSArray *kConstArray = [NSArray array];
// NOTE:
// 报错Initializer element is not a compile-time constant
// 初始化的值，不是一个编译时常量
// 如果需要初始化全局状态，可以外部声明，在initialize里初始化
// NOTE：
static NSString* const kSomeString = @"someString";// 这个没问题，是因为直接用字面量给kSomeString赋值，内存在苍凉去


@implementation LearnInitializeChildClass

// 关于initialize
/*
 *   1. 只要继承链上，有一个class实现了initilize,该class的子类都会也同样会调用initilize，（父类不会）
 比如：
 LearnInitializeBaseClass ————》 LearnInitializeFatherClass ————》LearnInitializeChildClass
 LearnInitializeFatherClass实现了initilize方法，其子类LearnInitializeChildClass也会调用，但是父类LearnInitializeBaseClass就不会实现
 */

+ (void)initialize {

    NSLog(@"调用initialize，当前类的名字为%@",self);
    if (self == [LearnInitializeChildClass class]) {
        kSomeArray = [NSArray arrayWithObject:@"1"];
    }
}

+ (instancetype)sharedInstance {
    static LearnInitializeChildClass *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)test {
    NSLog(@"输出数组对象为%@",kSomeArray);
    NSLog(@"输出整形为%ld",(long)kSomeInteger);
}

@end
