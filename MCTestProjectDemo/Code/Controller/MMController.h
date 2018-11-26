//
// Created by Jiangmingz on 2017/3/15.
// Copyright (c) 2017 GymChina inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@class MMDict;

@protocol MMRouteInitDelegate <NSObject>

- (instancetype)initWithRouterParams:(MMDict *)params;

@end

@class MMDict;

@interface MMController : UIViewController <MMRouteInitDelegate>

@property(nonatomic, copy) NSString *uuid;
@property(nonatomic, copy) NSString *time;

+ (NSString *)identifier;

- (instancetype)initWithRouterParams:(MMDict *)params;

- (void)disappearView;

- (void)viewLoading;

- (void)refreshContainer;

@end
