//
//  OCBaseManager.m
//  OCDeepLearning
//
//  Created by walker on 2018/6/28.
//  Copyright © 2018年 walker彬. All rights reserved.
//

/*
 此类作为所有功能类数据源的描述，英语管理数据源
 
 */
#import "OCBaseManager.h"

@interface OCBaseManager ()
@property(nonatomic, strong) NSMutableDictionary *sourceDict;

@end

@implementation OCBaseManager

+ (instancetype)sharedInstance {
    static OCBaseManager  *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!sharedInstance) {
            sharedInstance = [[self alloc] init];
        }
    });
    return sharedInstance;
}


- (void)insertContentInSourceDict:(NSArray *)insertArray keyName:(NSString *)keyName {
    [self.sourceDict setObject:insertArray forKey:keyName];
    
}

- (NSArray *)getArrayFromDictOfKey:(NSString *)keyString {
    
    NSArray *tmpArray = [self.sourceDict valueForKey:keyString];
    return tmpArray;
}



@end
