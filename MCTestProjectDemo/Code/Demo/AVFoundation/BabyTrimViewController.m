//
// Created by majiancheng on 2019/5/27.
// Copyright (c) 2019 mjc. All rights reserved.
//

#import "BabyTrimViewController.h"
#import "BabyVideoCropBottomTrimView.h"


@interface BabyTrimViewController ()

@property(nonatomic, strong) BabyVideoCropBottomTrimView *videoCropBottomTrimView;

@end

@implementation BabyTrimViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.videoCropBottomTrimView];

    CGFloat duration = 100.0f; //s;
    CGFloat min = 2.0f;
    CGFloat max = 30.0f;
    self.videoCropBottomTrimView.limitMiniRate = min / duration;
    self.videoCropBottomTrimView.limitMaxRate = max / duration;

    [self.videoCropBottomTrimView loadDefaultTrim:0.3 duration:self.videoCropBottomTrimView.limitMaxRate];

    [self addCropEnent];
}

- (void)addCropEnent {
    __weak typeof(self) weakSelf = self;
    self.videoCropBottomTrimView.leftVideoCropBottomTrimChangeBlock = ^(CGFloat rate) {
        NSLog(@"leftVideoCropBottomTrimChangeBlock : rate = %lf", rate);
    };

    self.videoCropBottomTrimView.rightVideoCropBottomTrimChangeBlock = ^(CGFloat rate) {
        NSLog(@"rightVideoCropBottomTrimChangeBlock : rate = %lf", rate);
    };

    self.videoCropBottomTrimView.leftVideoCropBottomTrimEndBlock = ^(CGFloat rate) {
        NSLog(@"leftVideoCropBottomTrimEndBlock : rate = %lf", rate);
    };

    self.videoCropBottomTrimView.rightVideoCropBottomTrimEndBlock = ^(CGFloat rate) {
        NSLog(@"rightVideoCropBottomTrimEndBlock : rate = %lf", rate);
    };

    self.videoCropBottomTrimView.trimInBlock = ^(CGFloat rate) {
        NSLog(@"trimInBlock : rate = %lf", rate);
    };

    self.videoCropBottomTrimView.trimOutBlock = ^(CGFloat rate) {
        NSLog(@"trimOutBlock : rate = %lf", rate);
    };
}

- (BabyVideoCropBottomTrimView *)videoCropBottomTrimView {
    if (!_videoCropBottomTrimView) {
        _videoCropBottomTrimView = [[BabyVideoCropBottomTrimView alloc] initWithFrame:CGRectMake(0, 300, CGRectGetWidth(self.view.frame), 60)];
    }
    return _videoCropBottomTrimView;
}
@end
