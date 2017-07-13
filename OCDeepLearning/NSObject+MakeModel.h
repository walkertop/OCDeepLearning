//
//  NSObject+MakeModel.h
//  OCDeepLearning
//
//  Created by walker彬 on 2017/7/13.
//  Copyright © 2017年 walker彬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (MakeModel)

+ (instancetype)modelWithDict:(NSDictionary *)dict;
+ (instancetype)modelWithDict:(NSDictionary *)dict updateDict:(NSDictionary *)updateDict;
@end
