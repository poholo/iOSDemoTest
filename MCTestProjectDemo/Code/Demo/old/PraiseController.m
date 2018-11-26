//
// Created by majiancheng on 2017/7/21.
// Copyright (c) 2017 waqu. All rights reserved.
//

#import "PraiseController.h"

@interface PraiseAnimeView : UIView

@property(nonatomic, strong) UIImageView *praiseImageView;

@property(nonatomic, strong) UIView *coverView;

@property(nonatomic, strong) UIView *effectsView;

- (void)startAnimation;

- (void)stopAnimation;


@end

@implementation PraiseAnimeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _praiseImageView = ({
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"faved_big"]];
            imageView.frame = CGRectMake(CGRectGetWidth(self.frame) / 2.0f - 40.0f, CGRectGetHeight(self.frame) / 2.0f - 40.0f, 40.0f, 40.0f);
            [self addSubview:imageView];
            imageView;
        });


    }
    return self;
}

- (void)startAnimation {
    [UIView animateWithDuration:.3 delay:0 usingSpringWithDamping:.1 initialSpringVelocity:1 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        CGRect frame = _praiseImageView.frame;
        frame.size.width = 60;
        frame.size.height = 60;
        frame.origin.x -= 10;
        frame.origin.y -= 10;
        _praiseImageView.frame = frame;
    }                completion:^(BOOL finished) {
        _praiseImageView.frame = CGRectMake(CGRectGetWidth(self.frame) / 2.0f - 40.0f, CGRectGetHeight(self.frame) / 2.0f - 40.0f, 40.0f, 40.0f);
    }];
}

- (void)stopAnimation {

}

@end


@implementation PraiseController {
    PraiseAnimeView *_praiseAnimeView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _praiseAnimeView = [[PraiseAnimeView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_praiseAnimeView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self.view addGestureRecognizer:tap];
}

- (void)tap {
    [_praiseAnimeView startAnimation];
}


@end
