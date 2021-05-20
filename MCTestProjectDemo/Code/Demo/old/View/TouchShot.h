//
//  TouchShot.h
//  DrewTest
//
//  Created by majiancheng on 2017/3/23.
//  Copyright © 2017年 waqu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TouchShotDelegate <NSObject>

- (void)touchShotStart;

- (void)touchShotEnd;

@end

@interface TouchShot : UIView

@property(nonatomic, weak) id<TouchShotDelegate> delegate;

@property(nonatomic, strong) UIColor * trackColor;
@property(nonatomic, strong) UIColor * progressColor;

@property(nonatomic, assign) CGFloat lineWidth;

@property(nonatomic, assign) NSInteger seconds; //s

@end
