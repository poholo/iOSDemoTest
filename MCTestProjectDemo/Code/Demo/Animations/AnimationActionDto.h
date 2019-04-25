//
// Created by majiancheng on 2019/4/25.
// Copyright (c) 2019 mjc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActionDto.h"


@interface AnimationActionDto : ActionDto

@property(nonatomic, assign) Class toAnimaterClass;
@property(nonatomic, assign) Class dimissAnimaterClass;

@end