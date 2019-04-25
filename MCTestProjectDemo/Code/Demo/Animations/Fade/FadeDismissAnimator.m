//
// Created by majiancheng on 2019/4/25.
// Copyright (c) 2019 mjc. All rights reserved.
//

#import "FadeDismissAnimator.h"


@implementation FadeDismissAnimator

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 1;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *continner = transitionContext.containerView;
    toView.alpha = 0.3;
    [fromView removeFromSuperview];
    [continner addSubview:toView];
    [UIView animateWithDuration:1 animations:^{
        toView.alpha = 1;
    }                completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];

}

@end