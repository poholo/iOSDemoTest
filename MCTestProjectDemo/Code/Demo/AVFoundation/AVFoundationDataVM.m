//
// Created by majiancheng on 2018/11/27.
// Copyright (c) 2018 mjc. All rights reserved.
//

#import "AVFoundationDataVM.h"
#import "ActionDto.h"
#import "ScanQRCodeController.h"
#import "BabyTrimViewController.h"


@implementation AVFoundationDataVM


- (void)refresh {
    [super refresh];
    [self.dataList removeAllObjects];

    {
        ActionDto *dto = [ActionDto new];
        dto.targetClass = [ScanQRCodeController class];
        dto.name = @"1.ScanQRCode";
        dto.desc = @"二维码扫描器";
        [self.dataList addObject:dto];
    }

    {

        ActionDto *dto = [ActionDto new];
        dto.targetClass = [BabyTrimViewController class];
        dto.name = @"2.TrimView";
        dto.desc = @"TrimView";
        [self.dataList addObject:dto];


    }
}

@end