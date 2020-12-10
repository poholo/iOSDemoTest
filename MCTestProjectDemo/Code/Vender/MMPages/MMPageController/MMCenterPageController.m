//
// Created by Jiangmingz on 2017/7/3.
// Copyright (c) 2017 GymChina inc. All rights reserved.
//

#import "MMCenterPageController.h"

@implementation MMCenterPageController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segmentedControl.backgroundColor = [UIColor grayColor];
    self.segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor yellowColor], NSFontAttributeName: [UIFont systemFontOfSize:16.0f]};
    self.segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName: [UIColor blueColor], NSFontAttributeName: [UIFont systemFontOfSize:16.0f]};
    self.segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
    self.segmentedControl.selectionIndicatorHeight = 0.0f;
    self.segmentedControl.selectionIndicatorColor = [UIColor redColor];

    [self parallaxHeader].mode = MMParallaxHeaderModeFill;
}

@end
