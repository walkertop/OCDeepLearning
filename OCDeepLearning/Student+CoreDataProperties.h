//
//  Student+CoreDataProperties.h
//  OCDeepLearning
//
//  Created by walker on 2018/6/22.
//  Copyright © 2018年 walker彬. All rights reserved.
//
//

#import "Student+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Student (CoreDataProperties)

+ (NSFetchRequest<Student *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) int16_t age;
@property (nonatomic) BOOL gender;
@property (nonatomic) int16_t score;
@property (nullable, nonatomic, retain) Grade *gradeStudent;
@property (nullable, nonatomic, retain) Course *courseStudent;

@end

NS_ASSUME_NONNULL_END
