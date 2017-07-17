//
//  OC_AClass.m
//  OCDeepLearning
//
//  Created by walker彬 on 2017/7/17.
//  Copyright © 2017年 walker彬. All rights reserved.
//

#import "OC_AClass.h"

@interface OC_AClass ()

@property(nonatomic, strong) NSString *name;

@end

@implementation OC_AClass
{
    NSString *customName;     //成员变量
}

@synthesize name = customName;


- (void)testName {
//    _name = @"_Walker";
    customName = @"Walker";
    NSLog(@"%@",self.name); //打印结果为   Walker

    
}
@end
