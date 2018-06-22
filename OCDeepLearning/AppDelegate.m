//
//  AppDelegate.m
//  OCDeepLearning
//
//  Created by walker彬 on 2017/7/7.
//  Copyright © 2017年 walker彬. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+Addtions.h"
#import <CoreData/CoreData.h>


@interface AppDelegate ()

//@property(nonatomic, strong) NSManagedObjectModel *managedObjectModel;
//@property(nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self setupRootVC];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}




#pragma mark - privete method

//- (NSManagedObjectModel *)managedObjectModel {
//    if (!_managedObjectModel) {
//        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"OCDeepLearningModel" withExtension:@"momd"];
//        _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
//    }
//    return _managedObjectModel;
//}
//
//- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
//    if (!_persistentStoreCoordinator) {
//        _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
//
//        NSURL *urlString = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].firstObject;
//        NSURL *sqliteURL = [urlString URLByAppendingPathComponent:@"OCDeepLearningModel.sqlite"];
//        NSError *error;
//        [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:sqliteURL options:nil error:&error];
//        if (error) {
//            NSLog(@"数据库存储失败，原因为 %@",error.localizedDescription);
//        }
//    }
//    return _persistentStoreCoordinator;
//}



@end
