//
// Created by majiancheng on 2019/4/24.
// Copyright (c) 2019 mjc. All rights reserved.
//

#import "TranstionAnimationController.h"
#import "TranstionToAnimationController.h"
#import "AnimatedTranstor.h"
#import "AnimatedDismissTranstor.h"


@interface TranstionAnimationController () <UIViewControllerTransitioningDelegate>

@property(nonatomic, strong) UIButton *showBtn;

@property(nonatomic, strong) AnimatedTranstor *transtor;
@property(nonatomic, strong) AnimatedDismissTranstor *dismissTranstor;

@end

@implementation TranstionAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.showBtn];
    self.showBtn.frame = CGRectMake(100, 100, 100, 40);
}

- (void)showBtnClick {
    TranstionToAnimationController *present = [[TranstionToAnimationController alloc] init];
    present.transitioningDelegate = self;
    self.transitioningDelegate = self;

    [self presentViewController:present animated:YES completion:^{

    }];
}

#pragma mark - getter

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    NSLog(@"%s ", __func__);
    return self.transtor;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    NSLog(@"%s ", __func__);
    return self.dismissTranstor;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator {
    NSLog(@"%s ", __func__);

    return nil;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
    NSLog(@"%s ", __func__);

    return nil;
}

- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(nullable UIViewController *)presenting sourceViewController:(UIViewController *)source NS_AVAILABLE_IOS(8_0) {
    NSLog(@"%s ", __func__);

    return nil;
}

- (UIButton *)showBtn {
    if (!_showBtn) {
        _showBtn = [UIButton new];
        [_showBtn addTarget:self action:@selector(showBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_showBtn setBackgroundColor:[UIColor orangeColor]];
        [_showBtn setTitle:@"show" forState:UIControlStateNormal];
    }
    return _showBtn;
}

- (AnimatedTranstor *)transtor {
    if (!_transtor) {
        _transtor = [AnimatedTranstor new];
    }
    return _transtor;
}

- (AnimatedDismissTranstor *)dismissTranstor {
    if (!_dismissTranstor) {
        _dismissTranstor = [AnimatedDismissTranstor new];
    }
    return _dismissTranstor;
}


@end