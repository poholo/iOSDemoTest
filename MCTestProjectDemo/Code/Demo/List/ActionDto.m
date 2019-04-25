//
// Created by majiancheng on 2018/11/26.
// Copyright (c) 2018 mjc. All rights reserved.
//

#import "ActionDto.h"
#import "MMController.h"


@implementation ActionDto

- (NSString *)text {
    return [NSString stringWithFormat:@"%@-%@", self.name, self.desc];
}

@end