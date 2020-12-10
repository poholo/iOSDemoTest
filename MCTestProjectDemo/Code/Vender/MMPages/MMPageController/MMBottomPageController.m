//
// Created by Jiangmingz on 2017/6/29.
// Copyright © 2017年 GymChina inc. All rights reserved.
//

#import "MMBottomPageController.h"

#import "MMSegmentedControl.h"
//#import "UIImage+Create.h"

@interface MMBottomPageController ()

@end

@implementation MMBottomPageController

- (void)viewDidLoad {
    [super viewDidLoad];


    self.segmentedControl.backgroundColor = [UIColor clearColor];
    self.segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor yellowColor], NSFontAttributeName: [UIFont systemFontOfSize:16.0f]};
    self.segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName: [UIColor blueColor], NSFontAttributeName: [UIFont systemFontOfSize:16.0f]};
    self.segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
    self.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segmentedControl.selectionIndicatorHeight = 2.0f;
    self.segmentedControl.selectionIndicatorColor = [UIColor blueColor];
    [self.view addSubview:self.segmentedControl];
}

- (void)image:(NSArray *)images titles:(NSArray *)titles
    textColor:(UIColor *)textColor textSelectColor:(UIColor *)textSelectColor
       xSpace:(CGFloat)xSpace fontSize:(CGFloat)fontSize {
    NSUInteger count = [images count];
    if (count == 0 || [titles count] == 0) {
        return;
    }

    if (count != [titles count]) {
        return;
    }

    NSMutableArray *sectionImages = [NSMutableArray arrayWithCapacity:count];
    NSMutableArray *sectionSelectedImages = [NSMutableArray arrayWithCapacity:count];
    CGFloat aFloat = self.view.bounds.size.width;
//    for (int i = 0; i < count; ++i) {
//        UIImage *sectionImage = [UIImage imageWithSize:CGSizeMake(aFloat / count, 44.0f)
//                                                 color:[AppColor colorVIII]
//                                                 image:images[i]
//                                                 title:titles[i]
//                                                xSpace:xSpace
//                                              fontSize:fontSize
//                                             textColor:textColor];
//        [sectionImages addObject:sectionImage];
//
//        UIImage *sectionSelectedImage = [UIImage imageWithSize:CGSizeMake(aFloat / count, 44.0f)
//                                                         color:[AppColor colorX]
//                                                         image:images[i]
//                                                         title:titles[i]
//                                                        xSpace:xSpace
//                                                      fontSize:fontSize
//                                                     textColor:textSelectColor];
//        [sectionSelectedImages addObject:sectionSelectedImage];
//    }

    self.segmentedControl.segmentEdgeInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.segmentedControl.sectionImages = sectionImages;
    self.segmentedControl.sectionSelectedImages = sectionSelectedImages;
    self.segmentedControl.type = HMSegmentedControlTypeImages;
    self.segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    self.segmentedControl.segmentWidthStyle = HMSegmentedControlSegmentWidthStyleDynamic;
    self.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationNone;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    CGFloat y = 64;
    self.segmentedControl.frame = CGRectMake(0, y, self.view.bounds.size.width, 44.0f);
    self.pagerView.frame = CGRectMake(0, y + 44.0f, self.view.bounds.size.width, self.view.bounds.size.height - y - 44.0f);
}

@end
