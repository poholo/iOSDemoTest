//
// Created by Jiangmingz on 2017/3/30.
// Copyright (c) 2017 挖趣智慧科技（北京）有限公司. All rights reserved.
//

#import "ThumbImageView.h"

@interface ThumbImageView ()

@end

@implementation ThumbImageView
- (void)setColor:(UIColor *)color {
    _color = color;
    [self setNeedsDisplay];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    UIEdgeInsets hitTestEdgeInsets;
    if (self.isRight) {
        hitTestEdgeInsets = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, -20.0f);
    } else {
        hitTestEdgeInsets = UIEdgeInsetsMake(0.0f, -20.0f, 0.0f, 0.0f);
    }

    CGRect relativeFrame = self.bounds;
    CGRect hitFrame = UIEdgeInsetsInsetRect(relativeFrame, hitTestEdgeInsets);
    return CGRectContainsPoint(hitFrame, point);
}

- (void)drawRect:(CGRect)rect {
    // Drawing code

    if (self.thumbImage) {
        [self.thumbImage drawInRect:rect];
    } else {
        //// Frames
        CGRect bubbleFrame = self.bounds;

        //// Rounded Rectangle Drawing
        CGRect roundedRectangleRect = CGRectMake(CGRectGetMinX(bubbleFrame), CGRectGetMinY(bubbleFrame), CGRectGetWidth(bubbleFrame), CGRectGetHeight(bubbleFrame));
        UIBezierPath *roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect:roundedRectangleRect byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(3, 3)];
        if (self.isRight) {
            roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect:roundedRectangleRect byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:CGSizeMake(3, 3)];
        }
        [roundedRectanglePath closePath];
        [self.color setFill];
        [roundedRectanglePath fill];

        CGRect decoratingRect = CGRectMake(CGRectGetMinX(bubbleFrame) + CGRectGetWidth(bubbleFrame) / 2.5f, CGRectGetMinY(bubbleFrame) + CGRectGetHeight(bubbleFrame) / 4, 1.5, CGRectGetHeight(bubbleFrame) / 2);
        UIBezierPath *decoratingPath = [UIBezierPath bezierPathWithRoundedRect:decoratingRect byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerTopRight cornerRadii:CGSizeMake(1, 1)];
        [decoratingPath closePath];
        [[UIColor colorWithWhite:1.0f alpha:0.5f] setFill];
        [decoratingPath fill];
    }
}

@end