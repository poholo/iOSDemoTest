//
// Created by majiancheng on 2019/3/11.
// Copyright (c) 2019 mjc. All rights reserved.
//

#import "PayListDataVM.h"
#import "MCGoodsDto.h"
#import "ActionDto.h"


@implementation PayListDataVM

- (void)refresh {
    for (NSInteger idx = 0; idx < 10; idx++) {
        MCGoodsDto *dto = [MCGoodsDto new];
        dto.pid = [NSString stringWithFormat:@"com.jx.iaptest.jx%zd", idx];
        dto.name = [NSString stringWithFormat:@"JX-%zd", idx];
        dto.price = @(idx);
        [self.dataList addObject:dto];
    }
}

@end