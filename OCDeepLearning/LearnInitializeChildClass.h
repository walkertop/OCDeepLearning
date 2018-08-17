//
//  LearnInitializeChildClass.h
//  OCDeepLearning
//
//  Created by walker on 2018/8/16.
//  Copyright © 2018年 walker彬. All rights reserved.
//

#import "LearnInitializeBaseClass.h"
#import "LearnInitializeFatherClass.h"


@interface LearnInitializeChildClass : LearnInitializeFatherClass

+ (instancetype)sharedInstance;

- (void)test;

@end
