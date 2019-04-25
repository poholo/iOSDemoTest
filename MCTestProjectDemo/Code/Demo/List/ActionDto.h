//
// Created by majiancheng on 2018/11/26.
// Copyright (c) 2018 mjc. All rights reserved.
//

#import "Dto.h"

#import "MMController.h"

@protocol MMRouteInitDelegate;


@interface ActionDto : Dto

@property(nonatomic, assign) Class targetClass;
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *desc;

@property(nonatomic, strong) NSNumber *type;

- (NSString *)text;

@end
