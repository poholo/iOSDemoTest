//
// Created by majiancheng on 2017/6/20.
// Copyright (c) 2017 waqu. All rights reserved.
//

#import "SliderController.h"
#import "GridSliderProgress.h"
#import "SliderProgressDot.h"


@implementation SliderController {
    NSTimer * _timer;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    GridSliderProgress *progress = [[GridSliderProgress alloc] initWithFrame:CGRectMake(100, 100, [UIScreen mainScreen].bounds.size.width - 100, 30)];
    [self.view addSubview:progress];

    self.view.backgroundColor = [UIColor blackColor];

    NSArray<SliderProgressDot *> *arr = ({
        NSMutableArray<SliderProgressDot *> *a1 = [[NSMutableArray alloc] init];
        NSInteger count = 7;
        for (NSInteger index = 0; index < count; index++) {
            SliderProgressDot *dot = [[SliderProgressDot alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / count * index, 0, 30, 30)];
            [a1 addObject:dot];
        }
        a1;
    });


//    [progress refreshDots:arr];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        id traget = self.navigationController.interactivePopGestureRecognizer.delegate;
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:traget action:nil];
        [self.view addGestureRecognizer:pan];
    }
}

@end
