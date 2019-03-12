//
//  HUDView.m
//  WaQuVideo
//
//  Created by SunYuanYang on 15/12/24.
//  Copyright © 2015年 SunYuanYang. All rights reserved.
//

#import "HUDView.h"

#import <MBProgressHUD/MBProgressHUD.h>

#import "AppDelegate.h"

static MBProgressHUD *hud;

@implementation HUDView

+ (void)show {
    if (hud) return;
    
    if (hud) {
        [[self class] dismiss];
    }
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    if ([NSThread isMainThread]) {
        hud = [MBProgressHUD showHUDAddedTo:keyWindow animated:YES];
        hud.contentColor = [UIColor whiteColor];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        hud.bezelView.color = [UIColor colorWithWhite:0.0 alpha:0.8];
    } else {
        
        __block MBProgressHUD *popupHud = hud;
        popupHud = [MBProgressHUD showHUDAddedTo:keyWindow animated:YES];
        popupHud.contentColor = [UIColor whiteColor];
        popupHud.mode = MBProgressHUDModeIndeterminate;
        hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        hud.bezelView.color = [UIColor colorWithWhite:0.0 alpha:0.8];
    }
}

+ (void)showWithText:(NSString *)text {
    if (hud) return;
    
    if (hud) {
        [[self class] dismiss];
    }
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    if ([NSThread isMainThread]) {
        hud = [MBProgressHUD showHUDAddedTo:keyWindow animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.label.textColor = [UIColor whiteColor];
        hud.label.text = text;
        hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        hud.bezelView.color = [UIColor blackColor];
    } else {
        
        hud = [MBProgressHUD showHUDAddedTo:keyWindow animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.label.text = text;
        hud.label.textColor = [UIColor whiteColor];
        hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        hud.bezelView.color = [UIColor blackColor];
    }
}


+ (void)dismiss {
    if ([NSThread isMainThread]) {
        [hud hideAnimated:YES];
        hud = nil;
    } else {
        __block MBProgressHUD *popupHud = hud;
        
        [popupHud hideAnimated:YES];
        popupHud = nil;
    }
}

+ (void)progress:(CGFloat)progress {
    if (hud) {
        [self dismiss];
    }
    if ([NSThread isMainThread]) {
        hud.mode = MBProgressHUDModeDeterminateHorizontalBar;
        hud.progress = progress;
    } else {
        hud.mode = MBProgressHUDModeDeterminateHorizontalBar;
        hud.progress = progress;
    }
}
@end
