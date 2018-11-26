//
// Created by 赵江明 on 15/10/28.
// Copyright (c) 2015 SunYuanYang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MD5)

- (NSString *)md5;

- (void)md5Origin:(char[])r;

- (NSString *)imageMd5;

@end
