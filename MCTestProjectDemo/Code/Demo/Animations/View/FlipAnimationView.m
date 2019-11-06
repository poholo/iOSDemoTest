//
// Created by majiancheng on 2019/11/6.
// Copyright (c) 2019 mjc. All rights reserved.
//

#import "FlipAnimationView.h"

@interface FlipAnimationView () <CAAnimationDelegate>

@property(nonatomic, strong) UIView *board;
@property(nonatomic, strong) UIImageView *iv1;
@property(nonatomic, strong) UIImageView *iv2;
@property(nonatomic, copy) void (^callBack)(BOOL success);

@property(nonatomic, weak) UIView *superView;

@end

@implementation FlipAnimationView

+ (void)showAnimaiton:(UIImage *)image imgII:(UIImage *)destImage withSuperView:(UIView *)superView frame:(CGRect)frame callBack:(void (^)(BOOL success))callBack {
    FlipAnimationView *animationView = [[FlipAnimationView alloc] initWithFrame:frame];
    animationView.iv1.image = destImage;
    animationView.iv2.image = image;
    animationView.callBack = callBack;
    animationView.superView = superView;
    [superView addSubview:animationView];
    [animationView showAnimation];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.board];
        [self.board addSubview:self.iv1];
        [self.board addSubview:self.iv2];
    }
    return self;
}

- (void)showAnimation {

    self.iv1.transform = CGAffineTransformMakeScale(-1, 1);

    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = 1;
    group.beginTime = CACurrentMediaTime();
    group.fillMode = kCAFillModeForwards;
    group.delegate = self;


    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    animation.duration = .5f;
    animation.beginTime = 0;
    animation.fromValue = @(0);
    animation.toValue = @(M_PI_2);

    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    animation1.duration = 0.5f;
    animation1.beginTime = 0.5f;
    animation1.fromValue = @(M_PI_2);
    animation1.toValue = @(M_PI);
    {
        CABasicAnimation *animation3 = [CABasicAnimation animationWithKeyPath:@"opacity"];
        animation3.duration = 0.05;
        animation3.beginTime = CACurrentMediaTime() + 0.5;
        animation3.fromValue = @(0);
        animation3.byValue = @(1);
        animation3.toValue = @(1);
        animation3.fillMode = kCAFillModeForwards;
        animation3.removedOnCompletion = NO;
        [self.iv1.layer addAnimation:animation3 forKey:@"animation3"];
    }


    group.animations = @[animation, animation1];
    [self.board.layer addAnimation:group forKey:@"animations"];

    {

        CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"opacity"];
        animation2.duration = 0.05;
        animation2.beginTime = CACurrentMediaTime() + 0.5;
        animation2.fromValue = @(1);
        animation2.byValue = @(0);
        animation2.toValue = @(0);
        animation2.fillMode = kCAFillModeForwards;
        animation2.removedOnCompletion = NO;

        [self.iv2.layer addAnimation:animation2 forKey:@"animation2"];
    }
}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (self.callBack) {
        self.callBack(YES);
    }
    [self removeFromSuperview];
}

- (UIView *)board {
    if (!_board) {
        _board = [[UIView alloc] initWithFrame:self.bounds];
        _board.backgroundColor = [UIColor redColor];
        [_board addSubview:self.iv1];
        [_board addSubview:self.iv2];
    }
    return _board;
}

- (UIImageView *)iv1 {
    if (!_iv1) {
        _iv1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timg.jpeg"]];
        _iv1.frame = self.board.bounds;
        _iv1.transform = CGAffineTransformMakeScale(-1, 1);
    }
    return _iv1;
}


- (UIImageView *)iv2 {
    if (!_iv2) {
        _iv2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timg-2.jpeg"]];
        _iv2.frame = self.board.bounds;
    }
    return _iv2;
}
@end