//
// Created by Jiangmingz on 2017/6/30.
// Copyright (c) 2017 GymChina inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HMSegmentedControl.h"


@interface MMSegmentedControl : HMSegmentedControl

@property(nonatomic, assign) BOOL hasLine;

- (void)setBadgeTips:(NSInteger)index value:(BOOL)value;

@end