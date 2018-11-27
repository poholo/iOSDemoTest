//
// Created by Jiangmingz on 2017/3/15.
// Copyright (c) 2017 poholo inc. All rights reserved.
//

#import "MMNavController.h"


@implementation MMNavController

- (instancetype)init {
    self = [super init];
    if (self) {
    }

    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super initWithRootViewController:rootViewController]) {
        self.rootVC = rootViewController;
    }

    return self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    UIViewController *firstObject = [[self viewControllers] firstObject];
    if (firstObject && firstObject != viewController) {
        [viewController setHidesBottomBarWhenPushed:YES];
    }

    [super pushViewController:viewController animated:animated];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return [self.visibleViewController preferredStatusBarStyle];
}

- (BOOL)prefersStatusBarHidden {
    return [self.visibleViewController prefersStatusBarHidden];
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.visibleViewController;
}

- (BOOL)shouldAutorotate {
    return [self.visibleViewController shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if ([self.visibleViewController respondsToSelector:@selector(supportedInterfaceOrientations)]) {
        return [self.visibleViewController supportedInterfaceOrientations];
    } else {
        return UIInterfaceOrientationMaskPortrait;
    }
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [self.visibleViewController preferredInterfaceOrientationForPresentation];;
}

@end
