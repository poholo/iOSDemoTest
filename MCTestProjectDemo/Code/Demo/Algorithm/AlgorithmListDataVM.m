//
// Created by majiancheng on 2018/11/26.
// Copyright (c) 2018 mjc. All rights reserved.
//

#import "AlgorithmListDataVM.h"

#import "BlockSyncAsyncTestController.h"
#import "ActionDto.h"


@implementation AlgorithmListDataVM

- (void)refresh {
    [super refresh];
    
    {
        ActionDto * actionDto = [ActionDto new];
        actionDto.name = @"1. Block Async & Sync Test";
        actionDto.targetClass = [BlockSyncAsyncTestController class];
        [self.dataList addObject:actionDto];
    }
}
@end
