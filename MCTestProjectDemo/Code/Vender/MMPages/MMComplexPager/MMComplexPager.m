// MMComplexPager.m
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

#import "MMComplexPager.h"

#import <objc/runtime.h>

#import "MMScrollView.h"

@interface MMComplexPager () <MMScrollViewDelegate, MMPagerViewDelegate, MMPagerViewDataSource>

@property(nonatomic, strong) MMScrollView *contentView;
@property(nonatomic, strong) MMSegmentedControl *segmentedControl;
@property(nonatomic, strong) MMPageView *pager;

@end

@implementation MMComplexPager {
    CGFloat _controlHeight;
    NSInteger _count;
}

- (void)reloadData {

    //Gets number of pages
    _count = [self.dataSource numberOfPagesInSegmentedPager:self];
//    NSAssert(_count > 0, @"Number of pages in MMComplexPager must be greater than 0");

    //Gets the segmented control height
    _controlHeight = 44.f;
    if ([self.delegate respondsToSelector:@selector(heightForSegmentedControlInSegmentedPager:)]) {
        _controlHeight = [self.delegate heightForSegmentedControlInSegmentedPager:self];
    }

    //Gets new data
    NSMutableArray *sectionTitles = [NSMutableArray arrayWithCapacity:_count];

    for (NSInteger index = 0; index < _count; index++) {
        sectionTitles[index] = [NSString stringWithFormat:@"Page %ld", (long) index];
        if ([self.dataSource respondsToSelector:@selector(segmentedPager:titleForSectionAtIndex:)]) {
            sectionTitles[index] = [self.dataSource segmentedPager:self titleForSectionAtIndex:index];
        }
    }

    self.segmentedControl.sectionTitles = sectionTitles;
    [self.segmentedControl setNeedsDisplay];
    self.pager.index = self.segmentedControl.selectedSegmentIndex;

    [self.pager reloadData];
}

- (void)scrollToTopAnimated:(BOOL)animated {
    [_contentView setContentOffset:CGPointMake(0, -self.contentView.parallaxHeader.height)
                          animated:animated];
}

#pragma mark Layout

- (void)layoutSubviews {
    [super layoutSubviews];

    if (_count <= 0) {
        [self reloadData];
    }

    [self layoutContentView];
    [self layoutSegmentedControl];
    [self layoutPager];
}

- (void)layoutContentView {
    CGRect frame = self.bounds;

    frame.origin = CGPointZero;
    self.contentView.frame = frame;
    self.contentView.contentSize = self.contentView.frame.size;
    self.contentView.scrollEnabled = self.contentView.parallaxHeader.view != nil;
    self.contentView.contentInset = UIEdgeInsetsMake(self.contentView.parallaxHeader.height, 0, 0, 0);
}

- (void)layoutSegmentedControl {
    CGRect frame = self.bounds;

    frame.origin.x = self.segmentedControlEdgeInsets.left;

    if (self.segmentedControlPosition == MMSegmentedControlPositionBottom) {
        frame.origin.y = frame.size.height;
        frame.origin.y -= _controlHeight;
        frame.origin.y -= self.segmentedControlEdgeInsets.bottom;
    } else if (self.segmentedControlPosition == MMSegmentedControlPositionTopOver) {
        frame.origin.y = -_controlHeight;
    } else {
        frame.origin.y = self.segmentedControlEdgeInsets.top;
    }

    frame.size.width -= self.segmentedControlEdgeInsets.left;
    frame.size.width -= self.segmentedControlEdgeInsets.right;
    frame.size.height = _controlHeight;

    self.segmentedControl.frame = frame;
}

- (void)layoutPager {
    CGRect frame = self.bounds;

    frame.origin = CGPointZero;

    if (self.segmentedControlPosition == MMSegmentedControlPositionTop) {
        frame.origin.y = _controlHeight;
        frame.origin.y += self.segmentedControlEdgeInsets.top;
        frame.origin.y += self.segmentedControlEdgeInsets.bottom;
    }

    if (self.segmentedControlPosition != MMSegmentedControlPositionTopOver) {
        frame.size.height -= _controlHeight;
        frame.size.height -= self.segmentedControlEdgeInsets.top;
        frame.size.height -= self.segmentedControlEdgeInsets.bottom;
    }

    frame.size.height -= self.contentView.parallaxHeader.minimumHeight;

    self.pager.frame = frame;
}

#pragma mark Properties

- (MMScrollView *)contentView {
    if (!_contentView) {

        // Create scroll-view
        _contentView = [[MMScrollView alloc] init];
        _contentView.delegate = self;
        [self addSubview:_contentView];
    }
    return _contentView;
}

- (MMSegmentedControl *)segmentedControl {
    if (!_segmentedControl) {
        _segmentedControl = [[MMSegmentedControl alloc] init];
        [_segmentedControl addTarget:self
                              action:@selector(pageControlValueChanged:)
                    forControlEvents:UIControlEventValueChanged];

        [self.contentView addSubview:_segmentedControl];
    }
    return _segmentedControl;
}

