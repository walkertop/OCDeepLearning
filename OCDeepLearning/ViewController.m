//
//  ViewController.m
//  OCDeepLearning
//
//  Created by walker彬 on 2017/7/7.
//  Copyright © 2017年 walker彬. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "NSObject+GBRuntimeLog.h"
#import "OCAutoReleasePool.h"
#import "AClass.h"
#import "GCDLearning.h"
#import "Person.h"
#import "Animal.h"
#import "UserModel.h"
#import "NSObject+MakeModel.h"
#import "OC_SEL.h"
#import "OC_IMP.h"
#import "OC_Method.h"
#import "OC_AClass.h"
#import "NSObject+Extension.h"
#import "LearnCategory.h"
#import "OCDLLayer.h"
#import "OCDLView.h"
#import "ReadMeNSObjcet.h"
#import "BlockLearning.h"
#import "LearnInitializeChildClass.h"

#import "LearnDatasourceClass.h"
#import "LearnUIWebView.h"
#import "LearnWKWebView.h"

#import "LearnSelfAndSuper.h"

#import "OCLearningOOP+GetPrivate.h"
#import "NSObject+PrivateMethod.h"
#import "OCLearningOOP.h"




static NSString  *const kFuntionListOfViewController = @"funtionListOfViewController";

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) UITableView *funtionStyleTableView;
@property(nonatomic, strong) NSArray *funtionStyleArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.funtionStyleArray = @[@"自动释放池",@"GCD相关",@"KVC",@"SEL",@"分类Category",@"获取对象的引用计数",@"消息转发",@"测试SEl-IMP-Method",@"block",@"GCD的leave,enter和wait",@"initialize",@"UIWebView",@"WKWebView",@"self&super",@"调用私有方法的几种方式"];
    [self.funtionStyleTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kFuntionListOfViewController];
    [self.view addSubview:self.funtionStyleTableView];
    [ReadMeNSObjcet learnIDTypeInCollction];
//    APTBegin;
//    APTBeginSection("test");
    // Do any additional setup after loading the view, typically from a nib.

//    [self testAutoReleasePool];
//    [self testGCD];
//    [self testForwardingMethod];
//    [self testResolveInstanceMethod];
//    [self testKVC];
    
//    [self testOCSEL];
//    [self testSELIMPMEthod];
    
 
//    [self testSynthesize];
    
//    NSArray *array = [UIView properties];
//    NSArray *classMethod = [UIView classMethods];
//    NSLog(@"%@",array);
//    [NSObject logRetainCount:self];   //类方法获取对象的引用计数retainCount
    
//    [self testLearnCategory];
//    APTEndSection("test");
//    APTEnd;
    
//    [[LearnDatasourceClass sharedInstance] postNotify];
    [[LearnDatasourceClass sharedInstance] learnKVO];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// MARK: 测试自动释放池
- (void)testAutoReleasePool {
    OCAutoReleasePool *testPool = [[OCAutoReleasePool alloc] init];
    //没有加入自动释放池
    [testPool createNumbersOfObjects];
//    //加入自动释放池
    [testPool createNumbersOfObjectsByautoReleasePool];
    //检测异步线程自动释放池
//    [testPool monitorAsyncAutoReleasePool];
    //开启子线程的runloop并将NSTimer事件添加进去才可以
//    [testPool testTimerInAsync];
}

// MARK: 测试GCD
- (void)testGCD {
    GCDLearning *gcd = [[GCDLearning alloc] init];
    
//    [gcd testBarrier];
//    [gcd testSyncMain];
    [gcd testWait];
//    [gcd testQueue];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [gcd testGroup];
//    });
}

// MARK: 消息转发
- (void)testForwardingMethod {
    Person *person = [[Person alloc] init];
    //实例方法
    [person run];       //  [person run]   等于  objc_msgSend(person,@selector(run))
    [person fly];
    [person die];
    
    //类方法的消息转发
    [Person classDie];
}

// 测试动态加载方法
- (void)testResolveInstanceMethod {
    Animal *ani = [[Animal alloc] init];
    [ani swim];
}

//字典转模型
- (void)testKVC {
    // 从网络请求数据
    //次数据从网上获取
    NSString *githubAPI = @"https://api.github.com/users/Tuccuay";
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:githubAPI]];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                                                
                                                // 因为 Github 的 API 中有一个字段是 id
                                                // 而 id 在 Objective-C 中已经被占用
                                                // GithubUser *tuccuay = [GithubUser modelWithDict:dict];
                                                
                                                // 所以把 id 替换成 ID
                                                UserModel *userModel = [UserModel modelWithDict:dict updateDict:@{@"ID":@"id"}];
                                                
                                                // 给下面的 NSLog 打个断点
                                                // 从调试器里能看见上面的 tuccuay 模型已经转好了
                                                NSLog(@"mew~");
                                            }];
    [task resume];
}

// MARK: 测试SEl-IMP-Method
- (void)testSELIMPMEthod {
    [self testOCSEL];
    [self testOCIMP];
    [self testMethod];
}

- (void)testOCSEL {
    OC_SEL *oc_sel = [[OC_SEL alloc] init];
    [oc_sel testSEL];
}




