//
// Created by majiancheng on 2017/6/20.
// Copyright (c) 2017 waqu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SliderProgressDot;

@protocol SliderProgressDotDelegate <NSObject>

- (void)didSelect:(SliderProgressDot *)dot;

@end


@interface SliderProgressDot : UIControl {
    UIImageView *_dotSignImageView;
}

@property(nonatomic, weak) id <SliderProgressDotDelegate> delegate;

@end