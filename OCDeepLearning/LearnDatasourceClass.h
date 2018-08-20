//
//  LearnDatasourceClass.h
//  OCDeepLearning
//
//  Created by walker on 2018/8/17.
//  Copyright © 2018年 walker彬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LearnDatasourceClass : NSObject

@property(nonatomic, copy) NSString *KVOString;

+ (instancetype)sharedInstance;

- (void)postNotify;
- (void)learnKVO;


@end
