
//
//  TouchShot.m
//  DrewTest
//
//  Created by majiancheng on 2017/3/23.
//  Copyright © 2017年 waqu. All rights reserved.
//

#import "TouchShot.h"
#import "CircleProgress.h"

@interface TouchShot ()

@property(nonatomic, strong) CircleProgress * circleProgress;
@property(nonatomic, strong) UIButton * touchBtn;
@property(nonatomic, strong) NSTimer * timer;
@property(nonatomic, assign) NSInteger currentSecs;

@end

@implementation TouchShot

- (void)disposeTimer {
    if(self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (instancetype)initWithFrame:(CGRect)frame {
    self  = [super initWithFrame:frame];
    if(self) {
        self.circleProgress = [[CircleProgress alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.touchBtn = [[UIButton alloc] initWithFrame:self.bounds];
        [self addSubview:self.circleProgress];
        [self addSubview:self.touchBtn];
        
//        [self.touchBtn addTarget:self action:@selector(touchDown) forControlEvents:UIControlEventTouchDown];
        
//        [self.touchBtn addTarget:self action:@selector(touchOff) forControlEvents:UIControlEventEditingChanged];
    
        UILongPressGestureRecognizer * tap  = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longTouch:)];
        
        [self.touchBtn addGestureRecognizer:tap];
        
        self.backgroundColor = [UIColor purpleColor];
        
    }
    return self;
}

- (void)touchDown {
    [self.circleProgress start];
    NSLog(@"touchDown");
}

- (void)touchOff {
    [self.circleProgress stop];
    NSLog(@"touchOff");
}

- (void)longTouch:(UILongPressGestureRecognizer *)tap {
    if(tap.state == UIGestureRecognizerStateBegan) {
        NSLog(@"longTouchBegan");
        [self disposeTimer];
        self.currentSecs = 0;
        __weak typeof (self) weakSelf = self;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            __strong typeof (weakSelf) strongSelf = weakSelf;
            strongSelf.currentSecs++;
        }];
        [self.circleProgress start];
        if([self.delegate respondsToSelector:@selector(touchShotStart)]) {
            [self.delegate touchShotStart];
        }
    } else if(tap.state == UIGestureRecognizerStateChanged) {
        NSLog(@"longTouchChanged");
    } else if(tap.state == UIGestureRecognizerStateEnded) {
        NSLog(@"longTouchEnded");
        if([self.delegate respondsToSelector:@selector(touchShotEnd)]) {
            [self.delegate touchShotEnd];
        }
        [self disposeTimer];
        [self.circleProgress stop];
        [self.circleProgress setRate:self.currentSecs / 30.0];
    }
    NSLog(@"longTouch %zd", tap.state);
    
}

- (void)setTrackColor:(UIColor *)trackColor {
    self.circleProgress.trackColor = trackColor;
}

- (void)setSeconds:(NSInteger)seconds {
    self.circleProgress.seconds = seconds;
}

- (void)setLineWidth:(CGFloat)lineWidth {
    self.circleProgress.lineWidth = lineWidth;
}

- (void)setProgressColor:(UIColor *)progressColor {
    self.circleProgress.progressColor = progressColor;
}

@end
