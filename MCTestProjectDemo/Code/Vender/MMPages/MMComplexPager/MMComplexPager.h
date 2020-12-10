// MMComplexPager.h
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

#import <UIKit/UIKit.h>

#import "MMSegmentedControl.h"
#import "MMPageView.h"
#import "MMParallaxHeader.h"

NS_ASSUME_NONNULL_BEGIN

/**
 The segmented control position options relative to the segmented-pager.
 */
typedef NS_ENUM(NSInteger, MMSegmentedControlPosition) {
    MMSegmentedControlPositionTop, /** Top position. */
    MMSegmentedControlPositionBottom, /** Bottom position. */
    MMSegmentedControlPositionTopOver /** Top Over position. */
};

@class MMComplexPager;

/**
 The delegate of a MMComplexPager object may adopt the MMComplexPagerDelegate protocol. Optional methods of the protocol allow the delegate to manage selections.
 */
@protocol MMComplexPagerDelegate <NSObject>

@optional
/**
 Tells the delegate that a specified view is about to be selected.
 
 @param segmentedPager A segmented-pager object informing the delegate about the impending selection.
 @param view           The selected page view.
 */
- (void)segmentedPager:(MMComplexPager *)segmentedPager didSelectView:(UIView *)view;

/**
 Tells the delegate that a specified title is about to be selected.
 
 @param segmentedPager A segmented-pager object informing the delegate about the impending selection.
 @param title          The selected page title.
 */
- (void)segmentedPager:(MMComplexPager *)segmentedPager didSelectViewWithTitle:(NSString *)title;

/**
 Tells the delegate that a specified index is about to be selected.
 
 @param segmentedPager A segmented-pager object informing the delegate about the impending selection.
 @param index          The selected page index.
 */
- (void)segmentedPager:(MMComplexPager *)segmentedPager didSelectViewWithIndex:(NSInteger)index;

/**
 Tells the delegate the segmented pager is about to draw a page for a particular index.
 A segmented page view sends this message to its delegate just before it uses page to draw a index, thereby permitting the delegate to customize the page object before it is displayed.
 
 @param segmentedPager The segmented-pager object informing the delegate of this impending event.
 @param page A page view object that segmented-pager is going to use when drawing the index.
 @param index An index locating the page in pagerView.
 */
- (void)segmentedPager:(MMComplexPager *)segmentedPager willDisplayPage:(UIView *)page atIndex:(NSInteger)index;

/**
 Tells the delegate that the specified page was removed from the pager.
 Use this method to detect when a page is removed from a pager view, as opposed to monitoring the view itself to see when it appears or disappears.
 
 @param segmentedPager The segmented-pager object that removed the view.
 @param page The page that was removed.
 @param index The index of the page.
 */
- (void)segmentedPager:(MMComplexPager *)segmentedPager didEndDisplayingPage:(UIView *)page atIndex:(NSInteger)index;

/**
 Asks the delegate to return the height of the segmented control in the segmented-pager.
 If the delegate doesn’t implement this method, 44 is assumed.
 
 @param segmentedPager A segmented-pager object informing the delegate about the impending selection.
 
 @return A nonnegative floating-point value that specifies the height (in points) that segmented-control should be.
 */
- (CGFloat)heightForSegmentedControlInSegmentedPager:(MMComplexPager *)segmentedPager;

/**
 Tells the delegate that the segmented pager has scrolled with the parallax header.
 
 @param segmentedPager A segmented-pager object in which the scrolling occurred.
 @param parallaxHeader The parallax-header that has scrolled.
 */
- (void)segmentedPager:(MMComplexPager *)segmentedPager didScrollWithParallaxHeader:(MMParallaxHeader *)parallaxHeader;

/**
 Tells the delegate when dragging ended with the parallax header.
 
 @param segmentedPager A segmented-pager object that finished scrolling the content view.
 @param parallaxHeader The parallax-header that has scrolled.
 */
- (void)segmentedPager:(MMComplexPager *)segmentedPager didEndDraggingWithParallaxHeader:(MMParallaxHeader *)parallaxHeader;

/**
 Asks the delegate if the segmented-pager should scroll to the top.
 If the delegate doesn’t implement this method, YES is assumed.
 
 @param segmentedPager The segmented-pager object requesting this information.
 
 @return YES to permit scrolling to the top of the content, NO to disallow it.
 */
