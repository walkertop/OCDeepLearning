//
//  NSObject+GBRuntimeLog.h
//  GBRuntime
//
//  Created by walker彬 on 2017/7/5.
//  Copyright © 2017年 walker彬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (GBRuntimeLog)

+ (NSArray *)classes;                               //获取当前类
+ (NSArray *)properties;                            //获取所有属性    (获取属性)
+ (NSArray *)instanceVariables;                     //获取实例变量    (可以获取私有成员变量)

+ (NSArray *)classMethods;                          //获取类方法 (可以获取私有方法）
+ (NSArray *)instanceMethods;                       //获取实例方法  (可以获取私有方法）
+ (NSArray *)methodLists;                           //获取所有的方法列表

+ (NSArray *)protocols;                             //获取协议
+ (NSDictionary *)descriptionForProtocol:(Protocol *)proto; //获取某个协议的描述

+ (NSString *)parentClassHierarchy;                 //获取继承链条
@end
