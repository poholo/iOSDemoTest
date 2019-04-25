//
// Created by majiancheng on 2019/4/25.
// Copyright (c) 2019 mjc. All rights reserved.
//

#import "FrameAnimator.h"


@implementation FrameAnimator

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 3;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];

    [transitionContext.containerView addSubview:toView];
    toView.frame = CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds), toView.frame.size.width, toView.frame.size.height);
    [UIView animateWithDuration:2 delay:.0 usingSpringWithDamping:.5 initialSpringVelocity:3 options:UIViewAnimationOptionLayoutSubviews animations:^{
        toView.frame = CGRectMake(0, 0, toView.frame.size.width, toView.frame.size.height);
    }                completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

@end