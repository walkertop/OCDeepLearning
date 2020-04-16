//
//  DPProtocol.h
//  OCDeepLearning
//
//  Created by 郭彬 on 2020/3/24.
//  Copyright © 2020 walker彬. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DPProtocol <NSObject>

- (void)didSelected: (NSString *) name;
- (Int)selectedIndex: (NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
