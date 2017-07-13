//
//  Person.h
//  OCDeepLearning
//
//  Created by walker彬 on 2017/7/13.
//  Copyright © 2017年 walker彬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property(nonatomic, strong) NSString *name;

- (void)run;
- (void)fly;
- (void)die;

+ (void)classDie;


@end
