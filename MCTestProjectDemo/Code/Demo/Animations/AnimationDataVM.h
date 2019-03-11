//
//  AnimationDataVM.h
//  MCTestProjectDemo
//
//  Created by majiancheng on 2019/1/14.
//  Copyright © 2019 mjc. All rights reserved.
//

#import "DataVM.h"

#import "ActionDto.h"

NS_ASSUME_NONNULL_BEGIN

@interface AnimationDataVM : DataVM

@property(nonatomic, weak) ActionDto *dto;

@end

NS_ASSUME_NONNULL_END
