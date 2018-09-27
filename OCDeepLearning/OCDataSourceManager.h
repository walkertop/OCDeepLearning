//
//  OCDataSourceManager.h
//  OCDeepLearning
//
//  Created by walker on 2018/8/29.
//  Copyright © 2018年 walker彬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCDataSourceManager : NSObject

+ (instancetype)sharedInstance;

//获取方法调用次数
- (void)writeCallCountOfMethod:(NSString *)methodName;
@end
