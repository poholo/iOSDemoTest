//
//  MCOSpinLock.h
//  MCTestProjectDemo
//
//  Created by majiancheng on 2019/8/16.
//  Copyright © 2019 mjc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MCOSpinLock : NSObject

- (BOOL)lock;

- (void)unlock;

@end

NS_ASSUME_NONNULL_END
