//
//  RACTestDataVM.m
//  MCTestProjectDemo
//
//  Created by Ma Jiancheng on 2021/4/22.
//  Copyright © 2021 mjc. All rights reserved.
//

#import "RACTestDataVM.h"

@implementation RACTestDataVM


- (instancetype)init {
    if (self = [super init]) {
        [self.dataList addObjectsFromArray:@[@"bind", @"bind_Complex", @"concat", @"zip", @"mapRplace", @"reduceEach", @"reduceApply", @"materialize", @"dematerialize", @"not", @"and", @"or", @"any", @"map", @"filter", @"flatten", @"switchToLatest", @"switchCasesDefault", @"ifThenElse", @"relyon"]];
    }
    return self;
}
@end
