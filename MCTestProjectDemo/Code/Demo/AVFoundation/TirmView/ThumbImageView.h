//
// Created by Jiangmingz on 2017/3/30.
// Copyright (c) 2017 挖趣智慧科技（北京）有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface ThumbImageView : UIView

@property(nonatomic) BOOL isRight;
@property(strong, nonatomic, nullable) UIColor *color;
@property(strong, nonatomic) UIImage *thumbImage;

@end