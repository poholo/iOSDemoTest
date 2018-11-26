//
// Created by majiancheng on 2018/11/26.
// Copyright (c) 2018 waqu. All rights reserved.
//

#import "ListDataVM.h"

#import "ActionDto.h"
#import "OldListController.h"


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
}

@end