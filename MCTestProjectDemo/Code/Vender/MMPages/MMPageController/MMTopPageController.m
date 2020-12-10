//
// Created by Jiangmingz on 2017/6/29.
// Copyright © 2017年 GymChina inc. All rights reserved.
//

#import "MMTopPageController.h"

#import "MMSegmentedControl.h"

@interface MMTopPageController ()

@end

@implementation MMTopPageController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.segmentedControl.backgroundColor = [UIColor whiteColor];
    self.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor grayColor]};
    self.segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName: [UIColor blueColor]};
    self.segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
    self.segmentedControl.selectionIndicatorColor = [UIColor blueColor];
    self.segmentedControl.selectionIndicatorHeight = 2.0f;
    [self.view addSubview:self.segmentedControl];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    CGFloat y = 0;
    self.segmentedControl.frame = CGRectMake(0, y, [UIScreen mainScreen].bounds.size.width, 44.0f);

    y = y + 44.0f;
    self.pagerView.frame = CGRectMake(0, y, self.view.bounds.size.width, self.view.bounds.size.height - y);
}

@end