- (MMPageView *)pager {
    if (!_pager) {
        _pager = [[MMPageView alloc] initWithFrame:self.frame];
        _pager.delegate = self;
        _pager.dataSource = self;
        [self.contentView addSubview:_pager];
    }
    return _pager;
}

- (UIView *)selectedPage {
    return self.pager.selectedPage;
}

- (void)setSegmentedControlPosition:(MMSegmentedControlPosition)segmentedControlPosition {
    _segmentedControlPosition = segmentedControlPosition;
    [self setNeedsLayout];
}

- (void)setSegmentedControlEdgeInsets:(UIEdgeInsets)segmentedControlEdgeInsets {
    _segmentedControlEdgeInsets = segmentedControlEdgeInsets;
    [self setNeedsLayout];
}

#pragma mark <MMScrollViewDelegate>

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.contentView && [self.delegate respondsToSelector:@selector(segmentedPager:didScrollWithParallaxHeader:)]) {
        [self.delegate segmentedPager:self didScrollWithParallaxHeader:scrollView.parallaxHeader];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (scrollView == self.contentView && [self.delegate respondsToSelector:@selector(segmentedPager:didEndDraggingWithParallaxHeader:)]) {
        [self.delegate segmentedPager:self didEndDraggingWithParallaxHeader:scrollView.parallaxHeader];
    }
}

- (BOOL)scrollView:(MMScrollView *)scrollView shouldScrollWithSubView:(UIView *)subView {
    if (subView == self.pager) {
        return NO;
    }

    UIView <MMPageProtocol> *page = (id) self.pager.selectedPage;

    if ([page respondsToSelector:@selector(segmentedPager:shouldScrollWithView:)]) {
        return [page segmentedPager:self shouldScrollWithView:subView];
    }
    return YES;
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView {
    if ([self.delegate respondsToSelector:@selector(segmentedPagerShouldScrollToTop:)]) {
        return [self.delegate segmentedPagerShouldScrollToTop:self];
    }
    return YES;
}

#pragma mark MMSegmentedControl target

- (void)pageControlValueChanged:(MMSegmentedControl *)segmentedControl {
    [self.pager showPageAtIndex:segmentedControl.selectedSegmentIndex animated:YES];
}

#pragma mark <MMPagerViewDelegate>

- (void)pagerView:(MMPageView *)pagerView willMoveToPage:(UIView *)page atIndex:(NSInteger)index {
    [self.segmentedControl setSelectedSegmentIndex:index animated:YES];
}

- (void)pagerView:(MMPageView *)pagerView didMoveToPage:(UIView *)page atIndex:(NSInteger)index {
    [self.segmentedControl setSelectedSegmentIndex:index animated:NO];
    [self changedToIndex:index];
}

- (void)pagerView:(MMPageView *)pagerView willDisplayPage:(UIView *)page atIndex:(NSInteger)index {
    if ([self.delegate respondsToSelector:@selector(segmentedPager:willDisplayPage:atIndex:)]) {
        [self.delegate segmentedPager:self willDisplayPage:page atIndex:index];
    }
}

- (void)pagerView:(MMPageView *)pagerView didEndDisplayingPage:(UIView *)page atIndex:(NSInteger)index {
    if ([self.delegate respondsToSelector:@selector(segmentedPager:didEndDisplayingPage:atIndex:)]) {
        [self.delegate segmentedPager:self didEndDisplayingPage:page atIndex:index];
    }
}

#pragma mark <MMPagerViewDataSource>

- (NSInteger)numberOfPagesInPagerView:(MMPageView *)pagerView {
    return _count;
}

- (UIView *)pagerView:(MMPageView *)pagerView viewForPageAtIndex:(NSInteger)index {
    return [self.dataSource segmentedPager:self viewForPageAtIndex:index];
}

#pragma mark Private methods

- (void)changedToIndex:(NSInteger)index {
    if ([self.delegate respondsToSelector:@selector(segmentedPager:didSelectViewWithIndex:)]) {
        [self.delegate segmentedPager:self didSelectViewWithIndex:index];
    }

    NSString *title = self.segmentedControl.sectionTitles[index];
    UIView *view = self.pager.selectedPage;

    if ([self.delegate respondsToSelector:@selector(segmentedPager:didSelectViewWithTitle:)]) {
        [self.delegate segmentedPager:self didSelectViewWithTitle:title];
    }

    if ([self.delegate respondsToSelector:@selector(segmentedPager:didSelectView:)]) {
        [self.delegate segmentedPager:self didSelectView:view];
    }
}

@end

#pragma mark MMParallaxHeader

@implementation MMComplexPager (ParallaxHeader)

- (BOOL)bounces {
    return self.contentView.bounces;
}

- (void)setBounces:(BOOL)bounces {
    self.contentView.bounces = bounces;
}

- (MMParallaxHeader *)parallaxHeader {
    return self.contentView.parallaxHeader;
}

- (void)setContentViewBackgroundColor:(UIColor *)contentViewBackgroundColor {
    self.contentView.backgroundColor = contentViewBackgroundColor;
}

- (UIColor *)contentViewBackgroundColor {
    return self.contentView.backgroundColor;
}

@end
