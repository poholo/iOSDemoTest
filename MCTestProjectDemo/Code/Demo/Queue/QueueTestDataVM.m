//
//  QueueTestDataVM.m
//  MCTestProjectDemo
//
//  Created by Ma Jiancheng on 2022/2/9.
//  Copyright © 2022 mjc. All rights reserved.
//

#import "QueueTestDataVM.h"

#import "BlockSyncAsyncTestController.h"
#import "ActionDto.h"
#import "GCDTestController.h"
#import "ThreadTestController.h"
#import "QueueViewController.h"


@implementation QueueTestDataVM

- (void)refresh {
    [super refresh];
    
    {
        ActionDto * actionDto = [ActionDto new];
        actionDto.name = @"1. Block Async & Sync Test";
        actionDto.targetClass = [BlockSyncAsyncTestController class];
        [self.dataList addObject:actionDto];
    }
    
    
    {
        ActionDto *dto = [ActionDto new];
        dto.targetClass = [GCDTestController class];
        dto.name = @"2.GCDTestController";
        dto.desc = @"2 thread";
        [self.dataList addObject:dto];
    }
    
    {
        ActionDto *dto = [ActionDto new];
        dto.targetClass = [ThreadTestController class];
        dto.name = @"3.ThreadTestController";
        dto.desc = @"ThreadTestController";
        [self.dataList addObject:dto];
    }
    
    {
        ActionDto *dto = [ActionDto new];
        dto.targetClass = [QueueViewController class];
        dto.name = @"4.QueueViewController";
        dto.desc = @"QueueViewController";
        [self.dataList addObject:dto];
    }
    
    
    
    
}
@end
