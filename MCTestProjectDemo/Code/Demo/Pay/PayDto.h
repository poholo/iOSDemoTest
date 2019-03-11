//
// Created by majiancheng on 2018/8/7.
// Copyright (c) 2018 挖趣智慧科技（北京）有限公司. All rights reserved.
//

#import "Dto.h"


@interface PayDto : Dto

@property(nonatomic, copy) NSString *productId;

@property(nonatomic, copy) NSString *requestId;
@property(nonatomic, copy) NSString *orderId;
@property(nonatomic, copy) NSString *orderType;
@property(nonatomic, copy) NSString *uid;

@property(nonatomic, copy) NSString *type;
@property(nonatomic, copy) NSString *info;
@property(nonatomic, copy) NSString *appid;
@property(nonatomic, copy) NSString *partnerid;
@property(nonatomic, copy) NSString *prepayid;
@property(nonatomic, copy) NSString *packageValue;
@property(nonatomic, assign) NSInteger timestamp;
@property(nonatomic, copy) NSString *sign;
@property(nonatomic, strong) NSString *noncestr;
@property(nonatomic, strong) NSString *redirectUrl;

- (void)configWechat:(NSDictionary *)dict;

- (void)configThirdPay:(NSDictionary *)dict;

@end
