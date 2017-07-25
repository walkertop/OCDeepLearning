//
//  OC_IMP.m
//  OCDeepLearning
//
//  Created by walker彬 on 2017/7/14.
//  Copyright © 2017年 walker彬. All rights reserved.
//

#import "OC_IMP.h"


typedef void (^CustomBlock)(NSString *name);

@interface OC_IMP ()

@property(nonatomic, weak) CustomBlock block;

@end

@implementation OC_IMP

- (void)testIMP {
    [self addMethodByIMP];
}

//定义一个block
//手动添加方法
- (void)addMethodByIMP {
    CustomBlock block = ^(NSString *name){
        NSLog(@"执行block");
    };
    
    IMP impBlock = imp_implementationWithBlock(block);
    Method m = class_getInstanceMethod(self.class, @selector(testIMP));
    method_setImplementation(m, impBlock);
    const char * types = method_getTypeEncoding(m); //因为方法类型相同（都是无参数无返回值类型，所以方法类型相同，如果知道的话，可以直接制定type为v16@0:8）
    sel_registerName("newSel");             //注册newSel
    BOOL isAdded = class_addMethod([self class], @selector(newSel), impBlock, types);
    if (isAdded == YES) {
        NSLog(@"当前类为%@：手动添加IMP成功",[self class]);
        [self performSelector:@selector(newSel)];
    }
}


@end