- (void)testOCIMP {
    OC_IMP *oc_imp = [[OC_IMP alloc] init];
    [oc_imp testIMP];
}

- (void)testMethod {
    OC_Method *method = [[OC_Method alloc] init];
    [method testMethod];
}

/**
 验证子类和父类里同一个selector，其IMP(函数指针)是否相同
 */
- (void)getIMPFromSelector {
    IMP a = [self methodForSelector:@selector(setObject:forKey:)];
    IMP b = [self.view methodForSelector:@selector(setValue:forKey:)];
    NSLog(@"%p",a);
    NSLog(@"%p",b);
}

// MARK: 测试RuntimeLog文件
- (void)testRuntimeLog {
    NSArray *propertiesArray = [OC_IMP properties];
    NSArray *instanceVariablesArray = [OC_IMP instanceVariables];
    NSArray *protocolsArray = [OC_IMP protocols];
    NSLog(@"%@,%@,%@",propertiesArray,instanceVariablesArray,protocolsArray);
}

// MARK: synthesize
- (void)testSynthesize {
    OC_AClass *aClass = [[OC_AClass alloc] init];
    [aClass testName];
}

// MARK: 测试引用计数器的原理:
/*
引用计数器底层是一个哈希散列表，以对象的内存地址作为key值，
 */
- (void)testRetainCount {
    //    id arr = [NSArzray arrayWithObject:@"123"];
    //    NSDictionary *dic = @{@"name": @"zhangsan"};
    //    id value = [NSObject valueForKey:dic.allKeys[0]];
    //    NSHashTable
    //    id value = [NSHashTable valueForKey:arr];
    //    NSHashTable *hashTable = [NSHashTable]
    //    NSLog(@"%@",value);
}

// MARK: 测试category
- (void)testLearnCategory {
    LearnCategory *cate = [[LearnCategory alloc] init];
    [cate testCategory];        //调用分类方法
    [LearnCategory useClassMethodInsteadOfCayegoryMethod:@selector(testCategory)];  //此时调用class里的方法

    NSLog(@"成员变量为%@",[LearnCategory instanceVariables]);//没有newName的成员变量，只有Class里定义names属性对应的_name的成员变量
    NSLog(@"方法列表为%@",[LearnCategory methodLists]);      //分类里方法实现了不声明，也可以获取到
}

- (void)testView {
    OCDLView *aView = [[OCDLView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    aView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:aView];
}

#pragma mark - lazy
- (UITableView *)funtionStyleTableView {
    if (!_funtionStyleTableView) {
        _funtionStyleTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _funtionStyleTableView.delegate = self;
        _funtionStyleTableView.dataSource = self;
    }
    return _funtionStyleTableView;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.funtionStyleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kFuntionListOfViewController forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kFuntionListOfViewController];
    }
    cell.textLabel.text = self.funtionStyleArray[indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 100, 30)];
    label.text = @"测试功能list";
    return label;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [self testAutoReleasePool];

    } else if (indexPath.row == 1) {
        [self testGCD];
    } else if (indexPath.row == 2) {
        [self testKVC];
    } else if (indexPath.row == 3) {
        [self testOCSEL];
    } else if (indexPath.row == 4) {
        [self testLearnCategory];
    } else if (indexPath.row == 5) {
        [self testRetainCount];
    } else if (indexPath.row == 6) {
        [self testForwardingMethod];
    } else if (indexPath.row == 7) {
        [self testSELIMPMEthod];
    } else if (indexPath.row == 8) {
        [[BlockLearning sharedInstance] testBlockLearning];
    } else if (indexPath.row == 9) {
        [[GCDLearning sharedInstance] testGroupOfEnterLeaveAndWait];
        
    } else if (indexPath.row == 10) {
//        [[LearnInitializeChildClass sharedInstance] test];
        
        [LearnDatasourceClass sharedInstance].KVOString = @"new";
    } else if (indexPath.row == 11) {
        [[LearnUIWebView sharedInstance] ui_openURLString:@"www.baidu.com"];
    } else if (indexPath.row == 12) {
        [[LearnWKWebView sharedInstance] wk_openURLString:@"www.sohu.com"];
    } else if (indexPath.row == 13) {
        LearnChild *child = [[LearnChild alloc] init];
    } else if (indexPath.row == 14) {
        [self testPrivateMethod];
    }
}

- (void)testPrivateMethod {
    /*
     调用私有方法的几种方式
     1、 如果知道方法名，可以通过增加分离来实现私有方法扩充
     
     2、 直接通过NSMethodSignature方法签名，通过NSInvocation来调用实现
     
     3、 直接用C语言的底层方法，objc_msgSend()来实现方法获取
     */
    
    [NSObject excutePrivateMethodWithInstanceSelector:@selector(privateMethod:) ForClass:@"OCLearningOOP"];
    
    OCLearningOOP *oop = [[OCLearningOOP alloc] init];
    [oop privateMethodOfOCLearningOOPByCategory];
    
    objc_msgSend(oop, @selector(privateMethod2:),@"哈哈哈哈");
}
@end
