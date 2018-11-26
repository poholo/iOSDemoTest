//
// Created by majiancheng on 2018/11/26.
// Copyright (c) 2018 waqu. All rights reserved.
//

#import "ListDataVM.h"

#import "ActionDto.h"
#import "OldListController.h"
#import "AVFoundationListController.h"
#import "AnimationListController.h"
#import "DesignPatternController.h"
#import "AlgorithmListController.h"


@implementation ListDataVM

- (void)refresh {
    [super refresh];
    [self.dataList removeAllObjects];

    {
        ActionDto *dto = [ActionDto new];
        dto.targetClass = [OldListController class];
        dto.name = @"1.old";
        dto.desc = @"";
        [self.dataList addObject:dto];
    }

    {
        ActionDto *dto = [ActionDto new];
        dto.targetClass = [AVFoundationListController class];
        dto.name = @"2.AVFoundation";
        dto.desc = @"";
        [self.dataList addObject:dto];
    }

    {
        ActionDto *dto = [ActionDto new];
        dto.targetClass = [AnimationListController class];
        dto.name = @"3.Animations";
        dto.desc = @"";
        [self.dataList addObject:dto];
    }

    {
        ActionDto *dto = [ActionDto new];
        dto.targetClass = [DesignPatternController class];
        dto.name = @"4.Design pattern";
        dto.desc = @"";
        [self.dataList addObject:dto];
    }

    {
        ActionDto *dto = [ActionDto new];
        dto.targetClass = [AlgorithmListController class];
        dto.name = @"5.Algorithm";
        dto.desc = @"";
        [self.dataList addObject:dto];
    }
}

@end