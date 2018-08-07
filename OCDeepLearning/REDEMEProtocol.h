//
//  REDEMEProtocol.h
//  OCDeepLearning
//
//  Created by walker彬 on 2018/7/29.
//  Copyright © 2018年 walker彬. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit.h>

@protocol REDEMEProtocol <NSObject>

@optional
- (void)fetchData:(NSString *)fetcherName didReceiveData:(NSData *)data;
- (void)fetchData:(NSString *)fetcherName didFailWithError:(NSError *)error;
//- (void)fetchData:(NSString *)fetcherName didReceiveDataSuccess:(NSData *)data;

@end
