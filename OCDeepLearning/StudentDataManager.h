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

//数据库操作的增删改查——(CRUD)
- (void)saveSingleData;
- (void)saveMassData;

- (void)deleteSingleData;
- (void)deleteMassData;

- (void)updateSingleData;
- (void)updateMassData;

- (void)fetchSingleData;
- (void)fetchMassData;


@end
