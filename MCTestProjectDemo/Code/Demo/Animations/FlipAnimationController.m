//
// Created by majiancheng on 2019/11/5.
// Copyright (c) 2019 mjc. All rights reserved.
//

#import "FlipAnimationController.h"
#import "FlipAnimationView.h"


@interface FlipAnimationController ()


@property(nonatomic, strong) UIButton *startBtn;

@end

@implementation FlipAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.startBtn];
}

- (void)startBtnClick {
    [FlipAnimationView showAnimaiton:[UIImage imageNamed:@"timg.jpeg"] imgII:[UIImage imageNamed:@"timg-2.jpeg"]
                       withSuperView:self.view frame:CGRectMake(20, 50, CGRectGetWidth(self.view.frame) - 40, CGRectGetWidth(self.view.frame) - 40) callBack:^(BOOL success)
    ];
}


- (UIButton *)startBtn {
    if (!_startBtn) {
        _startBtn = [[UIButton alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.view.frame) - 200) / 2.0f, CGRectGetWidth(self.view.frame) + 40 + 20, 200, 40)];
        [_startBtn setTitle:@"Start Animation" forState:UIControlStateNormal];
        [_startBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_startBtn addTarget:self action:@selector(startBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startBtn;
}
@end
