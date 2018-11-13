//
// Created by majiancheng on 2017/6/20.
// Copyright (c) 2017 waqu. All rights reserved.
//

#import "SliderProgressDot.h"


@implementation SliderProgressDot {

}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _dotSignImageView = ({
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
            imageView.backgroundColor = [UIColor redColor];
            imageView.layer.cornerRadius = CGRectGetWidth(self.bounds) / 2.0f;
            imageView.layer.masksToBounds = YES;
            [self addSubview:imageView];
            imageView;
        });

        [self addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }

    return self;
}

- (void)click:(id)sender {
    if([self.delegate respondsToSelector:@selector(didSelect:)]) {
        [self.delegate didSelect:self];
    }
}

@end