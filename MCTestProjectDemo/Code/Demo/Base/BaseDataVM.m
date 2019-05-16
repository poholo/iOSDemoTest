//
// Created by majiancheng on 2019/5/16.
// Copyright (c) 2019 mjc. All rights reserved.
//

#import "BaseDataVM.h"
#import "ActionDto.h"
#import "LifeCircleController.h"


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
}

@end