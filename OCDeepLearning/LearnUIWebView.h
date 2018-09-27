//
//  LearnUIWebView.h
//  OCDeepLearning
//
//  Created by walker on 2018/8/20.
//  Copyright © 2018年 walker彬. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LearnUIWebView : UIWebView
+ (instancetype)sharedInstance;
- (void)ui_openURLString:(NSString *)URLString;

@end
