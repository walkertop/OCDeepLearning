//
//  BlockLearning.m
//  OCDeepLearning
//
//  Created by walker on 2018/8/14.
//  Copyright © 2018年 walker彬. All rights reserved.
//

#import "BlockLearning.h"

@interface BlockLearning ()

@property(nonatomic, copy) NSArray *intArray;


@end

@implementation BlockLearning

+ (instancetype)sharedInstance {
    static BlockLearning *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)testBlockLearning {

    int (^testBlock)(int a, int b) = ^(int a, int b) {
        return a + b;
    };
    
    self.intblock = ^int(int a, int b) {
        return a - b;
    };
    
    int sum = testBlock(3,4);
    int all = self.intblock(5,6);
    NSLog(@"sum的值%d,all的值%d",sum, all);
}


/*
 * block根据内存分布，有三种类型：
 1. 堆区block
 2. 栈区block
 3. 全局区block
 
 */

- (void)learnBlockMemeryLayout {
    
    
}

@end
