//
//  OCDataSourceManager.m
//  OCDeepLearning
//
//  Created by walker on 2018/8/29.
//  Copyright © 2018年 walker彬. All rights reserved.
//

#import "OCDataSourceManager.h"


@interface OCDataSourceManager()
@property(nonatomic, copy) NSDictionary *callCountDict;
@end


@implementation OCDataSourceManager

+ (instancetype)sharedInstance {
    static OCDataSourceManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)writeCallCountOfMethod:(NSString *)methodName{
    NSNumber *callCount = [self.callCountDict valueForKey:methodName];
    NSInteger count = [callCount integerValue];
    count = count + 1;
    callCount = [NSNumber numberWithInteger:count];
    [self.callCountDict setValue:callCount forKey:methodName];
    NSLog(@"oc_函数调用次数的字典是%@",self.callCountDict);
}

- (NSDictionary *)callCountDict {
    if (!_callCountDict) {
        _callCountDict = [NSDictionary dictionary];
    }
    return _callCountDict;
}

@end
