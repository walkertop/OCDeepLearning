//
//  LearnWKWebView.m
//  OCDeepLearning
//
//  Created by walker on 2018/8/20.
//  Copyright © 2018年 walker彬. All rights reserved.
//

#import "LearnWKWebView.h"

@implementation LearnWKWebView

+ (instancetype)sharedInstance {
    static LearnWKWebView *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)wk_openURL:(NSString *)URL {
    
}

@end
