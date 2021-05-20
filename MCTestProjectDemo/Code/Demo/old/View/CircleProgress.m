//
//  CircleProgress.m
//  DrewTest
//
//  Created by majiancheng on 2017/3/17.
//  Copyright © 2017年 waqu. All rights reserved.
//

#import "CircleProgress.h"

@interface CircleProgress ()

@property(nonatomic, strong) CAShapeLayer * trackLayer;
@property(nonatomic, strong) CAShapeLayer * progressLayer;
@property (nonatomic, strong) CAShapeLayer * contentLayer;

@end

@implementation CircleProgress
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        _trackLayer = [[CAShapeLayer alloc] init];
        _contentLayer = [[CAShapeLayer alloc] init];
        
        [self.layer addSublayer:_trackLayer];
        [self.layer addSublayer:_contentLayer];
        
        _trackLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
       
        _contentLayer.frame = CGRectMake(10, 10, self.frame.size.width - 20, self.frame.size.height - 20);
        
        UIBezierPath * trackpath = [UIBezierPath bezierPathWithArcCenter:self.center radius:self.frame.size.width / 2 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
        
        
        UIBezierPath * circlePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width / 2 - 10, self.frame.size.height / 2 -10) radius:(self.frame.size.width / 2 - 10) startAngle:0 endAngle:M_PI * 2 clockwise:YES];
        
        
        _trackLayer.path = trackpath.CGPath;
        _contentLayer.path = circlePath.CGPath;
        
        _trackLayer.fillColor = nil;
        _contentLayer.fillColor = [UIColor colorWithRed:147 /255.0 green:126 / 255.0 blue:121 / 255.0 alpha:.5].CGColor;
        _contentLayer.strokeColor = nil;
        
    }
    return self;
}

- (CAShapeLayer *)progressLayer {
    if(_progressLayer) {
        [_progressLayer removeAllAnimations];
        [_progressLayer removeFromSuperlayer];
        _progressLayer = nil;
    }
    _progressLayer = [[CAShapeLayer alloc] init];
    _progressLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    //        UIBezierPath * progresspath = [UIBezierPath bezierPathWithArcCenter:self.center radius:self.frame.size.width / 2 startAngle:0 endAngle:0 clockwise:YES];
    if(_lineWidth > 0) {
        _progressLayer.lineWidth = _lineWidth;
        _progressLayer.strokeColor = _progressColor.CGColor;
    }
    _progressLayer.fillColor = nil;
    _progressLayer.lineCap = kCALineCapRound;
    _progressLayer.path = [self bbbbRate:1.0].CGPath;
    _progressLayer.strokeStart = 0.0f;
    _progressLayer.strokeEnd = 1.0f;
    
    return _progressLayer;
}

- (UIBezierPath *)bbbbRate:(CGFloat)rate {
    _rate = rate;
    
    UIBezierPath * progresspath = [UIBezierPath bezierPathWithArcCenter:self.center radius:self.frame.size.width / 2 startAngle:0 endAngle:rate * M_PI * 2 clockwise:YES];
    
    _progressLayer.path = progresspath.CGPath;
    
    return progresspath;
}

- (void)setRate:(CGFloat)rate {
    _rate = rate;
    UIBezierPath * progresspath = [UIBezierPath bezierPathWithArcCenter:self.center radius:self.frame.size.width / 2 startAngle:0 endAngle:rate * M_PI * 2 clockwise:YES];
    
    _progressLayer.path = progresspath.CGPath;
}

- (void)setProgressColor:(UIColor *)progressColor {
    _progressColor  = progressColor;
    _progressLayer.strokeColor = progressColor.CGColor;
}

- (void)setTrackColor:(UIColor *)trackColor {
    _trackLayer.strokeColor = trackColor.CGColor;
}

- (void)setLineWidth:(CGFloat)lineWidth {
    _trackLayer.lineWidth = lineWidth;
    _lineWidth = lineWidth;
    _progressLayer.lineWidth = lineWidth;
}

- (void)start {
    [self.layer addSublayer:[self progressLayer]];
//    
//    CABasicAnimation * frameAnim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//    frameAnim.duration = 1.0;
//    frameAnim.repeatCount = 1;
//    frameAnim.removedOnCompletion = YES;
//    frameAnim.fromValue  = @(1);
//    frameAnim.toValue = @(1.3);
//    [_progressLayer addAnimation:frameAnim forKey:@"scale-layer"];
//    [_trackLayer addAnimation:frameAnim forKey:@"scale-layer"];
    
    CABasicAnimation * circleAnim = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    circleAnim.removedOnCompletion = YES;
    circleAnim.duration = _seconds;
    circleAnim.fromValue = @(0);
    circleAnim.toValue = @(1);
    
    
    [_progressLayer addAnimation:circleAnim forKey:@"strokeEnda"];
}

- (void)stop {
    [_progressLayer removeAnimationForKey:@"strokeEnda"];
}



@end
