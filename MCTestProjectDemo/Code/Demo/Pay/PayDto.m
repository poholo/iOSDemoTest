//
// Created by majiancheng on 2018/8/7.
// Copyright (c) 2018 挖趣智慧科技（北京）有限公司. All rights reserved.
//

#import "PayDto.h"


@implementation PayDto


- (void)configWechat:(NSDictionary *)dict {
    self.partnerid = dict[@"partnerid"];
    self.prepayid = dict[@"prepayid"];
    self.noncestr = dict[@"noncestr"];
    self.timestamp = [dict[@"timestamp"] integerValue];
    self.packageValue = dict[@"packageValue"];
    self.sign = dict[@"sign"];
    self.redirectUrl = dict[@"mwebUrl"];
}

- (void)configThirdPay:(NSDictionary *)dict {
    self.orderId = dict[@"orderId"];
    self.redirectUrl = dict[@"redirectUrl"];
    self.requestId = dict[@"requestId"];
}

@end