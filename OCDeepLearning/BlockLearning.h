//
//  BlockLearning.h
//  OCDeepLearning
//
//  Created by walker on 2018/8/14.
//  Copyright © 2018年 walker彬. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef int(^OCIntBlock)(int a, int b);

@interface BlockLearning : NSObject

@property(nonatomic, assign) OCIntBlock intblock;

+ (instancetype)sharedInstance;

- (void)testBlockLearning;

@end
