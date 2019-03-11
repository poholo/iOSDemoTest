//
//  CALayerControllerViewController.m
//  MCTestProjectDemo
//
//  Created by majiancheng on 2019/1/14.
//  Copyright © 2019 mjc. All rights reserved.
//

#import "CALayerControllerViewController.h"

@interface CALayerControllerViewController ()

@property(nonatomic, strong) UIView * shadowView;
@property(nonatomic, strong) UIView * contentView;

@end

@implementation CALayerControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.shadowView];
    [self.shadowView addSubview:self.contentView];
    self.shadowView.frame = CGRectMake(40, 100, 150 , 150);
    self.contentView.frame = self.shadowView.bounds;
    self.shadowView.backgroundColor = [UIColor redColor];
    self.shadowView.layer.shadowColor = [UIColor blueColor].CGColor;
    self.shadowView.layer.shadowRadius = 10;
    self.shadowView.layer.cornerRadius = 10;
    self.shadowView.layer.shadowOffset = CGSizeMake(0, 0);
    self.shadowView.layer.shadowOpacity = 1.0f;

}

- (UIView *)shadowView {
    if(!_shadowView) {
        _shadowView = [UIView new];
    }
    return _shadowView;
}

- (UIView *)contentView {
    if(!_contentView) {
        _contentView = [UIView new];
        _contentView.backgroundColor = [UIColor blackColor];
    }
    return _contentView;
}

@end
