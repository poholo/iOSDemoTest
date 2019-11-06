//
// Created by majiancheng on 2019/11/6.
// Copyright (c) 2019 mjc. All rights reserved.
//


#import <UIKit/UIKit.h>


@interface FlipAnimationView : UIView

+ (void)showAnimaiton:(UIImage *)image imgII:(UIImage *)destImage withSuperView:(UIView *)superView frame:(CGRect)frame callBack:(void (^)(BOOL success))callBack;

@end