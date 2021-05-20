//
// Created by majiancheng on 2017/6/22.
// Copyright (c) 2017 waqu. All rights reserved.
//

#import "SliderLayerControl.h"
#import "SliderProgressDelegate.h"
#import "SliderControl.h"


@implementation SliderLayerControl {

    NSMutableArray<__SliderPointDto *> *_sliderPointDtos;

    CGPoint _startPoint;
    CGPoint _endPoint;
    BOOL _startInSliderPoint;
    SliderStyle _sliderStyle;
    SliderStatus _sliderStatus;

    CAShapeLayer *_progressLayer;
    CAShapeLayer *_bufferLayer;
    CAShapeLayer *_defaultProgressLayer;
    CAShapeLayer *_sliderLayer;
}


- (BOOL)currentTapIsInSliderPoints:(CGFloat)x {
    __weak typeof(self) weakSelf = self;
    __block BOOL isIn = NO;
    [_sliderPointDtos enumerateObjectsUsingBlock:^(__SliderPointDto *obj, NSUInteger idx, BOOL *stop) {
        __strong typeof(self) strongSelf = weakSelf;
        CGFloat tempX = obj.xStartRate * self.frame.size.width;
        if (x > tempX - self.frame.size.height / 2.0 && x < tempX + self.frame.size.height / 2.0) {
            isIn = YES;
            *stop = YES;
        }
    }];
    return isIn;
}

- (__SliderPointDto *)currentSelectDto:(CGFloat)x {
    __weak typeof(self) weakSelf = self;
    __block __SliderPointDto *dto = nil;
    [_sliderPointDtos enumerateObjectsUsingBlock:^(__SliderPointDto *obj, NSUInteger idx, BOOL *stop) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        CGFloat tempX = obj.xStartRate * self.frame.size.width;
        if (x > tempX - self.frame.size.height / 2.0 && x < tempX + self.frame.size.height / 2.0) {
            dto = obj;
            *stop = YES;
        }
    }];
    return dto;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _trackColor = [UIColor redColor];
        _cacheColor = [UIColor blueColor];
        _defaultColor = [UIColor grayColor];
        _sliderColor = [UIColor orangeColor];

        _lineHeight = 2;

        _cacheValue = .8f;
        _value = .3f;

        _normalRadius = frame.size.height / 4.0f;
        _hightedRadius = frame.size.height / 2.0f;

        {
            _defaultProgressLayer = [self decorateFactorLayer];
            _defaultProgressLayer.fillColor = _defaultColor.CGColor;
            _progressLayer = [self decorateFactorLayer];
            _progressLayer.fillColor = _trackColor.CGColor;
            _bufferLayer = [self decorateFactorLayer];
            _bufferLayer.fillColor = _cacheColor.CGColor;

        }

    }
    return self;
}


- (CAShapeLayer *)decorateFactorLayer {
    CAShapeLayer *layer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, [self startY], self.frame.size.width, _lineHeight)];
    layer.path = path.CGPath;
    layer.lineCap = kCALineCapRound;
    layer.frame = CGRectMake(0, [self startY], self.frame.size.width, _lineHeight);
    layer.strokeStart = 0.0f;
    layer.strokeEnd = 1.0f;
    return layer;
}

- (void)updateProgress:(CGFloat)progress {
    if (_sliderStatus != SliderOutDrag) return;
    _value = progress;
    [self setNeedsDisplay];
}

- (void)updateBufferProgress:(CGFloat)progress {
    if (_sliderStatus != SliderOutDrag) return;
    _cacheValue = progress;
    [self setNeedsDisplay];
}


- (void)refreshSliderPoints:(NSArray<__SliderPointDto *> *)dtos {
    if (_sliderPointDtos == nil) {
        _sliderPointDtos = [NSMutableArray<__SliderPointDto *> array];
    }

    [_sliderPointDtos removeAllObjects];
    [_sliderPointDtos addObjectsFromArray:dtos];

    [self setNeedsDisplay];
}

- (void)updateSliderStyle:(SliderStyle)sliderStyle {
    _sliderStyle = sliderStyle;
    [self setNeedsDisplay];
}

- (void)updateHighted:(BOOL)highted {
    self.highlighted = highted;
    [self setNeedsDisplay];
}


- (CGFloat)startY {
    if (_sliderStyle == SliderShowProgress) {
        return self.frame.size.height - (_lineHeight / 2.0f);
    }
    return self.frame.size.height / 2.0f;
}

#pragma mark -Event


- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(nullable UIEvent *)event {
    if (_sliderStyle == SliderShowProgress) {
        return NO;
    }
    _sliderStatus = SliderBeginDrag;
    if ([self.delegate respondsToSelector:@selector(beginDrag)]) {
        [self.delegate beginDrag];
    }
    [super beginTrackingWithTouch:touch withEvent:event];
    _startPoint = [touch locationInView:self];
    _startInSliderPoint = [self currentTapIsInSliderPoints:_startPoint.x];
    [self sendActionsForControlEvents:UIControlEventTouchDown];
    return YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(nullable UIEvent *)event {
    [super continueTrackingWithTouch:touch withEvent:event];

    if (_sliderStyle == SliderShowProgress) {
        return NO;
    }
    _sliderStatus = SliderDraging;
    if ([self.delegate respondsToSelector:@selector(draging)]) {
        [self.delegate draging];
    }
    CGPoint endTouchPoint = [touch previousLocationInView:self];
    if (ABS(endTouchPoint.x - _startPoint.x) > self.frame.size.height || !_startInSliderPoint) {
        self.value = endTouchPoint.x / self.frame.size.width;
        [self setNeedsDisplay];
    }
    [self sendActionsForControlEvents:UIControlEventValueChanged];


    NSLog(@"~~~~~~~~~~~~~%lf--%lf", endTouchPoint.x, endTouchPoint.y);
    return YES;
}

- (void)endTrackingWithTouch:(nullable UITouch *)touch withEvent:(nullable UIEvent *)event {
    if (_sliderStyle == SliderShowProgress) {
        return;
    }
    [super endTrackingWithTouch:touch withEvent:event];
    [self sendActionsForControlEvents:UIControlEventEditingDidEnd];
    CGPoint endTouchPoint = [touch previousLocationInView:self];
    if ([self.delegate respondsToSelector:@selector(endDrag)]) {
        [self.delegate endDrag];
    }
    if (ABS(endTouchPoint.x - _startPoint.x) < self.frame.size.height && _startInSliderPoint) {
        [self sliderPointClick:[self currentSelectDto:_startPoint.x]];
        _startInSliderPoint = NO;
    }
    _sliderStatus = SliderOutDrag;
}

- (void)sliderPointClick:(__SliderPointDto *)dto {
    NSLog(@"不小心又点到了 %lf", dto.xStartRate);
    dto.selected = !dto.selected;
    [self setNeedsDisplay];
}
@end
