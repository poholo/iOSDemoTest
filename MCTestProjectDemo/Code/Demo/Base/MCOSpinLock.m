//
//  MCOSpinLock.m
//  MCTestProjectDemo
//
//  Created by majiancheng on 2019/8/16.
//  Copyright © 2019 mjc. All rights reserved.
//

#import "MCOSpinLock.h"

#import <libkern/OSAtomic.h>

@interface MCOSpinLock()

@property(nonatomic, assign) OSSpinLock lock;

@end

@implementation MCOSpinLock

- (instancetype)init {
    self = [super init];
    if(self) {
        self.lock = OS_SPINLOCK_INIT;
    }
    return self;
}

- (BOOL)lock {
    BOOL success = OSSpinLockTry(&_lock);
    if(success) {
        OSSpinLockLock(&_lock);
    }
    return success;
}

- (void)unlock {
    OSSpinLockUnlock(&_lock);
}

@end
