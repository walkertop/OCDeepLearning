//
//  LearnUIWebView.m
//  OCDeepLearning
//
//  Created by walker on 2018/8/20.
//  Copyright © 2018年 walker彬. All rights reserved.
//

#import "LearnUIWebView.h"

@implementation LearnUIWebView

+ (instancetype)sharedInstance {
    static LearnUIWebView *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)ui_openURLString:(NSString *)URLString{
    NSURL *URL = [NSURL URLWithString:URLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    [self loadRequest:request];
}

@end
