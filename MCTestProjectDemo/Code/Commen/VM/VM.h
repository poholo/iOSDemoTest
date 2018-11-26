//
// Created by Jiangmingz on 2017/3/9.
// Copyright (c) 2017 GymChina inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Dto;

@interface VM : NSObject

@property(nonatomic, strong) NSMutableArray *dataList;

@property(nonatomic, strong) NSNumber *currentPos;

- (void)refresh;

- (void)more;


@end
