//
//  Course+CoreDataProperties.h
//  OCDeepLearning
//
//  Created by walker on 2018/6/22.
//  Copyright © 2018年 walker彬. All rights reserved.
//
//

#import "Course+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Course (CoreDataProperties)

+ (NSFetchRequest<Course *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *courseName;
@property (nullable, nonatomic, copy) NSString *courseID;
@property (nullable, nonatomic, retain) Student *courseStudent;

@end

NS_ASSUME_NONNULL_END
