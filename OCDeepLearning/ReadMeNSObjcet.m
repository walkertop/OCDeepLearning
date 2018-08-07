//
//  ReadMeNSObjcet.m
//  OCDeepLearning
//
//  Created by walker彬 on 2018/7/29.
//  Copyright © 2018年 walker彬. All rights reserved.
//

#import "ReadMeNSObjcet.h"


@interface ReadMeNSObjcet()



@end

@implementation ReadMeNSObjcet



//OC中，集合类中的元素，遍历取值，其元素都是id类型，而非强类型
/*
 1. 数组的元素可以为多种对象类型
 */
+ (void)learnIDTypeInCollction {
    //数组
    NSDictionary *learnDict = @{@"key": @"value"};
    NSArray *learnArray = [NSArray arrayWithObjects:@"11", @2, learnDict, nil];
    for (id obj in learnArray) {
        if ([obj isKindOfClass:[NSString class]]) {
            NSLog(@"是NSString类型，值为%@",obj);
        } else if ([obj isKindOfClass:[NSNumber class]]) {
            NSLog(@"是NSNumber类型，值为%@",obj);
        } else if ([obj isKindOfClass:[NSDictionary class]]) {
            NSLog(@"是NSDictionary类型，值为%@",obj);
        }
        
    }
    
//    NSExceptionName
//    [NSException exceptionWithName:<#(nonnull NSExceptionName)#> reason:<#(nullable NSString *)#> userInfo:<#(nullable NSDictionary *)#>
    
}



@end
