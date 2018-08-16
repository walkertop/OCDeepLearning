//
//  Course+CoreDataProperties.m
//  OCDeepLearning
//
//  Created by walker on 2018/6/22.
//  Copyright © 2018年 walker彬. All rights reserved.
//
//

#import "Course+CoreDataProperties.h"

@implementation Course (CoreDataProperties)

+ (NSFetchRequest<Course *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Course"];
}

@dynamic courseName;
@dynamic courseID;
@dynamic courseStudent;

@end
