//
//  StudentDataManager.m
//  OCDeepLearning
//
//  Created by walker on 2018/6/21.
//  Copyright © 2018年 walker彬. All rights reserved.
//

#import "StudentDataManager.h"
#import "Student+CoreDataClass.h"
#import "Grade+CoreDataClass.h"
#import "Course+CoreDataClass.h"

#import <CoreData/CoreData.h>
#import <CoreData/NSPersistentStoreRequest.h>

static StudentDataManager  *sharedInstance = nil;

@interface StudentDataManager ()


@property ( strong , nonatomic) NSManagedObjectContext *coreDataContext;
@property ( strong , nonatomic) NSManagedObjectModel *coreDataModel;
@property ( strong , nonatomic) NSPersistentStoreCoordinator  *coreDataPersistent;

@end


@implementation StudentDataManager

+ (instancetype)shareInstance {
//    static StudentDataManager  *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!sharedInstance) {
            sharedInstance = [[self alloc] init];
        }
    });

    return sharedInstance;
}

//+(id) allocWithZone:(struct _NSZone *)zone
//{
//    return sharedInstance;
//}
//
//-(id) copyWithZone:(struct _NSZone *)zone
//{
//    return sharedInstance;
//}


#pragma mark - 增加数据
- (void)saveSingleData {
    Student *student = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:self.coreDataContext];
    student.name = @"张三";
    student.gender = YES;
    student.age = 11;
    student.score = 100;
    
    NSError *error;
    [self.coreDataContext save:&error];
    if (![self.coreDataContext save:&error]) {
        NSLog(@"不能保存，原因是%@",error.localizedDescription);
    }
}

- (void)saveMassData {
    for (int i = 0;i < 100; i++) {
        Student *student = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:self.coreDataContext];
        student.name = [NSString stringWithFormat:@"student-%d", i];;
        student.age = i;
        student.score = i;
    }
    NSError *error;
    [self.coreDataContext save:&error];
    if (![self.coreDataContext save:&error]) {
        NSLog(@"不能保存，原因是%@",error.localizedDescription);
    }
}

#pragma mark - 删除数据
- (void)deleteSingleData {
    
//    for (Student *student in students) {
//        [self.coreDataContext deleteObject:student];
//    }
//    [self.coreDataContext save:nil]; // 最后不要忘了调用 save 使操作生效。
}

- (void)deleteMassData {
    NSFetchRequest *deleteFetch = [Student fetchRequest];
    
    deleteFetch.predicate = [NSPredicate predicateWithFormat:@"age >= %@", @(50)];
    
    NSBatchDeleteRequest *deleteRequest = [[NSBatchDeleteRequest alloc] initWithFetchRequest:deleteFetch];
    deleteRequest.resultType = NSBatchDeleteResultTypeObjectIDs;
    
    NSBatchDeleteResult *deleteResult = [self.coreDataContext executeRequest:deleteRequest error:nil];
    NSArray<NSManagedObjectID *> *deletedObjectIDs = deleteResult.result;
    
    NSDictionary *deletedDict = @{NSDeletedObjectsKey : deletedObjectIDs};
    [NSManagedObjectContext mergeChangesFromRemoteContextSave:deletedDict intoContexts:@[self.coreDataContext]];
    
}

#pragma mark - 更改数据
- (void)updateSingleData {
    
}

- (void)updateMassData {
    
    // 根据 entityName 创建
    NSBatchUpdateRequest *updateRequest = [[NSBatchUpdateRequest alloc] initWithEntityName:@"Student"];
    updateRequest.predicate = [NSPredicate predicateWithFormat:@"age == %@", @(20)];
    updateRequest.propertiesToUpdate = @{@"name" : @"newName"};
    updateRequest.resultType = NSUpdatedObjectIDsResultType;
    NSError *error;
    NSBatchUpdateResult *updateResult = [self.coreDataContext executeRequest:updateRequest error:&error];
    NSArray<NSManagedObjectID *> *updatedObjectIDs = updateResult.result;
    NSLog(@"更改之后的结果为%@",updatedObjectIDs);
    
    NSDictionary *updatedDict = @{NSUpdatedObjectsKey : updatedObjectIDs};
    [NSManagedObjectContext mergeChangesFromRemoteContextSave:updatedDict intoContexts:@[self.coreDataContext]];
}

#pragma mark - 查询数据
- (void)fetchSingleData {
    NSFetchRequest *fetchRequest = [Student fetchRequest];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"age > %@", @(90)];
    fetchRequest.fetchLimit = 8;
    NSArray<NSSortDescriptor *>*sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"age" ascending:YES]];
    fetchRequest.sortDescriptors = sortDescriptors;
    NSArray<Student *> *students = [self.coreDataContext executeFetchRequest:fetchRequest error:nil];
    NSLog(@"查询的结果是%@",students);
}

- (NSInteger )fetchMassData {
    NSFetchRequest *fetchRequest = [Student fetchRequest];
    
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"age > %@", @(90)];
//    fetchRequest.fetchLimit = 8;

    NSArray<NSSortDescriptor *>*sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"age" ascending:YES]];
    fetchRequest.sortDescriptors = sortDescriptors;
    NSArray<Student *> *students = [self.coreDataContext executeFetchRequest:fetchRequest error:nil];
    NSLog(@"查询的结果是%@",students);
    
    return [students count];
    
}

#pragma mark - lazy
- (NSManagedObjectModel *)coreDataModel {
    if (!_coreDataModel) {
        _coreDataModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"OCDeepLearning" withExtension:@"momd"]];
    }
    return _coreDataModel;
}

- (NSPersistentStoreCoordinator *)coreDataPersistent {
    if (!_coreDataPersistent) {
        _coreDataPersistent = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self coreDataModel]];
        NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) lastObject];
        NSURL * pathURL = [NSURL  fileURLWithPath:[path stringByAppendingString:@"OCDeepLearning.sqlite" ]];
        NSLog(@"路径%@",pathURL);
        NSError * error = nil;
        
        NSDictionary *optionsDict = [NSDictionary dictionary];
        [optionsDict setValue:[NSNumber numberWithBool:YES] forKey:NSMigratePersistentStoresAutomaticallyOption];
        [optionsDict setValue:[NSNumber numberWithBool:YES] forKey:NSInferMappingModelAutomaticallyOption];
        
        NSPersistentStore *store = [_coreDataPersistent  addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:pathURL options:optionsDict error:&error];
        if (!store) {
            [NSException raise:@"add database error" format:@"%@" ,[error localizedDescription]];
        }
    }
    return _coreDataPersistent ;
}

- (NSManagedObjectContext *)coreDataContext {
    if(!_coreDataContext)
    {
        _coreDataContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [_coreDataContext setPersistentStoreCoordinator:[self coreDataPersistent]];
    }
    return _coreDataContext;
}

#pragma mark - 关联属性
- (void)addCoursePropertyForStudent {
    Student *student = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:self.coreDataContext];
    Grade *grade = [[Grade alloc] initWithContext:self.coreDataContext];
    grade.gradeName = @"初一";
    grade.gradeID = @"7";
    student.gradeStudent = grade;
    [self.coreDataContext save:nil];
}


@end
