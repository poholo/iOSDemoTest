//
// Created by majiancheng on 2017/6/20.
// Copyright (c) 2017 waqu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SliderProgressDot;

typedef NS_ENUM(NSInteger, SliderStatus) {
    SliderOutDrag,
    SliderBeginDrag,
    SliderDraging
};

@protocol SliderProgressDataSource <NSObject>

- (void)refreshDots:(NSArray <SliderProgressDot *> *)dots;

- (void)updateProgress:(CGFloat)progress;

- (void)updateBufferProgress:(CGFloat)progress;

@end


@protocol SliderProgressActionDelegate <NSObject>

- (void)clickDotAtIndex:(NSInteger)index;

- (void)beginDrag;

- (void)draging;

- (void)endDrag;


@end