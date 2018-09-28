//
//  OCLearningOOP.h
//  OCDeepLearning
//
//  Created by walker彬 on 2018/9/27.
//  Copyright © 2018 walker彬. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface OCLearningOOP : NSObject

@property(nonatomic, assign) NSInteger father;

@end

NS_ASSUME_NONNULL_END


@interface OCLearningOOPChild1 : OCLearningOOP
@property(nonatomic, assign) NSInteger child1;

@end

@interface OCLearningOOPChild2 : OCLearningOOPChild1
@property(nonatomic, assign) NSInteger child2;

@end

@interface OCLearningOOPChild3 : OCLearningOOPChild2
@property(nonatomic, assign) NSInteger child3;

@end

@interface OCLearningOOPChild4 : OCLearningOOPChild3
@property(nonatomic, assign) NSInteger child4;

- (void)testSizeOfIvarsList;
@end
