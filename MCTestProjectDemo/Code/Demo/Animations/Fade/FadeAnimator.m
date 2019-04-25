//
// Created by majiancheng on 2019/4/24.
// Copyright (c) 2019 mjc. All rights reserved.
//

#import "FadeAnimator.h"


@implementation FadeAnimator

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 3;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *container = [transitionContext containerView];
    [container addSubview:toView];
    toView.alpha = 0;
    [UIView animateWithDuration:1 animations:^{
        toView.alpha = 1;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

@end