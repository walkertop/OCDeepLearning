//
//  NSObject+PrivateMethod.h
//  OCDeepLearning
//
//  Created by walker彬 on 2018/9/27.
//  Copyright © 2018 walker彬. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (PrivateMethod)

- (void)excutePrivateMethodWithSelectorName:(NSString *)selectorName;

+ (void)excutePrivateMethodWithInstanceSelectorName:(NSString *)aSelectorName ForClass:(NSString *)className;

+ (void)excutePrivateMethodWithInstanceSelector:(SEL)aSelector ForClass:(NSString *)className;
@end

NS_ASSUME_NONNULL_END
