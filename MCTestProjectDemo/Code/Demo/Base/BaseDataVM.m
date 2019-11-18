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
    
    

}

@end
