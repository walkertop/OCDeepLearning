//
//  LearnWKWebView.h
//  OCDeepLearning
//
//  Created by walker on 2018/8/20.
//  Copyright © 2018年 walker彬. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WKWebView.h>

@interface LearnWKWebView : WKWebView
+ (instancetype)sharedInstance;



- (void)wk_openURLString:(NSString *)URLString;


@end
