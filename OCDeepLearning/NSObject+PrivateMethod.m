//
//  NSObject+PrivateMethod.m
//  OCDeepLearning
//
//  Created by walker彬 on 2018/9/27.
//  Copyright © 2018 walker彬. All rights reserved.
//

#import "NSObject+PrivateMethod.h"

@implementation NSObject (PrivateMethod)

/**
 对象方法
 入参方法名，可以调用本类的私有方法
 
 @param selectorName 方法名的字符串
 */
- (void)excutePrivateMethodWithSelectorName:(NSString *)selectorName {
    SEL privateSelector = NSSelectorFromString(selectorName);
    
    NSMethodSignature *signature = [self methodSignatureForSelector:privateSelector];
    
    NSInvocation *invovation  = [NSInvocation invocationWithMethodSignature:signature];
    [invovation setTarget:self];
    [invovation setSelector:privateSelector];
    [invovation invoke];
}


/**
 调用某个类的实例方法

 @param aSelectorName 实例方法名
 @param className 类名
 */
+ (void)excutePrivateMethodWithInstanceSelectorName:(NSString *)aSelectorName ForClass:(NSString *)className {
    Class TargetClass = NSClassFromString(className);
    id aClass = [[TargetClass alloc] init];
    if (!aClass) { return; }
    
    SEL privateSelector = NSSelectorFromString(aSelectorName);
    NSMethodSignature *signature = [aClass methodSignatureForSelector:privateSelector];
    
    NSInvocation *invovation  = [NSInvocation invocationWithMethodSignature:signature];
    [invovation setTarget:aClass];
    [invovation setSelector:privateSelector];
    [invovation invoke];
}
@end
