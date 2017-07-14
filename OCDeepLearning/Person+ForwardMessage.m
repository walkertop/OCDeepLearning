//
//  Person+ForwardMessage.m
//  OCDeepLearning
//
//  Created by walker彬 on 2017/7/13.
//  Copyright © 2017年 walker彬. All rights reserved.
//

#import "Person+ForwardMessage.h"
#import <objc/runtime.h>
#import "Bird.h"


@implementation Person (ForwardMessage)


// MARK: 实例方法的消息转发
/**
 消息转发
 */
//// MARK: 实例方法的转发流程
//// STEP 1:
////  在没有找到方法时，会先调用此方法，可用于动态添加方法
////  返回 YES 表示相应 selector 的实现已经被找到并添加到了类中，否则返回 NO
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    return YES;
}

//如果调用fly方法，则将方法对象变化为bird，执行[bird fly]
- (id)forwardingTargetForSelector:(SEL)aSelector {
    Bird *bird =[[Bird alloc] init];
    if (aSelector == @selector(fly)) {
        return bird;
    }
    return nil;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    return [NSMethodSignature signatureWithObjCTypes:"v@:"];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    // 我们还可以改变方法选择器
    [anInvocation setSelector:@selector(live)];
    // 改变方法选择器后，还需要指定是哪个对象的方法
    [anInvocation invokeWithTarget:self];
}

- (void)live {
    NSLog(@"Person 没有实现 -die 方法，并且成功的转成了 -live 方法");
}

- (void)doesNotRecognizeSelector:(SEL)aSelector {
    NSLog(@"无法处理消息：%@", NSStringFromSelector(aSelector));
}

// MARK: 类方法的消息转发
+ (BOOL)resolveClassMethod:(SEL)sel {
    return NO;
}

+ (id)forwardingTargetForSelector:(SEL)aSelector {
    return nil;
}

+ (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    return [NSMethodSignature signatureWithObjCTypes:"v@:"];
}

+ (void)forwardInvocation:(NSInvocation *)anInvocation {
    [anInvocation setSelector:@selector(classLive)];
    [anInvocation invokeWithTarget:self];
}

+ (void)classLive {
    NSLog(@"Person 没有实现 +classDie 方法，并且成功的转成了 +classLive 方法");
}

+ (void)doesNotRecognizeSelector:(SEL)aSelector {
    NSLog(@"无法处理消息：%@", NSStringFromSelector(aSelector));
}


@end
