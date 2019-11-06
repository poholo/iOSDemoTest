//
//  AnimationDataVM.m
//  MCTestProjectDemo
//
//  Created by majiancheng on 2019/1/14.
//  Copyright © 2019 mjc. All rights reserved.
//

#import "AnimationDataVM.h"

#import "CALayerControllerViewController.h"
#import "TranstionAnimationController.h"
#import "AnimationActionDto.h"
#import "FadeAnimator.h"
#import "FadeDismissAnimator.h"
#import "FrameAnimator.h"
#import "FrameDismissAnimator.h"
#import "CoverAnimator.h"
#import "MCTestProjectDemo-Swift.h"
#import "FlipAnimationController.h"

@implementation AnimationDataVM

- (void)refresh {
    [super refresh];
    [self.dataList removeAllObjects];

    {
        AnimationActionDto *dto = [AnimationActionDto new];
        dto.targetClass = [CALayerControllerViewController class];
        dto.name = @"1.CALayer";
        dto.desc = @"CALayer shadow";
        [self.dataList addObject:dto];
    }

    {
        AnimationActionDto *dto = [AnimationActionDto new];
        dto.targetClass = [TranstionAnimationController class];
        dto.name = @"2.转场动画";
        dto.desc = @"淡入淡出";
        dto.toAnimaterClass = [FadeAnimator class];
        dto.dimissAnimaterClass = [FadeDismissAnimator class];
        [self.dataList addObject:dto];
    }

    {
        AnimationActionDto *dto = [AnimationActionDto new];
        dto.targetClass = [TranstionAnimationController class];
        dto.name = @"3.转场动画";
        dto.desc = @"位移";
        dto.toAnimaterClass = [FrameAnimator class];
        dto.dimissAnimaterClass = [FrameDismissAnimator class];
        [self.dataList addObject:dto];
    }
    {
        AnimationActionDto *dto = [AnimationActionDto new];
        dto.targetClass = [TranstionAnimationController class];
        dto.name = @"4.转场动画";
        dto.desc = @"遮罩";
        dto.toAnimaterClass = [CoverAnimator class];
        dto.dimissAnimaterClass = [FrameDismissAnimator class];
        [self.dataList addObject:dto];
    }
    
    {
        AnimationActionDto *dto = [AnimationActionDto new];
        dto.targetClass = [ArtLikeAnimationController class];
        dto.name = @"4.点赞东环效果";
        dto.desc = @"点赞";
        dto.toAnimaterClass = [CoverAnimator class];
        dto.dimissAnimaterClass = [FrameDismissAnimator class];
        [self.dataList addObject:dto];
    }
    {
        AnimationActionDto *dto = [AnimationActionDto new];
        dto.targetClass = [DouYinAnimationController class];
        dto.name = @"5. 抖音分享朋友圈 - 呼吸灯效果";
        dto.desc = @"抖音分享";
        dto.toAnimaterClass = [CoverAnimator class];
        dto.dimissAnimaterClass = [FrameDismissAnimator class];
        [self.dataList addObject:dto];
    }
    {
        AnimationActionDto *dto = [AnimationActionDto new];
        dto.targetClass = [FlipAnimationController class];
        dto.name = @"6. 翻转动画";
        dto.desc = @"抖音分享";
        dto.toAnimaterClass = [CoverAnimator class];
        dto.dimissAnimaterClass = [FlipAnimationController class];
        [self.dataList addObject:dto];
    }


}

@end
