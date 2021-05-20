//
//  MethodInvocationDataVM.h
//  MCTestProjectDemo
//
//  Created by Ma Jiancheng on 2021/5/20.
//  Copyright © 2021 mjc. All rights reserved.
//

#import "DataVM.h"

@class MethodInvocationDto;

NS_ASSUME_NONNULL_BEGIN

@interface MethodInvocationDataVM : DataVM

@property(nonatomic, strong) MethodInvocationDto *dto;

@end

NS_ASSUME_NONNULL_END
