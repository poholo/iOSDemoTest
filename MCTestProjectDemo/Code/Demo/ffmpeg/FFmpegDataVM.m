//
// Created by majiancheng on 2019/4/28.
// Copyright (c) 2019 mjc. All rights reserved.
//

#import "FFmpegDataVM.h"
#import "ActionDto.h"
#import "FFPngDecoderController.h"


@implementation FFmpegDataVM

- (void)refresh {
    [super refresh];
    [self.dataList removeAllObjects];

    {
        ActionDto *dto = [ActionDto new];
        dto.targetClass = [FFPngDecoderController class];
        dto.name = @"1.PngDecoder";
        dto.desc = @"解码png";
        [self.dataList addObject:dto];
    }
}

@end