//
// Created by majiancheng on 2018/6/8.
// Copyright (c) 2018 挖趣智慧科技（北京）有限公司. All rights reserved.
//


#import "PlayerControlButton.h"

@interface PlayerControlButton ()

@property(nonatomic, assign) CGFloat rateH;

@end


@implementation PlayerControlButton

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:10];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self setTitleShadowColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.titleLabel.shadowOffset = CGSizeMake(1, .5);
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    return CGRectMake(0, 0, CGRectGetHeight(self.frame) * self.rateH, CGRectGetHeight(self.frame) * self.rateH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGFloat y = CGRectGetHeight(self.frame) * self.rateH;
    return CGRectMake(0, y, CGRectGetHeight(self.frame) * self.rateH, CGRectGetHeight(self.frame) - y);
}


#pragma mark - getter

- (CGFloat)rateH {
    if (!_rateH) {
        _rateH = 0.7;
    }
    return _rateH;
}

@end
