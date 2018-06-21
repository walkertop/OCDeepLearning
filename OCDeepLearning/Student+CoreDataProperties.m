//
//  Student+CoreDataProperties.m
//  OCDeepLearning
//
//  Created by walker on 2018/6/21.
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

@end
