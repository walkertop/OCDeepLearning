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


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    [NSObject logRetainCount:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// MARK: 测试自动释放池
- (void)testAutoReleasePool {
    OCAutoReleasePool *testPool = [[OCAutoReleasePool alloc] init];
    //没有加入自动释放池
//    [testPool createNumbersOfObjects];=
//    //加入自动释放池
//    [testPool createNumbersOfObjectsByautoReleasePool];
    
    //检测异步线程自动释放池
    [testPool monitorAsyncAutoReleasePool];
    //开启子线程的runloop并将NSTimer事件添加进去才可以
    [testPool testTimerInAsync];

}

// MARK: 测试GCD
- (void)testGCD {
    GCDLearning *gcd = [[GCDLearning alloc] init];
    [gcd testQueue];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [gcd testGroup];
    });
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
    //    id arr = [NSArray arrayWithObject:@"123"];
    //    NSDictionary *dic = @{@"name": @"zhangsan"};
    //    id value = [NSObject valueForKey:dic.allKeys[0]];
    //    NSHashTable
    //    id value = [NSHashTable valueForKey:arr];
    //    NSHashTable *hashTable = [NSHashTable]
    //    NSLog(@"%@",value);
}
@end





