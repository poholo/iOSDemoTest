// MMScrollViewController.h
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

#import "MMScrollView.h"
#import "MMController.h"

/**
 The MMScrollViewController class.
 */
@interface MMScrollViewController : MMController

/**
 The scroll view container.
 */
@property(nonatomic, readonly) MMScrollView *scrollView;

/**
 The parallax header view controller to be added to the scroll view.
 */
@property(nonatomic, strong, nullable) UIViewController *headerViewController;

/**
 The child view controller to be added to the scroll view.
 */
@property(nonatomic, strong, nullable) UIViewController *childViewController;

@end

/**
 UIViewController category to let childViewControllers easily access their parallax header.
 */
@interface UIViewController (MMParallaxHeader)

/**
 The parallax header.
 */
@property(nonatomic, readonly, nullable) MMParallaxHeader *parallaxHeader;

@end

/**
 The MMParallaxHeaderSegue class creates a segue object to get the parallax header view controller from storyboard.
 */
@interface MMParallaxHeaderSegue : UIStoryboardSegue

@end

/**
 The MMScrollViewControllerSegue class creates a segue object to get the child view controller from storyboard.
 */
@interface MMScrollViewControllerSegue : UIStoryboardSegue

@end
