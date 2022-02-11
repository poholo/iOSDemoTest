//
//  QueueTestDataVM.h
//  MCTestProjectDemo
//
//  Created by Ma Jiancheng on 2022/2/9.
//  Copyright © 2022 mjc. All rights reserved.
//

#import "DataVM.h"

@class ActionDto;

NS_ASSUME_NONNULL_BEGIN

@interface QueueTestDataVM : DataVM


@property (nonatomic, weak) ActionDto * dto;

@end

NS_ASSUME_NONNULL_END
