//
// Created by majiancheng on 2017/6/21.
// Copyright (c) 2017 waqu. All rights reserved.
//

#import "UIControlSliderTestController.h"
#import "SliderControl.h"


@implementation UIControlSliderTestController {

    SliderControl *_sliderControl;
    SliderStyle _sliderStyle;
    CGFloat _progress;
    BOOL _highted;


}

- (void)viewDidLoad {
    [super viewDidLoad];
    SliderControl *sliderControl = [[SliderControl alloc] initWithFrame:CGRectMake(10, 100, [UIScreen mainScreen].bounds.size.width - 140, 20)];
    sliderControl.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:sliderControl];

    NSArray<__SliderPointDto *> *dtos = ({
        NSMutableArray<__SliderPointDto *> *ds = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < 5; i++) {
            __SliderPointDto *dto = [[__SliderPointDto alloc] init];
            dto.xStartRate = i / 5.0f;

            [ds addObject:dto];
        }
        ds;
    });

    [sliderControl refreshSliderPoints:dtos];

    {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(300, 300, 60, 40)];
        [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];

        [btn setTitle:@"CHANGE" forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor redColor];
    }

    {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(300, 350, 60, 40)];
        [btn addTarget:self action:@selector(changeStyle) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];

        [btn setTitle:@"ChangeStyle" forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor orangeColor];
    }

    _sliderControl = sliderControl;


    [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer *timer) {
        _progress += 0.01;
        [sliderControl updateProgress:_progress];
    }];

    //1 方案 透明slider进度颜色
    /* a.  加入假的进度条
     * b.  加入趣点按钮
     */
    {
        UIProgressView *bufferProgressView = [[UIProgressView alloc] initWithFrame:CGRectMake(40, 300, self.view.frame.size.width - 100, 10)];
        UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(40, 300, self.view.frame.size.width - 100, 10)];

        bufferProgressView.progress = .7;
        progressView.progress = .3;

        bufferProgressView.trackTintColor = [UIColor purpleColor];
        bufferProgressView.progressTintColor = [UIColor orangeColor];
        progressView.trackTintColor = [UIColor clearColor];
        progressView.progressTintColor = [UIColor redColor];

        [self.view addSubview:bufferProgressView];
        [self.view addSubview:progressView];

        for(NSInteger i = 0; i<5; i ++) {
            UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(40 + i * 50, 300, 20, 20)];
            btn.tag = i;
            btn.backgroundColor = [UIColor blueColor];
            [btn addTarget:self action:@selector(qudianClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:btn];
        }

        UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(40, 300, self.view.frame.size.width - 100, 10)];
        slider.tintColor = [UIColor clearColor];
        slider.minimumTrackTintColor = [UIColor clearColor];
        slider.maximumTrackTintColor = [UIColor clearColor];
        [self.view addSubview:slider];

        NSLog(@"[Slider Layers] %@", slider);


    }

    /**
    * 2. 方案 hack方案
    * a. 摸索清除slider的层级
    * b. 将趣点插入
    */

    {
        //subviews 调用返回空 ui层级上看到是

        UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(40, 400, self.view.frame.size.width - 100, 10)];
        slider.tintColor = [UIColor clearColor];
        slider.minimumTrackTintColor = [UIColor redColor];
        slider.maximumTrackTintColor = [UIColor orangeColor];
        [self.view addSubview:slider];

        NSLog(@"[Slider Layers] %@", slider);
        for(NSInteger i = 0; i<5; i ++) {
            UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(i * 50, 0, 20, 20)];
            btn.tag = i;
            btn.backgroundColor = [UIColor blueColor];
            [btn addTarget:self action:@selector(qudianClick:) forControlEvents:UIControlEventTouchUpInside];

            [slider insertSubview:btn atIndex:5];
        }

    }

}

- (void)qudianClick:(UIButton *)btn {
    NSLog(@"不小心被点到了  %zd", btn.tag);
}

- (void)btnClick {
    _sliderStyle++;
    if (_sliderStyle > SliderShowProgress) {
        _sliderStyle = SliderShowAll;
    }
    [_sliderControl updateSliderStyle:_sliderStyle];
}

- (void)changeStyle {
    _highted = !_highted;
    [_sliderControl updateHighted:_highted];
}
@end
