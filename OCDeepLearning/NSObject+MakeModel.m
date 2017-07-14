//
//  NSObject+MakeModel.m
//  OCDeepLearning
//
//  Created by walker彬 on 2017/7/13.
//  Copyright © 2017年 walker彬. All rights reserved.
//

#import "NSObject+MakeModel.h"
#import <objc/Object.h>

@implementation NSObject (MakeModel)

+ (instancetype)modelWithDict:(NSDictionary *)dict updateDict:(NSDictionary *)updateDict {
    id model = [[self alloc] init];
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList(self, &count);
    for (int i = 0; i < count; i++) {
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivars[i])];
        ivarName = [ivarName substringFromIndex:1];
        id value = dict[ivarName];
        if (value == nil) {
            if (updateDict) {
                NSString *keyName = updateDict[ivarName];
                value = dict[keyName];
            }
            [model setValue:value forKey:ivarName];
        }
    }
    return model;
}

+ (instancetype)modelWithDict:(NSDictionary *)dict {
    return [self modelWithDict:dict updateDict:nil];
}

@end
