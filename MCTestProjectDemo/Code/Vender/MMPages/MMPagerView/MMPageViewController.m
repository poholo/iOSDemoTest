// MMPagerViewController.m
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

#import "MMPageViewController.h"
#import "MMSegmentedControl.h"

@interface MMPageViewController () <MMPagerViewDataSource, MMPagerViewDelegate>

@property(nonatomic, strong) MMSegmentedControl *segmentedControl;
@property(nonatomic, strong) MMPageView *pagerView;

@property(nonatomic, strong) NSMutableDictionary<NSNumber *, MMController *> *pageViewControllers;

@end

@implementation MMPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.pagerView];
}

#pragma mark Properties

- (MMSegmentedControl *)segmentedControl {
    if (!_segmentedControl) {
        _segmentedControl = [[MMSegmentedControl alloc] init];
        [_segmentedControl addTarget:self action:@selector(pageControlValueChanged:) forControlEvents:UIControlEventValueChanged];
    }

    return _segmentedControl;
}

- (MMPageView *)pagerView {
    if (!_pagerView) {
        _pagerView = [[MMPageView alloc] init];
        _pagerView.lazyLoadType = MMLazyLoadOne;
        _pagerView.delegate = self;
        _pagerView.dataSource = self;
    }

    return _pagerView;
}

- (NSMutableDictionary<NSNumber *, MMController *> *)pageViewControllers {
    if (!_pageViewControllers) {
        _pageViewControllers = [NSMutableDictionary<NSNumber *, MMController *> dictionary];
    }

    return _pageViewControllers;
}

- (MMController *)currentController {
    return self.pageViewControllers[@(self.segmentedControl.selectedSegmentIndex)];
}

- (void)selectPageForIndex:(NSInteger)selectIndex {
    self.segmentedControl.selectedSegmentIndex = selectIndex;
    [self.pagerView loadSelectedPage:selectIndex];
}

- (void)didSelectedIndex:(NSInteger)index {
    [self.pagerView showPageAtIndex:index animated:YES];
}

- (void)reloadData {
    NSMutableArray *titles = [NSMutableArray array];
    for (NSInteger index = 0; index < [self.pageViewControllers count]; index++) {
        MMController *controller = self.pageViewControllers[@(index)];
        if (controller.title) {
            [titles addObject:controller.title];
        }
    }

    self.segmentedControl.sectionTitles = titles;
    [self.segmentedControl setNeedsDisplay];

    [self.pagerView reloadData];
}

#pragma mark HMSegmentedControl target

- (void)pageControlValueChanged:(HMSegmentedControl *)segmentedControl {
    [self.pagerView showPageAtIndex:segmentedControl.selectedSegmentIndex animated:YES];
}

#pragma mark <MMPagerViewDelegate>

- (void)pagerView:(MMPageView *)pagerView willMoveToPage:(UIView *)page atIndex:(NSInteger)index {
    [self.segmentedControl setSelectedSegmentIndex:index animated:YES];
    [self willMoveToPage:pagerView atIndex:index];
}

- (void)pagerView:(MMPageView *)pagerView didMoveToPage:(UIView *)page atIndex:(NSInteger)index {
    [self.segmentedControl setSelectedSegmentIndex:index animated:NO];

    [self didMoveToPage:pagerView atIndex:index];
}

- (void)pagerView:(MMPageView *)pagerView willDisplayPage:(UIView *)page atIndex:(NSInteger)index {
    [self didMoveToPage:pagerView atIndex:index];

    MMController *controller = self.pageViewControllers[@(index)];
    if (![controller parentViewController]) {
        [self addChildViewController:controller];
        [controller didMoveToParentViewController:self];
    }
}

- (void)pagerView:(MMPageView *)pagerView didEndDisplayingPage:(UIView *)page atIndex:(NSInteger)index {
    [self didEndDisplayingPage:pagerView atIndex:index];

    MMController *controller = self.pageViewControllers[@(index)];
    if ([controller parentViewController]) {
        [controller willMoveToParentViewController:nil];
        [controller removeFromParentViewController];
    }
}

- (void)willMoveToPage:(UIView *)page atIndex:(NSInteger)index {

}

- (void)didMoveToPage:(UIView *)page atIndex:(NSInteger)index {

}

- (void)willDisplayPage:(UIView *)page atIndex:(NSInteger)index {

}

- (void)didEndDisplayingPage:(UIView *)page atIndex:(NSInteger)index {

}

#pragma mark <MMPagerViewControllerDataSource>

- (NSInteger)numberOfPagesInPagerView:(nonnull MMPageView *)pagerView {
    return [self.pageViewControllers count];
}

- (UIView *)pagerView:(MMPageView *)pagerView viewForPageAtIndex:(NSInteger)index {
    return [self pagerView:pagerView viewControllerForPageAtIndex:index].view;
}

- (MMController *)pagerView:(MMPageView *)pagerView viewControllerForPageAtIndex:(NSInteger)index {
    MMController *pageViewController = self.pageViewControllers[@(index)];
    return pageViewController;
}

@end
