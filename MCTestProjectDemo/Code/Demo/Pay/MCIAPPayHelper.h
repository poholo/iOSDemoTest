//
//  MCIAPPayHelper.h
//  WaQuVideo
//
//  Created by gdb-work on 16/5/10.
//  Copyright © 2016年 SunYuanYang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MCPayProtocol;


@interface MCIAPPayHelper : NSObject <MCPayProtocol>

+ (void)checkOrderErrorsWithType:(NSString *)type;

+ (BOOL)hasOrderErrorsWithType:(NSString *)type;

+ (void)checkOrderErrors;

+ (BOOL)isJailBreak;
@end
