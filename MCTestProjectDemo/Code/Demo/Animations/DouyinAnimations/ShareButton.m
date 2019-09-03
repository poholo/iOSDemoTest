//
// Created by majiancheng on 2018/7/13.
// Copyright (c) 2018 挖趣智慧科技（北京）有限公司. All rights reserved.
//

#import "ShareButton.h"

@interface ShareButton () <CAAnimationDelegate>

@property(nonatomic, strong) UIImageView *shareImageView;
@property(nonatomic, strong) UIImageView *friendImageView;

@property(nonatomic, assign) BOOL isAnimation;

@end


@implementation ShareButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createViews];
        [self addLayout];
    }
    return self;
}

- (void)createViews {
    [self addSubview:self.friendImageView];
    [self addSubview:self.shareImageView];
}

- (void)addLayout {
    self.friendImageView.frame = [self imageRectForContentRect:self.frame];
    self.shareImageView.frame = [self imageRectForContentRect:self.frame];
}

- (void)showFriendAniamtion {
    if (self.isAnimation) return;
    self.isAnimation = YES;
    [self remainFriendAniamtion];
}

- (void)remainFriendAniamtion {
    if (!self.isAnimation) return;
    [self.shareImageView.layer removeAllAnimations];
    [self.friendImageView.layer removeAllAnimations];

    self.shareImageView.hidden = NO;
    self.friendImageView.hidden = YES;
    CGFloat duration = 2;
    {
        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.fromValue = @(0.8);
        scaleAnimation.toValue = @(1.1);
        scaleAnimation.duration = 0.1 * duration;
        scaleAnimation.beginTime = CACurrentMediaTime();

        CABasicAnimation *scaleAnimation1 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation1.fromValue = @(1.1);
        scaleAnimation1.toValue = @(0.4);
        scaleAnimation1.duration = 0.2 * duration;
        scaleAnimation1.beginTime = CACurrentMediaTime() + 0.1 * duration;
        scaleAnimation1.delegate = self;
//        scaleAnimation.removedOnCompletion = NO;

        CABasicAnimation *scaleAnimation2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation2.fromValue = @(0.4);
        scaleAnimation2.toValue = @(0.1);
        scaleAnimation2.duration = 0.1 * duration;
        scaleAnimation2.beginTime = CACurrentMediaTime() + 0.3 * duration;
        scaleAnimation2.delegate = self;
//        scaleAnimation2.removedOnCompletion = NO;


        [self.shareImageView.layer addAnimation:scaleAnimation forKey:@"ShareAnimation"];
        [self.shareImageView.layer addAnimation:scaleAnimation1 forKey:@"ShareAnimation1"];
        [self.shareImageView.layer addAnimation:scaleAnimation2 forKey:@"ShareAnimation2"];
    }

    {

        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        animation.fromValue = @(0);
        animation.toValue = @(0);
        animation.beginTime = CACurrentMediaTime();
        animation.duration = 0.3 * duration;

        CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"opacity"];
        animation1.fromValue = @(0);
        animation1.toValue = @(1);
        animation1.beginTime = CACurrentMediaTime() + 0.3 * duration;
        animation1.duration = 0.1 * duration;

        CGFloat rate = 1;
        CABasicAnimation *s0Animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        s0Animation.fromValue = @(0.2 * rate);
        s0Animation.toValue = @(1.1 * rate);
        s0Animation.duration = 0.3 * duration;
        s0Animation.beginTime = CACurrentMediaTime() + 0.3f * duration;


        CABasicAnimation *s1Animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        s0Animation.fromValue = @(1.05 * rate);
        s0Animation.toValue = @(0.9 * rate);
        s0Animation.duration = 0.3 * duration;
        s0Animation.autoreverses = YES;
        s0Animation.repeatCount = NSIntegerMax;
        s0Animation.beginTime = CACurrentMediaTime() + 0.6f * duration;
        [self.friendImageView.layer addAnimation:animation forKey:@"opacity0"];
        [self.friendImageView.layer addAnimation:animation1 forKey:@"opacity1"];
        [self.friendImageView.layer addAnimation:s0Animation forKey:@"SpringAnimation1"];
        [self.friendImageView.layer addAnimation:s1Animation forKey:@"SpringAniamtion2"];
    }
}

- (void)hiddenFriendAniamtion {
    [self.shareImageView.layer removeAllAnimations];
    [self.friendImageView.layer removeAllAnimations];

    self.shareImageView.hidden = NO;
    self.friendImageView.hidden = YES;
    self.isAnimation = NO;
}


#pragma mark - AnimationDelegate

- (void)animationDidStart:(CAAnimation *)anim {

}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
//    CAAnimation *a1 = [self.shareImageView.layer animationForKey:@"ShareAnimation1"];
//    CAAnimation *a2 = [self.shareImageView.layer animationForKey:@"ShareAnimation2"];
    self.friendImageView.hidden = NO;
    self.shareImageView.hidden = YES;
}


#pragma mark -getter

- (UIImageView *)shareImageView {
    if (!_shareImageView) {
        _shareImageView = [UIImageView new];
        _shareImageView.image = [UIImage imageNamed:@"icon_share"];
        _shareImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _shareImageView;
}

- (UIImageView *)friendImageView {
    if (!_friendImageView) {
        _friendImageView = [UIImageView new];
        _friendImageView.image = [UIImage imageNamed:@"ic_moments_small"];
        _friendImageView.contentMode = UIViewContentModeScaleAspectFit;
        _friendImageView.hidden = YES;
    }
    return _friendImageView;
}

@end
