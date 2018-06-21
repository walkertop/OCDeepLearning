//
//  StudentDataManager.m
//  OCDeepLearning
//
//  Created by walker on 2018/6/21.
//  Copyright © 2018年 walker彬. All rights reserved.
//

#import "StudentDataManager.h"
#import "Student+CoreDataClass.h"
#import <CoreData/CoreData.h>

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

- (void)saveData {
    Student *student = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:self.coreDataContext];
    student.name = @"张三";
    student.gender = YES;
    student.age = 11;
    student.score = 100;
    
    NSError *error;
    [self.coreDataContext save:&error];
    
}


-(NSManagedObjectModel *)coreDataModel
{
    if (!_coreDataModel) {
        _coreDataModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"OCDeepLearningModel" withExtension:@"momd"]];
    }
    return _coreDataModel;
}
-(NSPersistentStoreCoordinator *)coreDataPersistent
{
    if (!_coreDataPersistent) {
        _coreDataPersistent = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self coreDataModel]];
        NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) lastObject];
        NSURL * pathURL = [NSURL  fileURLWithPath:[path stringByAppendingString:@"OCDeepLearningModel.sqlite" ]];
        NSLog(@"路径%@",pathURL);
        NSError * error = nil;
        NSPersistentStore * store = [ _coreDataPersistent  addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:pathURL options:nil error:&error] ;
        if (!store) {
            [NSException raise:@"add database error" format:@"%@" ,[error localizedDescription]];
        }
    }
    return _coreDataPersistent ;
}

-(NSManagedObjectContext *)coreDataContext
{
    if(!_coreDataContext)
    {
        _coreDataContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [_coreDataContext setPersistentStoreCoordinator:[self coreDataPersistent]];
    }
    return _coreDataContext;
}


@end
