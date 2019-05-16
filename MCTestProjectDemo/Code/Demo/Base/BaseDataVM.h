//
// Created by majiancheng on 2019/5/16.
// Copyright (c) 2019 mjc. All rights reserved.
//

#import "DataVM.h"

@class ActionDto;


@interface BaseDataVM : DataVM

@property(nonatomic, weak) ActionDto *dto;

@end