// MMPagerViewController.h
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

#import "MMPageView.h"
#import "MMController.h"

@class UIViewController;

/**
 The MMFullPageController class creates a controller object that manages a pager view.
 */
@interface MMFullPageController : MMController

@property(nonatomic, strong, readonly) NSMutableDictionary<NSNumber *, UIViewController *> *pageViewControllers;

/**
 Returns the pager view managed by the controller object.
 */
@property(nonatomic, strong, readonly) MMPageView *pagerView;

@property(nonatomic, assign, readonly) NSInteger currentPage;

- (UIViewController *)currentController;

- (void)selectPageForIndex:(NSInteger)selectIndex;

- (void)didSelectedIndex:(NSInteger)index;

- (void)reloadData;

- (void)willMoveToPage:(UIView *)page atIndex:(NSInteger)index;

- (void)didMoveToPage:(UIView *)page atIndex:(NSInteger)index;

- (void)willDisplayPage:(UIView *)page atIndex:(NSInteger)index;

- (void)didEndDisplayingPage:(UIView *)page atIndex:(NSInteger)index;

@end