//
//  LearnDatasourceClass.h
//  OCDeepLearning
//
//  Created by walker on 2018/8/17.
//  Copyright © 2018年 walker彬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LearnDatasourceClass : NSObject


+ (instancetype)sharedInstance;

- (void)postNotify;
- (void)addobserveNotify;

@end
