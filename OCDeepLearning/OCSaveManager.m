//
//  OCSaveManager.m
//  OCDeepLearning
//
//  Created by walker on 2018/6/28.
//  Copyright © 2018年 walker彬. All rights reserved.
//

#import "OCSaveManager.h"
typedef NS_ENUM(NSInteger, OCSaveStyle) {
    OCSaveStyleUserDefault = 0,
    OCSaveStylePlist,
    OCSaveStyleCoder,
    OCSaveStyleKeychain,
    OCSaveStyleCoreData
};

@interface OCSaveManager ()
@property(nonatomic, assign)  OCSaveStyle saveStyle;

@end


@implementation OCSaveManager


+ (instancetype)sharedInstance {
    static OCSaveManager  *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}


- (void)saveDataByStyle:(OCSaveStyle)style {
    if (style == OCSaveStylePlist) {
        //存数据
        NSArray *array = @[@"第1个保存数据",@"第2个保存数据",@"第3个保存数据",@"第4个保存数据"];
        NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        NSString *filePathName = [cachePath stringByAppendingPathComponent:@"name.plist"];
        [array writeToFile:filePathName atomically:YES];
        
        //取数据
        NSString *getCachePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES).firstObject;
        NSString *getFilePathName = [getCachePath stringByAppendingPathComponent:@"name.plist"];
        NSArray *getArray = [NSArray arrayWithContentsOfFile:getFilePathName];
        NSLog(@"Plist取出保存的数据%@",getArray);
        
    } else if (style == OCSaveStyleUserDefault) {
        //存数据
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hasValueOfUserDefault"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        //取数据
        BOOL tmpBOOL = [[NSUserDefaults standardUserDefaults] boolForKey:@"hasValueOfUserDefault"];
        NSLog(@"NSUserDefault取出的数据%d",tmpBOOL);
        
    } else if (style == OCSaveStyleKeychain) {
        
    }
}




@end
