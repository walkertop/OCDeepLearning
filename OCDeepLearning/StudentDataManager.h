//
//  StudentDataManager.h
//  OCDeepLearning
//
//  Created by walker on 2018/6/21.
//  Copyright © 2018年 walker彬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StudentDataManager : NSObject


+ (instancetype)shareInstance;

- (void)saveData;



@end
