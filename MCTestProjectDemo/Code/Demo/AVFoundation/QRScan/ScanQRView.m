//
// Created by majiancheng on 2018/11/23.
// Copyright (c) 2018 poholo Inc. All rights reserved.
//

#import "ScanQRView.h"


@interface ScanQRView ()

@property(nonatomic, strong) CAShapeLayer *lineLayer;
@property(nonatomic, assign) BOOL animating;

@property(nonatomic, strong) CADisplayLink *displayLink;
@property(nonatomic, assign) CGFloat top;
@property(nonatomic, strong) UIColor *focusColor;
@property(nonatomic, strong) UIColor *scanColor;

@end

@implementation ScanQRView

- (void)dealloc {
    [self validateDisplayLink];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.focusColor = [UIColor orangeColor];
        self.scanColor = [UIColor orangeColor];
        [self.layer addSublayer:self.lineLayer];
        [self.lineLayer setNeedsDisplay];
    }
    return self;
}

- (void)start {
    if (self.animating) return;
    self.animating = YES;
    [self validateDisplayLink];
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(drawLine:)];
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)stop {
    if (!self.animating) return;
    self.animating = NO;
    [self validateDisplayLink];
}

- (void)validateDisplayLink {
    if (self.displayLink) {
        [self.displayLink removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        [self.displayLink invalidate];
        self.displayLink = nil;
    }
}

- (void)drawLine:(id)sender {
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat r = 40;
    CGFloat h = 1;
    CGRectGetHeight(self.lineLayer.frame);
    CGFloat x = 0;
    CGFloat w = CGRectGetWidth(self.lineLayer.frame) - 2 * x;
    self.top += 1.5;
    [path moveToPoint:CGPointMake(x, self.top + h / 2.0f)];
    [path addQuadCurveToPoint:CGPointMake(x + r, self.top) controlPoint:CGPointMake(x, self.top)];
    [path addLineToPoint:CGPointMake(x + w - r, self.top)];
    [path addQuadCurveToPoint:CGPointMake(x + w, self.top + h / 2.0f) controlPoint:CGPointMake(x + w, self.top)];
    [path addQuadCurveToPoint:CGPointMake(x + w - r, self.top + h) controlPoint:CGPointMake(x + w, self.top + h)];
    [path addLineToPoint:CGPointMake(x + r, self.top + h)];
    [path addQuadCurveToPoint:CGPointMake(x, self.top + h / 2.0f) controlPoint:CGPointMake(x, self.top + h)];
    [path closePath];
    self.lineLayer.path = path.CGPath;
    if (self.top >= CGRectGetHeight(self.lineLayer.frame)) {
        self.top = 0;
    }
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat h = 10;
    CGFloat w = 3;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, h)];
    [path addLineToPoint:CGPointZero];
    [path addLineToPoint:CGPointMake(h, 0)];

    [path moveToPoint:CGPointMake(CGRectGetWidth(rect) - h, 0)];
    [path addLineToPoint:CGPointMake(CGRectGetWidth(rect), 0)];
    [path addLineToPoint:CGPointMake(CGRectGetWidth(rect), h)];

    [path moveToPoint:CGPointMake(CGRectGetWidth(rect), CGRectGetHeight(rect) - h)];
    [path addLineToPoint:CGPointMake(CGRectGetWidth(rect), CGRectGetHeight(rect))];
    [path addLineToPoint:CGPointMake(CGRectGetWidth(rect) - h, CGRectGetHeight(rect))];

    [path moveToPoint:CGPointMake(h, CGRectGetHeight(rect))];
    [path addLineToPoint:CGPointMake(0, CGRectGetHeight(rect))];
    [path addLineToPoint:CGPointMake(0, CGRectGetHeight(rect) - h)];

    [path moveToPoint:CGPointMake(0, h)];

    [path closePath];

    CGContextSetStrokeColorWithColor(context, self.focusColor.CGColor);
    CGContextSetLineWidth(context, w);
    CGContextAddPath(context, path.CGPath);
    CGContextStrokePath(context);
}

#pragma mark - getter

- (CAShapeLayer *)lineLayer {
    if (!_lineLayer) {
        _lineLayer = [CAShapeLayer layer];
        _lineLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        _lineLayer.lineCap = kCALineCapButt;
        _lineLayer.lineJoin = kCALineJoinRound;
        _lineLayer.strokeColor = [[UIColor clearColor] CGColor];
        _lineLayer.fillColor = [[UIColor clearColor] CGColor];
        [_lineLayer setLineWidth:1];
        UIColor *color = self.scanColor;
        _lineLayer.strokeColor = color.CGColor;
    }
    return _lineLayer;
}


@end
