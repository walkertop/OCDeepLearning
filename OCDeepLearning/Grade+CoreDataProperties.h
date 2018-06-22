//
//  Grade+CoreDataProperties.h
//  OCDeepLearning
//
//  Created by walker on 2018/6/22.
//  Copyright © 2018年 walker彬. All rights reserved.
//
//

#import "Grade+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Grade (CoreDataProperties)

+ (NSFetchRequest<Grade *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *gradeName;
@property (nullable, nonatomic, copy) NSString *gradeID;
@property (nullable, nonatomic, retain) Student *studentClass;

@end

NS_ASSUME_NONNULL_END
