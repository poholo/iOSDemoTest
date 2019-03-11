//
//  AnimationDataVM.m
//  MCTestProjectDemo
//
//  Created by majiancheng on 2019/1/14.
//  Copyright © 2019 mjc. All rights reserved.
//

#import "AnimationDataVM.h"

#import "CALayerControllerViewController.h"

@implementation AnimationDataVM

- (void)refresh {
    [super refresh];
    [self.dataList removeAllObjects];
    
    {
        ActionDto *dto = [ActionDto new];
        dto.targetClass = [CALayerControllerViewController class];
        dto.name = @"1.CALayer";
        dto.desc = @"CALayer shadow";
        [self.dataList addObject:dto];
    }
}

@end
