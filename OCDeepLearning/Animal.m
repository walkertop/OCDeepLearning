//
//  Animal.m
//  OCDeepLearning
//
//  Created by walker彬 on 2017/7/13.
//  Copyright © 2017年 walker彬. All rights reserved.
//

#import "Animal.h"
#import <objc/runtime.h>

@implementation Animal

/**
 手动添加swim方法，在resolveInstanceMethod里，添加swim
 */
void swim(id self,SEL _cmd) {
    NSLog(@"消息转发时增加了swim方法");
}
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if (sel == NSSelectorFromString(@"swim")) {
        class_addMethod(self, @selector(swim), swim, "v@:@");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}


@end
