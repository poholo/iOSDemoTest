//
// Created by majiancheng on 2018/11/23.
// Copyright (c) 2018 poholo Inc. All rights reserved.
//

#import "ScanQRCodeDataVM.h"


@implementation ScanQRCodeDataVM

- (NSString *)validateRecongnizerInfo:(NSString *)qrinfo {
    if (![qrinfo hasPrefix:@"http"]) {
        return @"无法识别的类容";
    }
    return nil;

}

@end