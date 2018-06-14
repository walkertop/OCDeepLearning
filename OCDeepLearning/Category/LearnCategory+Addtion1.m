//
//  LearnCategory+Addtion1.m
//  OCDeepLearning
//
//  Created by walker彬 on 2017/7/26.
//  Copyright © 2017年 walker彬. All rights reserved.
//

#import "LearnCategory+Addtion1.h"
#import <objc/runtime.h>

@implementation LearnCategory (Addtion1)

- (void)testCategory {
    NSLog(@"第一个分类的名字是%@,方法名称为%s",[self class], __func__);
}

//运行时动态添加set和get方法（Xcode9 更新了提醒功能，超级牛逼。比如此处在分类里声明了属性，但不添加set/get方法会warnning，这里说下，厉害了我的苹果）
- (void)setNewName:(NSString *)newName
{
    objc_setAssociatedObject(self,
                             "newName",
                             newName,
                             OBJC_ASSOCIATION_COPY);
}

- (NSString*)newName
{
    NSString *nameObject = objc_getAssociatedObject(self, "newName");
    return nameObject;
}
@end
