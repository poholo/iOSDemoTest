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
#import "PayListController.h"
#import "FFmpegController.h"
#import "BaseController.h"


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

    {
        ActionDto *dto = [ActionDto new];
        dto.targetClass = [PayListController class];
        dto.name = @"6.Pay";
        dto.desc = @"IAP pay";
        [self.dataList addObject:dto];
    }

    {
        ActionDto *dto = [ActionDto new];
        dto.targetClass = [FFmpegController class];
        dto.name = @"7.FFmpeg";
        dto.desc = @"编解码";
        [self.dataList addObject:dto];
    }

    {
        ActionDto *dto = [ActionDto new];
        dto.targetClass = [BaseController class];
        dto.name = @"8.Base";
        dto.desc = @"基础测试";
        [self.dataList addObject:dto];
    }
}

@end