//
//  Grade+CoreDataProperties.m
//  OCDeepLearning
//
//  Created by walker on 2018/6/22.
//  Copyright © 2018年 walker彬. All rights reserved.
//
//

#import "Grade+CoreDataProperties.h"

@implementation Grade (CoreDataProperties)

+ (NSFetchRequest<Grade *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Grade"];
}

@dynamic gradeName;
@dynamic gradeID;
@dynamic studentClass;

@end
