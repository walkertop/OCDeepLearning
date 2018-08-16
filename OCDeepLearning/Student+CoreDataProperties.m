//
//  Student+CoreDataProperties.m
//  OCDeepLearning
//
//  Created by walker on 2018/6/22.
//  Copyright © 2018年 walker彬. All rights reserved.
//
//

#import "Student+CoreDataProperties.h"

@implementation Student (CoreDataProperties)

+ (NSFetchRequest<Student *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Student"];
}

@dynamic name;
@dynamic age;
@dynamic gender;
@dynamic score;
@dynamic gradeStudent;
@dynamic courseStudent;

@end
