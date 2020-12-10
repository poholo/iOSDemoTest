//
// Created by Jiangmingz on 2017/6/30.
// Copyright (c) 2017 GymChina inc. All rights reserved.
//

#import "MMSegmentedControl.h"

@interface MMSegmentedControl ()

@property(nonatomic, strong) NSMutableDictionary<NSNumber *, NSNumber *> *badgeDict;
@property(nonatomic, strong) NSMutableDictionary<NSNumber *, CALayer *> *layerDict;

@end

@implementation MMSegmentedControl

- (NSMutableDictionary<NSNumber *, NSNumber *> *)badgeDict {
    if (!_badgeDict) {
        _badgeDict = [NSMutableDictionary<NSNumber *, NSNumber *> dictionary];
    }

    return _badgeDict;
}

- (NSMutableDictionary<NSNumber *, CALayer *> *)layerDict {
    if (!_layerDict) {
        _layerDict = [NSMutableDictionary<NSNumber *, CALayer *> dictionary];
    }

    return _layerDict;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];

    CGFloat segmentWidth = self.frame.size.width / [self.sectionTitles count];

    __weak typeof (self) weakSelf = self;
    [self.sectionTitles enumerateObjectsUsingBlock:^(id titleString, NSUInteger idx, BOOL *stop) {
        __strong typeof (weakSelf) strongSelf = weakSelf;
        CGFloat stringWidth = 0;
        CGFloat stringHeight = 0;
        CGSize size = [strongSelf measureTitleAtIndex:idx];
        stringWidth = size.width;
        stringHeight = size.height;

        // Text inside the CATextLayer will appear blurry unless the rect values are rounded
        BOOL locationUp = (strongSelf.selectionIndicatorLocation == HMSegmentedControlSelectionIndicatorLocationUp);
        BOOL selectionStyleNotBox = (strongSelf.selectionStyle != HMSegmentedControlSelectionStyleBox);

        CGFloat y = roundf((CGRectGetHeight(strongSelf.frame) - selectionStyleNotBox * strongSelf.selectionIndicatorHeight) / 2 - stringHeight / 2 + strongSelf.selectionIndicatorHeight * locationUp);
        CGRect rect = CGRectZero;
        if (strongSelf.segmentWidthStyle == HMSegmentedControlSegmentWidthStyleFixed) {
            rect = CGRectMake((segmentWidth * idx) + (segmentWidth - stringWidth) / 2, y, stringWidth, stringHeight);
        }

        // Fix rect position/size to avoid blurry labels
        rect = CGRectMake(ceilf(rect.origin.x), ceilf(rect.origin.y), ceilf(rect.size.width), ceilf(rect.size.height));

        CALayer *cricleLayer = strongSelf.layerDict[@(idx)];
        if (!cricleLayer) {
            cricleLayer = [CALayer layer];
            cricleLayer.frame = CGRectMake((rect.origin.x + rect.size.width + 5), rect.origin.y, 5.0f, 5.0f);
            cricleLayer.cornerRadius = 2.5f;
            cricleLayer.masksToBounds = YES;
            [strongSelf.layer addSublayer:cricleLayer];
            strongSelf.layerDict[@(idx)] = cricleLayer;
        }

        NSNumber *value = strongSelf.badgeDict[@(idx)];
        if ([value boolValue]) {
            cricleLayer.backgroundColor = [UIColor redColor].CGColor;
        } else {
            cricleLayer.backgroundColor = [UIColor clearColor].CGColor;
        }
    }];

    if (self.hasLine) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetLineCap(context, kCGLineCapSquare);
        CGContextSetLineWidth(context, 0.5);
        CGContextSetStrokeColorWithColor(context, [[UIColor whiteColor] CGColor]);
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, 0.0f, rect.size.height);
        CGContextAddLineToPoint(context, 0, rect.size.width);
        CGContextStrokePath(context);
    }
}

- (void)setBadgeTips:(NSInteger)index value:(BOOL)value {
    self.badgeDict[@(index)] = @(value);
    [self setNeedsDisplay];
}

#pragma mark - Drawing

- (CGSize)measureTitleAtIndex:(NSUInteger)index {
    if (index >= self.sectionTitles.count) {
        return CGSizeZero;
    }

    id title = self.sectionTitles[index];
    CGSize size = CGSizeZero;
    BOOL selected = index == self.selectedSegmentIndex;
    if ([title isKindOfClass:[NSString class]] && !self.titleFormatter) {
        NSDictionary *titleAttrs = selected ? [self resultingSelectedTitleTextAttributes] : [self resultingTitleTextAttributes];
        size = [(NSString *) title sizeWithAttributes:titleAttrs];
    } else if ([title isKindOfClass:[NSString class]] && self.titleFormatter) {
        size = [self.titleFormatter(self, title, index, selected) size];
    } else if ([title isKindOfClass:[NSAttributedString class]]) {
        size = [(NSAttributedString *) title size];
    } else {
        NSAssert(title == nil, @"Unexpected type of segment title: %@", [title class]);
        size = CGSizeZero;
    }
    return CGRectIntegral((CGRect) {CGPointZero, size}).size;
}

#pragma mark - Styling Support

- (NSDictionary *)resultingTitleTextAttributes {
    NSDictionary *defaults = @{
            NSFontAttributeName: [UIFont systemFontOfSize:19.0f],
            NSForegroundColorAttributeName: [UIColor blackColor],
    };

    NSMutableDictionary *resultingAttrs = [NSMutableDictionary dictionaryWithDictionary:defaults];

    if (self.titleTextAttributes) {
        [resultingAttrs addEntriesFromDictionary:self.titleTextAttributes];
    }

    return [resultingAttrs copy];
}

- (NSDictionary *)resultingSelectedTitleTextAttributes {
    NSMutableDictionary *resultingAttrs = [NSMutableDictionary dictionaryWithDictionary:[self resultingTitleTextAttributes]];

    if (self.selectedTitleTextAttributes) {
        [resultingAttrs addEntriesFromDictionary:self.selectedTitleTextAttributes];
    }

    return [resultingAttrs copy];
}

@end
