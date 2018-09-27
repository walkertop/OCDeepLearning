//
//  OCLearningOOP.m
//  OCDeepLearning
//
//  Created by walker彬 on 2018/9/27.
//  Copyright © 2018 walker彬. All rights reserved.
//




/*AIM:
 *  1. 包含实例h方法和类方法
 *  2. 包装成协议，方便其他人调用
 *  3. 方法带有参数的扩展
 */



#import "OCLearningOOP.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>


@interface OCLearningOOP () {
    NSString *name;
}

@property(nonatomic, copy) NSString *secret;

@end

@implementation OCLearningOOP

- (void)privateMethodOfOCLearningOOP {
    NSLog(@"知道名字，直接通过分裂获取私有方法");
}

- (void)privateMethod:(NSString *)a {
    NSLog(@"哈哈哈");
}

+ (void)privateClassMethod:(NSString *)a {
    NSLog(@"哈哈哈，类方法");
}

/**
 <#Description#>

 @param aSelectorName <#aSelectorName description#>
 @param aInstanceTarget <#aInstanceTarget description#>
 */
- (void)excutePrivateMethodWithInstanceSelectorName:(NSString *)aSelectorName ForInstanceTarget:(NSString *)className {
    Class TargetClass = NSClassFromString(className);
    id aClass = [[TargetClass alloc] init];
    
    SEL privateSelector = NSSelectorFromString(aSelectorName);
    NSMethodSignature *signature = [self methodSignatureForSelector:privateSelector];
    
    NSInvocation *invovation  = [NSInvocation invocationWithMethodSignature:signature];
    [invovation setTarget:aClass];
    [invovation setSelector:privateSelector];
    [invovation invoke];
}

@end


@implementation OCLearningOOPChild1

@end

@implementation OCLearningOOPChild2

@end


@implementation OCLearningOOPChild3

@end


@implementation OCLearningOOPChild4

void logSize() {
    
}

- (void)getPrivateIvarByCategory {
    
}

@end


