//
//  OCAutoReleasePool.h
//  OCDeepLearning
//
//  Created by walker彬 on 2017/7/7.
//  Copyright © 2017年 walker彬. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface OCAutoReleasePool : NSObject

- (void)createNumbersOfObjects;
- (void)createNumbersOfObjectsByautoReleasePool;
- (void)monitorAsyncAutoReleasePool;

@end

@interface OCAutoReleasePool (Runtime)

+ (void)load;

@end
