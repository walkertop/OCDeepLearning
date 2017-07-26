### SEL,Method,IMP
#### SEL
* SEL方法选择器，表示一个selector的指针
* 无论什么类里，只要方法名相同，SEL就相同。项目里的所有SEL都保存在一个NSSet集合里（NSSet集合里的元素不能重复），所以查找对应方法，只要找到对应的SEL就可以了。
* SEL实际是根据方法名hash化了的字符串


```
SEL sel_registerName(const char *str)//向runtime system注册一个方法名。如果方法名已经注册，则放回已经注册的SEL
SEL sel_getUid(const char *str)//同上
@selector(<#selector#>)//oc编译器提供的
SEL NSSelectorFromString(NSString *aSelectorName)//OC字符串转化
SEL method_getName ( Method m );//根据Method结构体获取
等等
```

SEL的操作函数

```
// 比较两个选择器
BOOL sel_isEqual ( SEL lhs, SEL rhs );
//判断方法名是否映射到某个函数实现上
BOOL sel_isMapped(SEL sel);
```


##### 出现个BUG:
既然SEL是方法的唯一标识，那不同的类调用名字相同的方法怎么办呢？

那就让下一个重要任务出场吧。
#### IMP
定义：函数指针，指向方法实现的首地址。
代码定义如下：

```
typedef id (*IMP)(id, SEL, ...); 
```
其参数包含id,SEL,后面试实际的参数列表。
那么，XX调用了XXX方法，其参数为XX都确定下来了。

##### IMP的高级作用
既然上述元素都确定下来了，那么就可以直接绕过Runtime的消息传递机制，直接执行IMP指向的函数了。省去了一些列的查找，直接向对象发送消息，效率会高一些。

```
IMP imp_implementationWithBlock(id block)//根据代码块获取IMP,其实就是代码块与IMP关联
IMP method_getImplementation(Method m) //根据Method获取IMP
[[objc Class] instanceMethodForSelector:SEL]//根据OC方式获取IMP
```


当我们获取一个方法的IMP时候可以直接调用IMP

```
IMP imp ＝ method_getImplementation(Method m)；
id objc ＝ imp(id,SEL,argument);//objc用来保存方法的返回值，id表示调用这个方法的对象，SEL是Method的选择器，argument是方法的参数。
```


#### Method

Method定义如下：它主要是用语描述类里面的方法

```
typedef struct objc_method *Method;
```
objc_method结构体定义如下

```
struct objc_method {
    SEL method_name                              OBJC2_UNAVAILABLE;//方法名
    char *method_types                           OBJC2_UNAVAILABLE;//参数返回值字符串描述
    IMP method_imp                               OBJC2_UNAVAILABLE;//方法的实现
}    
```

从上述代码可以看出，Method是一个结构体，包含了SEL和IMP成员变量。
实际上，相当于在SEL和IMP之间做了一个映射，有了Method，SEL就可以找到对应的IMP，从而调用方法。


##### Method操作函数如下：

```
方法操作主要有以下函数：
// 添加方法
BOOL class_addMethod ( Class cls, SEL name, IMP imp, const char *types );

// 获取实例方法
Method class_getInstanceMethod ( Class cls, SEL name );

// 获取类方法
Method class_getClassMethod ( Class cls, SEL name );

// 获取所有方法的数组
Method * class_copyMethodList ( Class cls, unsigned int *outCount );

// 替代方法的实现
IMP class_replaceMethod ( Class cls, SEL name, IMP imp, const char *types );

// 返回方法的具体实现
IMP class_getMethodImplementation ( Class cls, SEL name );
IMP class_getMethodImplementation_stret ( Class cls, SEL name );

// 类实例是否响应指定的selector
BOOL class_respondsToSelector ( Class cls, SEL sel );
```

此处具体实现比较简单，可以通过手动操作IMP来完成方法的调用。

实例代码：


```
#import "OC_IMP.h"


typedef void (^CustomBlock)(NSString *name);

@interface OC_IMP ()

@property(nonatomic, weak) CustomBlock block;

@end

@implementation OC_IMP

- (void)testIMP {
    [self addMethodByIMP];
}

//定义一个block
//手动添加方法
- (void)addMethodByIMP {
    CustomBlock block = ^(NSString *name){
        NSLog(@"执行block");
    };
    
    IMP impBlock = imp_implementationWithBlock(block);
    Method m = class_getInstanceMethod(self.class, @selector(testIMP));
    method_setImplementation(m, impBlock);
    const char * types = method_getTypeEncoding(m); //因为方法类型相同（都是无参数无返回值类型，所以方法类型相同，如果知道的话，可以直接制定type为v16@0:8）
    sel_registerName("newSel");             //注册newSel
    BOOL isAdded = class_addMethod([self class], @selector(newSel), impBlock, types);
    if (isAdded == YES) {
        NSLog(@"添加成功");
        [self performSelector:@selector(newSel)];
    }
}

@end
```


```
    OC_IMP *oc_imp = [[OC_IMP alloc] init];
    [oc_imp testIMP];
```

调用执行结果

```
2017-07-14 20:14:26.359 OCDeepLearning[5654:530015] 添加成功
2017-07-14 20:14:26.359 OCDeepLearning[5654:530015] 执行block
```


补充：
1. 在swift里可以使用#selector(XXX)来获取对应的SEL,但这并非指swift的方法调用是通过selector来实现的，能调用仅仅是因为swift和OC的混编；
2. 每个方法名有对应的唯一seletor,其SEL相同，但对应的IMP函数指针不同。

