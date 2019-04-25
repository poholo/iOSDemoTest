//
// Created by majiancheng on 2019/4/25.
// Copyright (c) 2019 mjc. All rights reserved.
//

#import "CoverAnimator.h"

#import "TranstionAnimationController.h"

@interface CoverAnimator () <CAAnimationDelegate>

@property(nonatomic, strong) id <UIViewControllerContextTransitioning> transitionContext;

@end


@implementation CoverAnimator

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 3;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    //赋值给属性,动画结束时方便传值
    self.transitionContext = transitionContext;

    //获取前一个VC
    TranstionAnimationController *fromVC = (TranstionAnimationController *) ((UINavigationController *) [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey]).topViewController;

    //获取后一个VC

    UIViewController *toVC = (UIViewController *) [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];



    //获取转场时生成的转场视图view

    UIView *containerView = [transitionContext containerView];


    UIButton *button = fromVC.showBtn;


    UIBezierPath *maskStartBP = [UIBezierPath bezierPathWithOvalInRect:button.frame];

    [containerView addSubview:fromVC.view];

    [containerView addSubview:toVC.view];



    //创建两个圆形的UIBezierPath实例: 一个是button的size,另外一个则拥有足够覆盖屏幕的半径.最终的动画是在这两个圆周路径之中进行的



    //这里的finalPoint是相对于fromVC.button.center的位置,并不是在屏幕上的位置

    CGPoint finalPoint;



    //判断触发在哪一个象限,当然我们这里很明显是在第一象限,但是这里为了代码的可复用性,我们也必须判断再计算

    if (button.frame.origin.x > (toVC.view.bounds.size.width / 2)) {

        if (button.frame.origin.y < (toVC.view.bounds.size.width / 2)) {

            //第一象限

            finalPoint = CGPointMake(button.center.x - 0, button.center.y - CGRectGetMaxY(toVC.view.bounds) + 30);

        } else {            //第四象限

            finalPoint = CGPointMake(button.center.x - 0, button.center.y - 0);


        }

    } else {

        if (button.frame.origin.y < (toVC.view.bounds.size.height / 2)) {

            //第二象限

            finalPoint = CGPointMake(button.center.x - CGRectGetMaxX(toVC.view.bounds), button.center.y - CGRectGetMaxY(toVC.view.bounds) + 30);

        } else {

            //第三象限

            finalPoint = CGPointMake(button.center.x - CGRectGetMaxX(toVC.view.bounds), button.center.y - 0);

        }

    }

    //CGRectInset是返回一个中心点一样但是宽高不一样的矩形

    CGFloat radius = sqrt((finalPoint.x * finalPoint.x) + (finalPoint.y * finalPoint.y));


    UIBezierPath *maskFinalBP = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(button.frame, -radius, -radius)];



    //创建一个 CAShapeLayer 来负责展示圆形遮盖

    CAShapeLayer *maskLayer = [CAShapeLayer layer];

    maskLayer.path = maskFinalBP.CGPath; //将它的 path 指定为最终的 path 来避免在动画完成后会回弹



    //这里说明一下mask的属性,mask的属性很简单,例如:view上加了一层imageView,如果imageView.layer.mask = layerA,那么layerA上不透明的部分将会被绘制成透明,透明的部分将会把imageView.layer绘制成白色



    toVC.view.layer.mask = maskLayer;


    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];

    maskLayerAnimation.fromValue = (__bridge id) (maskStartBP.CGPath);

    maskLayerAnimation.toValue = (__bridge id) ((maskFinalBP.CGPath));

    maskLayerAnimation.duration = [self transitionDuration:transitionContext];

    maskLayerAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

    maskLayerAnimation.delegate = self;

    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
}

#pragma mark - CABasicAnimation的Delegate


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {



    //告诉 iOS 这个 transition 完成

    [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];

    //清除 fromVC 的 mask,这里一定要清除,否则会影响响应者链

    [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;

    [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view.layer.mask = nil;

}

@end
