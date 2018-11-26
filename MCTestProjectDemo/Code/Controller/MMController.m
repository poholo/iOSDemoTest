//
// Created by Jiangmingz on 2017/3/15.
// Copyright (c) 2017 GymChina inc. All rights reserved.
//

#import "MMController.h"

#import "MMDict.h"

@implementation MMController

- (void)dealloc {
    NSLog(@"%s", __func__);
}

- (instancetype)initWithRouterParams:(MMDict *)params {
    self = [super init];
    if (self) {
        self.uuid = [NSUUID UUID].UUIDString;
        self.view.backgroundColor = [UIColor whiteColor];
    }

    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.uuid = [NSUUID UUID].UUIDString;
        self.view.backgroundColor = [UIColor whiteColor];
    }

    return self;
}

// life circle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self viewLoading];

    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    [self disappearView];
}

- (void)disappearView {

}

- (void)viewLoading {

}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

// others

- (void)refreshContainer {

}

+ (NSString *)identifier {
    return NSStringFromClass([self class]);
}

@end
