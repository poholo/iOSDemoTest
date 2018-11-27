//
// Created by Jiangmingz on 2017/3/10.
// Copyright (c) 2017 poholo inc. All rights reserved.
//


#import "DataVM.h"



@implementation DataVM

- (instancetype)init {
    self = [super init];
    if (self) {
        self.currentPos = @0;
    }

    return self;
}

- (void)refresh {
    self.isRefresh = YES;
    self.currentPos = @0;
}

- (void)more {
    self.isRefresh = NO;
}

@end
