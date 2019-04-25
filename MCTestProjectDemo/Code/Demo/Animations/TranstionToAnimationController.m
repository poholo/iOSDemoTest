//
// Created by majiancheng on 2019/4/24.
// Copyright (c) 2019 mjc. All rights reserved.
//

#import "TranstionToAnimationController.h"


@interface TranstionToAnimationController ()

@property(nonatomic, strong) UIButton *dismissBtn;

@end

@implementation TranstionToAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:self.dismissBtn];
    self.dismissBtn.frame = CGRectMake(100, 100, 100, 40);
}

- (void)dismissBtnClick {
    [self dismissViewControllerAnimated:YES completion:^{

    }];
}

- (UIButton *)dismissBtn {
    if (!_dismissBtn) {
        _dismissBtn = [UIButton new];
        [_dismissBtn addTarget:self action:@selector(dismissBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_dismissBtn setTitle:@"dismiss" forState:UIControlStateNormal];
        [_dismissBtn setBackgroundColor:[UIColor redColor]];
    }
    return _dismissBtn;
}
@end