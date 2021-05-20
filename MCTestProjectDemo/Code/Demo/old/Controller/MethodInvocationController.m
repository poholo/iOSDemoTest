//
//  MethodInvocationController.m
//  MCTestProjectDemo
//
//  Created by Ma Jiancheng on 2021/5/20.
//  Copyright © 2021 mjc. All rights reserved.
//

#import "MethodInvocationController.h"

#import "MethodInvocationDataVM.h"
#import "MethodInvocationView.h"

@interface MethodInvocationController ()

@property(nonatomic, strong) MethodInvocationDataVM *dataVM;
@property(nonatomic, strong) MethodInvocationView *invocationView;

@end

@implementation MethodInvocationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息转发";
    [self.view addSubview:self.invocationView];
    self.invocationView.dataVM = self.dataVM;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.invocationView.frame = self.view.bounds;
}

- (MethodInvocationDataVM *)dataVM {
    if(!_dataVM) {
        _dataVM = [MethodInvocationDataVM new];
    }
    return _dataVM;
}

- (MethodInvocationView *)invocationView {
    if(!_invocationView) {
        _invocationView = (MethodInvocationView *)[[NSBundle mainBundle] loadNibNamed:@"MethodInvocationView" owner:self options:nil].firstObject;
    }
    return _invocationView;
}

@end
