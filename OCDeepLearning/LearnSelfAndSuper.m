//
//  LearnSelfAndSuper.m
//  OCDeepLearning
//
//  Created by walker彬 on 2018/8/20.
//  Copyright © 2018年 walker彬. All rights reserved.
//

#import "LearnSelfAndSuper.h"
#import <objc/runtime.h>

@implementation LearnSelfAndSuper

@end

@implementation LearnChild


- (instancetype)init {
    self = [super init];
    
    return self;
}

@end

@implementation LearnFather

- (instancetype)init {
    self = [super init];
    NSLog(@"调用self的class方法，返回值是%@",[self class]);
    NSLog(@"调用super的class方法，返回值是%@",[super class]);
    /*
     self和super底层实现原理：
     
     当使用 self 调用方法时，会从当前类的方法列表中开始找，如果没有，就从父类中再找；而当使用 super 时，则从父类的方法列表中开始找，然后调用父类的这个方法。
     当使用 self 调用时，会使用 objc_msgSend 函数： id objc_msgSend(id theReceiver, SEL theSelector, ...)。第 一个参数是消息接收者，第二个参数是调用的具体类方法的 selector，后面是 selector 方法的可变参数。以 [self setName:] 为例，编译器会替换成调用 objc_msgSend 的函数调用，其中 theReceiver 是 self，theSelector 是 @selector(setName:)，这个 selector 是从当前 self 的 class 的方法列表开始找的 setName，当找到后把对应的 selector 传递过去。
     
     当使用 super 调用时，会使用 objc_msgSendSuper 函数：id objc_msgSendSuper(struct objc_super *super, SEL op, ...)第一个参数是个objc_super的结构体，第二个参数还是类似上面的类方法的selector，
     
     
     struct objc_super {
         id receiver;
         Class superClass;
     };
     
     当编译器遇到 [super setName:] 时，开始做这几个事：
     
     1）构 建 objc_super 的结构体，此时这个结构体的第一个成员变量 receiver 就是 子类，和 self 相同。而第二个成员变量 superClass 就是指父类
     调用 objc_msgSendSuper 的方法，将这个结构体和 setName 的 self 传递过去。
     
     2）函数里面在做的事情类似这样：从 objc_super 结构体指向的 superClass 的方法列表开始找 setName 的 selector，找到后再以 objc_super->receiver 去调用这个 selector
     
    */
    NSLog(@"%@--------",object_getClass(self));
    NSLog(@"%@--------",object_getClass(self.superclass));
    
    NSLog(@"打印self的值是%@",self);
    NSLog(@"调用self.superclass方法，返回值是%@",self.superclass);
    

    
    return self;
}

@end

