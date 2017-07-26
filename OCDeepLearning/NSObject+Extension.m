//
//  NSObject+Extension.m
//  OCDeepLearning
//
//  Created by walker彬 on 2017/7/25.
//  Copyright © 2017年 walker彬. All rights reserved.
//

#import "NSObject+Extension.h"
#import <objc/runtime.h>

@implementation NSObject (Extension)

+ (NSInteger)logRetainCount:(id)obj {
    uintptr_t _objc_rootRetainCount(id obj);
    NSLog(@"当前对象为:%@\n,其引用计数的retainCount为%lu",obj,_objc_rootRetainCount(obj));
    unsigned long retainCount = _objc_rootRetainCount(obj);
    return retainCount;
}

+ (void)useClassMethodInsteadOfCayegoryMethod: (SEL)seletor {
    
    if (self) {
        unsigned int methodCount;
        Method *methodList = class_copyMethodList([self class], &methodCount);
        IMP lastImp = NULL;
        SEL lastSel = NULL;
        for (NSInteger i = 0; i < methodCount; i++) {
            Method method = methodList[i];
            NSString *methodName = [NSString stringWithCString:sel_getName(method_getName(method))
                                                      encoding:NSUTF8StringEncoding];
            NSString *selectorName = NSStringFromSelector(seletor);
            if ([selectorName isEqualToString:methodName]) {
                lastImp = method_getImplementation(method);
                lastSel = method_getName(method);
            }
        }
        typedef void (*fn)(id,SEL);
        
        if (lastImp != NULL) {
            fn f = (fn)lastImp;
            f(self,lastSel);
        }
        free(methodList);
    }
}


@end
