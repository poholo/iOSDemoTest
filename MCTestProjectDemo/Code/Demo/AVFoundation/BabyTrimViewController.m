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
    [self addCropEnent];
}

- (void)addCropEnent {
    __weak typeof(self) weakSelf = self;
    self.videoCropBottomTrimView.leftVideoCropBottomTrimChangeBlock = ^(CGFloat rate) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
    };

    self.videoCropBottomTrimView.rightVideoCropBottomTrimChangeBlock = ^(CGFloat rate) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
    };

    self.videoCropBottomTrimView.leftVideoCropBottomTrimEndBlock = ^(CGFloat rate) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
    };

    self.videoCropBottomTrimView.rightVideoCropBottomTrimEndBlock = ^(CGFloat rate) {
        __strong typeof(weakSelf) strongSelf = weakSelf;

    };

    self.videoCropBottomTrimView.trimInBlock = ^(CGFloat rate) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSLog(@"rate %lf", rate);
    };

    self.videoCropBottomTrimView.trimOutBlock = ^(CGFloat rate) {
        NSLog(@"rate %lf", rate);
    };
}

- (BabyVideoCropBottomTrimView *)videoCropBottomTrimView {
    if (!_videoCropBottomTrimView) {
        _videoCropBottomTrimView = [[BabyVideoCropBottomTrimView alloc] initWithFrame:CGRectMake(0, 300, CGRectGetWidth(self.view.frame), 60)];
    }
    return _videoCropBottomTrimView;
}
@end
