//
//  MethodInvocationMsgCell.m
//  MCTestProjectDemo
//
//  Created by Ma Jiancheng on 2021/5/20.
//  Copyright © 2021 mjc. All rights reserved.
//

#import "MethodInvocationMsgCell.h"

@interface MethodInvocationMsgCell ()

@property (weak, nonatomic) IBOutlet UILabel *lb;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constaintsHeight;

@end

@implementation MethodInvocationMsgCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)loadData:(nullable NSString *)msg {
    self.lb.text = msg;
    self.constaintsHeight.constant = [self.lb sizeThatFits:CGSizeMake([UIScreen mainScreen].bounds.size.width - 10, CGFLOAT_MAX)].height;
}

+ (NSString *)identifier {
    return NSStringFromClass(self.class);
}

@end