- (BOOL)segmentedPagerShouldScrollToTop:(MMComplexPager *)segmentedPager;

@end

/**
 MMComplexPager data source protocol.
 The MMComplexPagerDataSource protocol is adopted by an object that mediates the application’s data model for a MMComplexPager object. The data source provides the segmented-pager object with the information it needs to construct and modify a MMComplexPager view.
 
 The required methods of the protocol provide the pages to be displayed by the segmented-pager as well as inform the MMComplexPager object about the number of pages. The data source may implement optional methods to configure the segmented control.
 */
@protocol MMComplexPagerDataSource <NSObject>

@required
/**
 Asks the data source to return the number of pages in the segmented-pager.
 
 @param segmentedPager A segmented-pager object requesting this information.
 
 @return The number of pages in segmented-pager.
 */
- (NSInteger)numberOfPagesInSegmentedPager:(MMComplexPager *)segmentedPager;

/**
 Asks the data source for a view to insert in a particular page of the segmented-pager.
 
 @param segmentedPager A segmented-pager object requesting the view.
 @param index          An index number identifying a page in segmented-pager.
 
 @return An object inheriting from UIView that the segmented-pager can use for the specified page.
 */
- (__kindof UIView *)segmentedPager:(MMComplexPager *)segmentedPager viewForPageAtIndex:(NSInteger)index;

@optional

/**
 Asks the data source for a title to assign to a particular page of the segmented-pager. The title will be used depending on the MMSegmentedControlType you have choosen.
 
 @param segmentedPager A segmented-pager object requesting the title.
 @param index          An index number identifying a page in segmented-pager.
 
 @return The NSString title of the page in segmented-pager.
 */
- (NSString *)segmentedPager:(MMComplexPager *)segmentedPager titleForSectionAtIndex:(NSInteger)index;

@end

/**
 You use the MMComplexPager class to create and manage segmented pages. A segmented pager displays a horizontal segmented control on top of pages, each segment corresponds to a page in the MMComplexPager view.The currently viewed page is indicated by the segmented control.
 */
@interface MMComplexPager : UIView

/**
 Delegate instance that adopt the MMComplexPagerDelegate.
 */
@property(nonatomic, weak) IBOutlet id <MMComplexPagerDelegate> delegate;

/**
 Data source instance that adopt the MMComplexPagerDataSource.
 */
@property(nonatomic, weak) IBOutlet id <MMComplexPagerDataSource> dataSource;

/**
 The segmented control.
 */
@property(nonatomic, readonly) MMSegmentedControl *segmentedControl;

/**
 The segmented control position option.
 */
@property(nonatomic) MMSegmentedControlPosition segmentedControlPosition;

/**
 The pager. The pager will be placed above or below the segmented control depending on the segmentedControlPosition property.
 */
@property(nonatomic, readonly) MMPageView *pager;

/**
 The padding from the top, left, right, and bottom of the segmentedControl
 */
@property(nonatomic) UIEdgeInsets segmentedControlEdgeInsets;

/**
 Reloads everything from scratch. redisplays pages.
 */
- (void)reloadData;

/**
 Scrolls the main contentView back to the top position
 */
- (void)scrollToTopAnimated:(BOOL)animated;

@end

/**
 MMComplexPager with parallax header.
 */
@interface MMComplexPager (ParallaxHeader)

/**
 The parallax header
 */
@property(nonatomic, strong, readonly) MMParallaxHeader *parallaxHeader;

/**
 Allows bounces. Default YES.
 */
@property(nonatomic) BOOL bounces;

@property(nonatomic, strong) UIColor *contentViewBackgroundColor;

@end

/**
 While using MMComplexPager with Parallax header, your pages can adopt the MMPageDelegate protocol to control subview's scrolling effect.
 */
@protocol MMPageProtocol <NSObject>

@optional

/**
 Asks the page if the segmented-pager should scroll with the view.
 
 @param segmentedPager The segmented-pager. This is the object sending the message.
 @param view           An instance of a sub view.
 
 @return YES to allow segmented-pager and view to scroll together. The default implementation returns YES.
 */
- (BOOL)segmentedPager:(MMComplexPager *)segmentedPager shouldScrollWithView:(__kindof UIView *)view;

@end

NS_ASSUME_NONNULL_END
