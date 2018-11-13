//
// Created by majiancheng on 2017/6/21.
// Copyright (c) 2017 waqu. All rights reserved.
//

#import "SliderControl.h"
#import "SliderProgressDelegate.h"

@implementation __SliderPointDto

- (instancetype)init {
    if (self = [super init]) {
        self.normalColor = [UIColor whiteColor];
        self.hightedColor = [UIColor blueColor];

        self.normalRadius = 5;
        self.hightedRadius = 10;
    }
    return self;
}
@end


@implementation SliderControl {
    NSMutableArray<__SliderPointDto *> *_sliderPointDtos;

    CGPoint _startPoint;
    CGPoint _endPoint;
    BOOL _startInSliderPoint;
    SliderStyle _sliderStyle;
    SliderStatus _sliderStatus;
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

    }
    return self;
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

- (void)drawRect:(CGRect)rect {

    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextBeginPath(context);
        CGContextSetLineWidth(context, self.lineHeight);
        CGContextSetStrokeColorWithColor(context, self.defaultColor.CGColor);
        CGContextMoveToPoint(context, 0, [self startY]);
        CGContextAddLineToPoint(context, self.frame.size.width, [self startY]);
        CGContextStrokePath(context);
    }

    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextBeginPath(context);
        CGContextSetLineWidth(context, self.lineHeight);
        CGContextSetStrokeColorWithColor(context, self.cacheColor.CGColor);
        CGContextMoveToPoint(context, 0, [self startY]);
        CGContextAddLineToPoint(context, self.frame.size.width * self.cacheValue, [self startY]);
        CGContextStrokePath(context);
    }
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextBeginPath(context);
        CGContextSetLineWidth(context, self.lineHeight);
        CGContextSetStrokeColorWithColor(context, self.trackColor.CGColor);
        CGContextMoveToPoint(context, 0, [self startY]);
        CGContextAddLineToPoint(context, self.frame.size.width * self.value, [self startY]);
        CGContextStrokePath(context);
    }

    if (_sliderStyle == SliderShowAll) {
        __weak typeof(self) weakSelf = self;
        [_sliderPointDtos enumerateObjectsUsingBlock:^(__SliderPointDto *dto, NSUInteger idx, BOOL *stop) {
            __strong typeof(self) strongSelf = weakSelf;
            UIColor *currentColor = dto.normalColor;
            CGFloat currentRadius = dto.normalRadius;
            if (dto.selected) {
                currentColor = dto.hightedColor;
                currentRadius = dto.hightedRadius;
            }
            CGFloat startY = self.frame.size.height / 2.0f;
            CGFloat startX = self.frame.size.width * dto.xStartRate;
            CGContextRef context = UIGraphicsGetCurrentContext();
            CGContextSetFillColorWithColor(context, currentColor.CGColor);//填充颜色
            CGContextSetLineWidth(context, 0.0);//线的宽度
            CGContextAddArc(context, startX, startY, currentRadius, 0, 2.0f * M_PI, 0); //添加一个圆
            //kCGPathFill填充非零绕数规则,kCGPathEOFill表示用奇偶规则,kCGPathStroke路径,kCGPathFillStroke路径填充,kCGPathEOFillStroke表示描线，不是填充
            CGContextDrawPath(context, kCGPathFillStroke); //绘制路径加填充
        }];
    }

    if (_sliderStyle != SliderShowProgress) {
        CGFloat currentRadius = _normalRadius;
        if (self.highlighted) {
            currentRadius = _hightedRadius;
        }
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, self.sliderColor.CGColor);//填充颜色
        CGContextSetLineWidth(context, 0.0);//线的宽度
        CGContextAddArc(context, self.frame.size.width * self.value, self.frame.size.height / 2.0f, currentRadius, 0, 2.0f * M_PI, 0); //添加一个圆
        //kCGPathFill填充非零绕数规则,kCGPathEOFill表示用奇偶规则,kCGPathStroke路径,kCGPathFillStroke路径填充,kCGPathEOFillStroke表示描线，不是填充
        CGContextDrawPath(context, kCGPathFillStroke); //绘制路径加填充
    }

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
