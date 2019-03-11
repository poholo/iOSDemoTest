//
// Created by majiancheng on 2019/3/11.
// Copyright (c) 2019 mjc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^MCProcessCallback)(BOOL success, NSString *info);

@protocol MCPayProtocol <NSObject>

- (void)startBuyProduct:(NSString *)productId payType:(NSString *)payType callBack:(MCProcessCallback)callBack;

- (void)processBuyProductStatus:(NSURL *)url callBack:(MCProcessCallback)callBack;

@end