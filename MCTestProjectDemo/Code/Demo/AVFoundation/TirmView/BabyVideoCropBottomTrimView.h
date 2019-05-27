//
// Created by majiancheng on 2017/9/19.
// Copyright (c) 2017 挖趣智慧科技（北京）有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^BabyVideoCropBottomTrimChangeBlock)(CGFloat progress);

@interface BabyVideoCropBottomTrimView : UIView

@property(nonatomic, readonly) UICollectionView *collectionView;

@property(nonatomic, assign) CGFloat limitMiniRate;

@property(nonatomic, assign) CGFloat limitMaxRate;

@property(nonatomic, copy) BabyVideoCropBottomTrimChangeBlock leftVideoCropBottomTrimChangeBlock;
@property(nonatomic, copy) BabyVideoCropBottomTrimChangeBlock rightVideoCropBottomTrimChangeBlock;

@property(nonatomic, copy) BabyVideoCropBottomTrimChangeBlock leftVideoCropBottomTrimEndBlock;
@property(nonatomic, copy) BabyVideoCropBottomTrimChangeBlock rightVideoCropBottomTrimEndBlock;

@property(nonatomic, copy) BabyVideoCropBottomTrimChangeBlock trimInBlock;
@property(nonatomic, copy) BabyVideoCropBottomTrimChangeBlock trimOutBlock;

- (void)loadImages:(NSArray<NSString *> *)images;

- (void)loadDefaultTrim:(CGFloat)startPosDuration duration:(CGFloat)duration;

@end