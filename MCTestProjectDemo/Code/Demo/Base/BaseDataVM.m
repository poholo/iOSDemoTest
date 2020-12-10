//
// Created by majiancheng on 2019/5/16.
// Copyright (c) 2019 mjc. All rights reserved.
//

#import "BaseDataVM.h"

#import "ActionDto.h"
#import "LifeCircleController.h"
#import "LockController.h"
#import "ThreadController.h"
#import "ObjcViewController.h"
#import "RACTestController.h"

#import "MCTestProjectDemo-Swift.h"

@implementation BaseDataVM

- (void)refresh {
    [super refresh];
    [self.dataList removeAllObjects];

    {
        ActionDto *dto = [ActionDto new];
        dto.targetClass = [LifeCircleController class];
        dto.name = @"1.LiftCircle";
        dto.desc = @"ViewController life circle";
        [self.dataList addObject:dto];
    }

    {
        ActionDto *dto = [ActionDto new];
        dto.targetClass = [LockController class];
        dto.name = @"2.LockController";
        dto.desc = @"13 lock";
        [self.dataList addObject:dto];
    }
    {
        ActionDto *dto = [ActionDto new];
        dto.targetClass = [ThreadController class];
        dto.name = @"3.ThreadController";
        dto.desc = @"13 thread";
        [self.dataList addObject:dto];
    }
    
    {
        ActionDto *dto = [ActionDto new];
        dto.targetClass = [ObjcViewController class];
        dto.name = @"4.ObjcViewController";
        dto.desc = @"13 objc-runtime";
        [self.dataList addObject:dto];
    }
    
    {
        ActionDto *dto = [ActionDto new];
        dto.targetClass = [RACTestController class];
        dto.name = @"5.RACTestController";
        dto.desc = @"RAC";
        [self.dataList addObject:dto];
    }
    
    {
        ActionDto *dto = [ActionDto new];
        dto.targetClass = [HoriVerticalTableViewController class];
        dto.name = @"6.HoriVerticalTableViewController";
        dto.desc = @"横向 竖向 Table";
        [self.dataList addObject:dto];
    }
    
    
    {
        ActionDto *dto = [ActionDto new];
        dto.targetClass = [TwoTableRelationController class];
        dto.name = @"7.TwoTableRelationController";
        dto.desc = @"两table关联问题";
        [self.dataList addObject:dto];
    }
    
    {
        ActionDto *dto = [ActionDto new];
        dto.targetClass = [HorizontalTableController class];
        dto.name = @"8.HorizontalTableController";
        dto.desc = @"HorizontalTable";
        [self.dataList addObject:dto];
    }
    
    {
        ActionDto *dto = [ActionDto new];
        dto.targetClass = [HorizontalMainController class];
        dto.name = @"9.HorizontalMainController";
        dto.desc = @"HorizontalPages";
        [self.dataList addObject:dto];
    }
    {
        ActionDto *dto = [ActionDto new];
        dto.targetClass = [HorizontalTableConllectionController class];
        dto.name = @"10.HorizontalTableConllectionController";
        dto.desc = @"HorizontalTableConllection";
        [self.dataList addObject:dto];
    }
    {
        ActionDto *dto = [ActionDto new];
        dto.targetClass = [HorizontalTableCollectionMainController class];
        dto.name = @"10.HorizontalTableCollectionMainController";
        dto.desc = @"HorizontalTableCollection";
        [self.dataList addObject:dto];
    }
    
    
    
    
}

@end
