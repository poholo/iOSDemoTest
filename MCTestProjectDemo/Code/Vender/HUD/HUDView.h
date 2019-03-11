//
//  HUDView.h
//  WaQuVideo
//
//  Created by SunYuanYang on 15/12/24.
//  Copyright © 2015年 SunYuanYang. All rights reserved.
//

@import UIKit;

@interface HUDView : NSObject

+ (void)show;

+ (void)showWithText:(NSString *)text;

+ (void)dismiss;

+ (void)progress:(CGFloat)progress;

@end
