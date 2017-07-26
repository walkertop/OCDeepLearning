# 关于Category的深入说明

> Category是在`Objective-C 2.0`时提供的新的语言特性，其原因简单，不管类设计的多么完美，总有无法预测的状况，Category就是作为一种方式来扩展类的。

关于基础部分，网上很多相关文档可供查阅，此文不赘述。
作者只做分类的底层及高级用法作使用说明。

#### 1. 分类会覆盖掉本类的方法，是怎么覆盖的？本类方法就不存在了么？

```
1. category的方法没有“完全替换掉”原来类已经有的方法，也就是说如果category和原来类都有methodA，那么category附加完成之后，类的方法列表里会有两个methodA
2. category的方法被放到了新方法列表的前面，而原来类的方法被放到了新方法列表的后面，这也就是我们平常所说的category的方法会“覆盖”掉原来类的同名方法，这是因为运行时在查找方法的时候是顺着方法列表的顺序查找的，它只要一找到对应名字的方法，就会罢休^_^，殊不知后面可能还有一样名字的方法。
```
#### 2. 既然没有类方法存在，我能通过什么办法使类方法不被覆盖掉么？

```
/*
怎么调用到原来类中被category覆盖掉的方法？
对于这个问题，我们已经知道category其实并不是完全替换掉原来类的同名方法，只是category在方法列表的前面而已，所以我们只要顺着方法列表找到最后一个对应名字的方法，就可以调用原来类的方法：
*/
Class currentClass = [MyClass class];
MyClass *my = [[MyClass alloc] init];

if (currentClass) {
    unsigned int methodCount;
    Method *methodList = class_copyMethodList(currentClass, &methodCount);
    IMP lastImp = NULL;
    SEL lastSel = NULL;
    for (NSInteger i = 0; i < methodCount; i++) {
        Method method = methodList[i];
        NSString *methodName = [NSString stringWithCString:sel_getName(method_getName(method)) 
                                        encoding:NSUTF8StringEncoding];
        if ([@"printName" isEqualToString:methodName]) {
            lastImp = method_getImplementation(method);
            lastSel = method_getName(method);
        }
    }
    typedef void (*fn)(id,SEL);

    if (lastImp != NULL) {
        fn f = (fn)lastImp;
        f(my,lastSel);
    }
    free(methodList);
}
```

#### 3.category怎么关联对象的？
```
#import <Foundation/Foundation.h>
#import "LearnCategoryClass.h"

@interface LearnCategoryClass (Addition)

@property(nonatomic, strong) NSString *newName;

```
-------

```

#import "LearnCategoryClass+Addition.h"
#import <objc/runtime.h>

@implementation LearnCategoryClass (Addition)

- (void)testCategory {
    NSLog(@"分类里是%@,方法名是%s",[self class], __PRETTY_FUNCTION__);
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
```


#### 最后一个生僻的问题：
> 1. category里的方法是什么时候注册到Class的`method_list`的，在`+load`阶段么？
2. 如果有多个category，怎么办？

好吧，这其实不是一个问题，是一串问题。

我们知道，在类class和category中都可以有`+load`方法，那么有两个问题：
> 1. 在class的`+load`方法调用的时候，我们可以调用category中声明的方法么？
2. 这么些个`+load`方法，调用顺序是咋样的呢？

--------

>答案是
1. 可以调用，而且附加category到类的工作会先于`+load`方法的执行；
2. ``+load``的执行顺序是先class，后category，而category的`+load`执行顺序是根据编译顺序决定的。

目前的编译顺序是这样的：

虽然对于`+load`的执行顺序是这样，但是对于“覆盖”掉的方法，则会先找到最后一个编译的category里的对应方法。
编译顺序可以在 `Build Phases`里的`Compile Source`里修改。

### 奇葩问答：

* 如果在分类里声明了，但不实现，`method_list`里不会有,当然也不会调用分类方法。但若是实现了，即使不在.h文件声明，也会调用分类的方法；
* 如果分类里是`- (void)testCategory`，而Class里是`- (int)testCategory`;返回值不同，也会覆盖，因为虽然返回值不同，但OC里，这两者依然是一个方法。
* 对于多个分类，方法的调用是执行最后编译的分类方法；

[参考文章](https://tech.meituan.com/DiveIntoCategory.html)


