//
//  SEL.m
//  OCDeepLearning
//
//  Created by walker彬 on 2017/7/14.
//  Copyright © 2017年 walker彬. All rights reserved.
//

#import "OC_SEL.h"


@implementation OC_SEL

- (void)testSEL {
    SEL SEL1Name = sel_getUid("SEL1");      //获取SEL的名字
    NSLog(@"当前类为%@，%s",[self class],SEL1Name);
    
//    SEL SEL1Name = NSSelectorFromString(@"SEL1");   和上述方法结果相同
    
    //SEL是存在系统的某处，所以即使不是当前类的方法，也可以判断是否存在
    SEL viewDidLoad = sel_getUid("viewDidLoad");
    BOOL isMapped = sel_isMapped(viewDidLoad);
    NSLog(@"%i",isMapped);
}

@end
