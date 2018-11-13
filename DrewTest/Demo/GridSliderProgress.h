//
// Created by majiancheng on 2017/6/20.
// Copyright (c) 2017 waqu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SliderProgressDelegate.h"

@interface __Slider : UIControl {
    UIImageView *_sliderImageView;
    CGFloat _sliderOnDragSpace;
    CGFloat _sliderOutDragSpace;
    CGFloat _maxSliderX;
    
}
@property(nonatomic, assign) SliderStatus sliderStatus;

- (void)updatePoint:(CGPoint)point;

- (void)beginDrag;

- (void)draging;

- (void)endDrag;

- (void)updateMaxSliderX:(CGFloat)x;

@end

@interface GridSliderProgress : UIControl <SliderProgressDataSource> {
    NSArray<SliderProgressDot *> *_dots;
    UIProgressView *_currentProgressView;
    UIProgressView *_cacheProgressView;
    __Slider *_slider;
}

@property(nonatomic, weak) id <SliderProgressActionDelegate> delegate;


@end
