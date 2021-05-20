//
//  MethodInvocationDataVM.m
//  MCTestProjectDemo
//
//  Created by Ma Jiancheng on 2021/5/20.
//  Copyright © 2021 mjc. All rights reserved.
//

#import "MethodInvocationDataVM.h"

#import "MethodInvocationDto.h"


@implementation MethodInvocationDataVM

- (MethodInvocationDto *)dto {
    if(!_dto) {
        _dto = [MethodInvocationDto new];
    }
    return _dto;
}

@end
