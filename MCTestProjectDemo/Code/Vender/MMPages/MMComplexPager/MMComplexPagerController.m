// MMSegmentedPagerController.m
//
// Copyright © 2017年 GymChina inc. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "MMComplexPagerController.h"

@interface MMComplexPagerController () <MMComplexPagerDataSource>

@property(nonatomic, strong) NSMutableDictionary<NSNumber *, MMController *> *pageViewControllers;
@property(nonatomic, strong) MMComplexPager *segmentedPager;

@end

@implementation MMComplexPagerController


- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.segmentedPager];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    self.segmentedPager.frame = self.view.bounds;
}

#pragma mark Properties

- (MMComplexPager *)segmentedPager {
    if (!_segmentedPager) {
        _segmentedPager = [MMComplexPager new];
        _segmentedPager.delegate = self;
        _segmentedPager.dataSource = self;
    }

    return _segmentedPager;
}

- (MMSegmentedControl *)segmentedControl {
    return [self.segmentedPager segmentedControl];
}

- (MMParallaxHeader *)parallaxHeader {
    return [self.segmentedPager parallaxHeader];
}

- (void)reloadData {
    [self.segmentedPager reloadData];
}

- (NSMutableDictionary<NSNumber *, MMController *> *)pageViewControllers {
    if (!_pageViewControllers) {
        _pageViewControllers = [NSMutableDictionary new];
    }

    return _pageViewControllers;
}

#pragma mark <MMComplexPagerControllerDataSource>

- (NSInteger)numberOfPagesInSegmentedPager:(MMComplexPager *)segmentedPager {
    return [self.pageViewControllers count];
}

- (UIView *)segmentedPager:(MMComplexPager *)segmentedPager viewForPageAtIndex:(NSInteger)index {
    UIViewController *viewController = [self segmentedPager:segmentedPager viewControllerForPageAtIndex:index];
    return viewController.view;
}

- (UIViewController *)segmentedPager:(MMComplexPager *)segmentedPager viewControllerForPageAtIndex:(NSInteger)index {
    UIViewController *pageViewController = self.pageViewControllers[@(index)];
    return pageViewController;
}

#pragma mark <MMComplexPagerDataSource>

- (NSString *)segmentedPager:(MMComplexPager *)segmentedPager titleForSectionAtIndex:(NSInteger)index {
    UIViewController *viewController = [self segmentedPager:segmentedPager viewControllerForPageAtIndex:index];
    return viewController.title;
}

@end
