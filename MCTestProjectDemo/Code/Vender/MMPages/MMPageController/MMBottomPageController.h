//
// Created by Jiangmingz on 2017/6/29.
// Copyright © 2017年 GymChina inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMPageViewController.h"


@interface MMBottomPageController : MMPageViewController

- (void)image:(NSArray *)images titles:(NSArray *)titles
    textColor:(UIColor *)textColor textSelectColor:(UIColor *)textSelectColor
       xSpace:(CGFloat)xSpace fontSize:(CGFloat)fontSize;

@end