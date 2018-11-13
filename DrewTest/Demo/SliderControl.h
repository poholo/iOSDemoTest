//
// Created by majiancheng on 2017/6/21.
// Copyright (c) 2017 waqu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SliderProgressActionDelegate;


typedef NS_ENUM(NSInteger, SliderStyle) {
    SliderShowAll,
    SliderShowSliderProgress,
    SliderShowProgress
};


@interface __SliderPointDto : NSObject

@property(nonatomic, strong) NSString *entityId;

@property(nonatomic, assign) CGFloat xStartRate;
@property(nonatomic, assign) BOOL selected;

@property(nonatomic, strong) UIColor *normalColor;
@property(nonatomic, strong) UIColor *hightedColor;

@property(nonatomic, assign) CGFloat normalRadius;
@property(nonatomic, assign) CGFloat hightedRadius;

@end

@interface SliderControl : UIControl

@property(nonatomic, weak) id <SliderProgressActionDelegate> delegate;

@property(nonatomic, strong) UIColor *trackColor;
@property(nonatomic, strong) UIColor *cacheColor;
@property(nonatomic, strong) UIColor *defaultColor;
@property(nonatomic, strong) UIColor *sliderColor;


@property(nonatomic, assign) CGFloat normalRadius;
@property(nonatomic, assign) CGFloat hightedRadius;

@property(nonatomic, assign) CGFloat value;
@property(nonatomic, assign) CGFloat cacheValue;
@property(nonatomic, assign) CGFloat maxValue;

@property(nonatomic, assign) CGFloat lineHeight;

- (void)updateProgress:(CGFloat)progress;

- (void)updateBufferProgress:(CGFloat)progress;

- (void)refreshSliderPoints:(NSArray<__SliderPointDto *> *)dtos;

- (void)updateSliderStyle:(SliderStyle)sliderStyle;

- (void)updateHighted:(BOOL)highted;


@end