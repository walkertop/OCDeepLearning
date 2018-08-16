//
//  NSObject+Extension.h
//  OCDeepLearning
//
//  Created by walker彬 on 2017/7/25.
//  Copyright © 2017年 walker彬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Extension)

/**
 获取当前对象的引用计数retainCount
 
 @param obj 当前对象obj
 @return retainCount
 */
+ (NSInteger)logRetainCount:(id) obj;


/**
 不要分类的同名方法取代类里的方法

 @param seletor 方法名
 */
+ (void)useClassMethodInsteadOfCayegoryMethod: (SEL)seletor;
@end
