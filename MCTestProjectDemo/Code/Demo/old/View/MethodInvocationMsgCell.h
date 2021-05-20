//
//  MethodInvocationMsgCell.h
//  MCTestProjectDemo
//
//  Created by Ma Jiancheng on 2021/5/20.
//  Copyright © 2021 mjc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MethodInvocationMsgCell : UITableViewCell

- (void)loadData:(nullable NSString *)msg;

+ (NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
