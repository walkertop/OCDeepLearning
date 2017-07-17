# OCDeepLearning
## OC的高级用法和学习

### 文章主要包含以下部分：

* OC的黑魔法
* 底层的方法
    * IMP,SEL,Method的本质
    * 添加IMP实现方法调用（OC_IMP.h类）  
* 内存管理
    * 自动释放池
    * ARC和MRC
* 多线程
    * GCD的基础用法 
        * Queue
            * dispatch_create
            * 系统队列
                *  Main Dispatch Queue/Global Dispatch Queue 
    * GCD的高级用法
        *   `Dispatch Group`
            * notify
            * wait
        *   `dispatch_barrier_aync`
        *   `dispatch_set-target-queue`
        *   `dispatch_after`
        *   `dispatch_apply`
        *   `dispatch_suspend/resume`
        *   `dispatch_once`


### ARC
* 内部循环使用自动释放池
* 测试@synthesize(OC_AClass)

### NSRunloop
* 子线程的NSTimer和NSRunLoop

```
子线程有RunLoop，但默认不开启，
而NSTimer事件依赖NSRunLoop，
只有手动开启子线程的NSRunLoop，
并将NSTimer添加进去才可以运行。
```
### Runtime
 * [消息转发代码实现](https://github.com/walkertop/OCDeepLearning/blob/master/消息转发流程.md)  
* `load` 和 `initialize`方法初探
* `swizzling method`系列
* `SEL`，`IMP`，`Method`的区别
    [SEL&IMP&Method区别](https://github.com/walkertop/OCDeepLearning/blob/master/SEL-IMP-Method解析.md)
    
### 工具类
* GBRunLoopLog工具类
    * 支持多种输出

   
```    
+ (NSArray *)classes;                               //获取当前类
+ (NSArray *)properties;                            //获取所有属性    (获取属性)
+ (NSArray *)instanceVariables;                     //获取实例变量    (可以获取私有成员变量)
+ (NSArray *)classMethods;                          //获取类方法 (可以获取私有方法）
+ (NSArray *)instanceMethods;                       //获取实例方法  (可以获取私有方法）

+ (NSArray *)protocols;                             //获取协议
+ (NSDictionary *)descriptionForProtocol:(Protocol *)proto; //获取某个协议的描述

+ (NSString *)parentClassHierarchy;                 //获取继承链条
```

## 文末
主要是针对各种魔法提供代码的用例以及高级技巧的使用介绍。
基于底层的实现原理，会选择性提供优质的博客以论证。


