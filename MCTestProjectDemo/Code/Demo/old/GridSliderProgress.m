//
// Created by majiancheng on 2017/6/20.
// Copyright (c) 2017 waqu. All rights reserved.
//

#import "GridSliderProgress.h"
#import "SliderProgressDot.h"

@implementation __Slider

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _sliderOnDragSpace = 5;
        _sliderOutDragSpace = 10;
        _maxSliderX = [UIScreen mainScreen].bounds.size.width;
        _sliderImageView = ({
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:[self imageFrame]];
            imageView.backgroundColor = [UIColor blueColor];
            [self addSubview:imageView];
            imageView;
        });

        [self addTarget:self action:@selector(beginDrag) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(endDrag) forControlEvents:UIControlEventTouchCancel];

        UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureChange:)];
        [self addGestureRecognizer:panGestureRecognizer];
    }
    return self;
}

- (CGRect)imageFrame {
    CGRect frame = CGRectMake(_sliderOutDragSpace, _sliderOutDragSpace, self.bounds.size.width - 2 * _sliderOutDragSpace, self.bounds.size.width - 2 * _sliderOutDragSpace);
    switch (self.sliderStatus) {
        case SliderOutDrag : {
            frame = CGRectMake(_sliderOutDragSpace, _sliderOutDragSpace, self.bounds.size.width - 2 * _sliderOutDragSpace, self.bounds.size.width - 2 * _sliderOutDragSpace);
        }
            break;
        case SliderBeginDrag: {
            frame = CGRectMake(_sliderOnDragSpace, _sliderOnDragSpace, self.bounds.size.width - 2 * _sliderOnDragSpace, self.bounds.size.width - 2 * _sliderOnDragSpace);
        }
            break;
        case SliderDraging: {
            frame = CGRectMake(_sliderOnDragSpace, _sliderOnDragSpace, self.bounds.size.width - 2 * _sliderOnDragSpace, self.bounds.size.width - 2 * _sliderOnDragSpace);
        }
    }
    return frame;
}

- (void)updatePoint:(CGPoint)point {
    self.center = point;
}

- (void)beginDrag {
    self.sliderStatus = SliderBeginDrag;
    [UIView animateWithDuration:.1 animations:^{
        _sliderImageView.frame = [self imageFrame];
    }];

}

- (void)draging {
    self.sliderStatus = SliderDraging;
}

- (void)endDrag {
    self.sliderStatus = SliderOutDrag;
    [UIView animateWithDuration:.1 animations:^{
        _sliderImageView.frame = [self imageFrame];
    }];
}


- (void)updateMaxSliderX:(CGFloat)x {
    _maxSliderX = x;
}


- (void)panGestureChange:(UIPanGestureRecognizer *)panGestureRecognizer {
    switch (panGestureRecognizer.state) {
        case UIGestureRecognizerStateBegan: {
        }
            break;
        case UIGestureRecognizerStateChanged: {
            if (panGestureRecognizer.numberOfTouches != 1) {
                // pinch 时 单指不动 另一指移动 也可能触发
                return;
            }
            CGPoint initialPoint = CGPointZero;
            if (panGestureRecognizer.state == UIGestureRecognizerStateBegan || panGestureRecognizer.state == UIGestureRecognizerStatePossible) {
                return;
            }
            CGPoint point = [panGestureRecognizer translationInView:self.superview];
            if(point.x < 0) {
                return;
            }

            CGPoint point1 = CGPointMake(({
                CGFloat x = point.x;
                if (x > _maxSliderX) {
                    x = _maxSliderX;
                }
                if (x < self.frame.size.width) {
                    x = self.frame.size.width / 2.0f;
                }
                x += initialPoint.x;
                x;
            }), self.center.y);

            NSLog(@"run::%zd::::x = %lf, y = %lf", panGestureRecognizer.state, point.x, point.y);
            self.center = point1;
        }
            break;
        case UIGestureRecognizerStateEnded: {

        }
            break;
        case UIGestureRecognizerStatePossible:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
        default:;
            break;
    }
}


@end

@interface GridSliderProgress () <SliderProgressDotDelegate>


@end


@implementation GridSliderProgress {

}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _cacheProgressView = ({
            UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:self.bounds];
            progressView.progressTintColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:.3];
            progressView.trackTintColor = [UIColor clearColor];
            [self addSubview:progressView];
            progressView;
        });

        _currentProgressView = ({
            UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:self.bounds];
            progressView.progressTintColor = [UIColor redColor];
            progressView.trackTintColor = [UIColor clearColor];
            [self addSubview:progressView];
            progressView;
        });

        _slider = ({
            __Slider *slider = [[__Slider alloc] initWithFrame:CGRectMake(0, 0, frame.size.height, frame.size.height)];
            [self addSubview:slider];
            slider;
        });

    }
    return self;
}

- (void)refreshDots:(NSArray <SliderProgressDot *> *)dots {
    [_dots enumerateObjectsUsingBlock:^(SliderProgressDot *obj, NSUInteger idx, BOOL *stop) {
        [obj removeFromSuperview];
    }];

    _dots = dots;

    [_dots enumerateObjectsUsingBlock:^(SliderProgressDot *obj, NSUInteger idx, BOOL *stop) {
        [self insertSubview:obj aboveSubview:_slider];
        obj.delegate = self;
    }];

    [self bringSubviewToFront:_slider];
}

- (void)updateProgress:(CGFloat)progress {
    CGFloat x = self.frame.size.width * progress;
    CGFloat y = self.frame.size.height / 2.0f;
    [_slider updatePoint:CGPointMake(x, y)];

    _currentProgressView.progress = progress;
}

- (void)updateBufferProgress:(CGFloat)progress {
    _cacheProgressView.progress = progress;
}

- (void)progressSliderValueDidChanged {

}

- (void)progressSliderActionDown {

}

- (void)progressSliderActionUp {

}

#pragma mark - SliderProgressDotDelegate

- (void)didSelect:(SliderProgressDot *)dot {
    NSInteger index = [_dots indexOfObject:dot];
    if ([self.delegate respondsToSelector:@selector(clickDotAtIndex:)]) {
        [self.delegate clickDotAtIndex:index];
    }
    NSLog(@"不小心被点到了。。。。 == ~~~~~~~~");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint point = [[touches anyObject] locationInView:self];
    NSLog(@"【Began】%lf ~~~~~~~ %lf", point.x, point.y);
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint point = [[touches anyObject] locationInView:self];
    NSLog(@"【Moved】%lf ~~~~~~~ %lf", point.x, point.y);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint point = [[touches anyObject] locationInView:self];
    NSLog(@"【Ended】%lf ~~~~~~~ %lf", point.x, point.y);
}


@end
