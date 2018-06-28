//
//  OCBaseManager.h
//  OCDeepLearning
//
//  Created by walker on 2018/6/28.
//  Copyright © 2018年 walker彬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCBaseManager : NSObject

+ (instancetype)sharedInstance;

- (void)insertContentInSourceDict:(NSArray *)insertArray keyName:(NSString *)keyName;
- (NSArray *)getArrayFromDictOfKey:(NSString *)keyString;

@end
