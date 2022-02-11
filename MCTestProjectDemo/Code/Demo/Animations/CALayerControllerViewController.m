//
//  CALayerControllerViewController.m
//  MCTestProjectDemo
//
//  Created by majiancheng on 2019/1/14.
//  Copyright © 2019 mjc. All rights reserved.
//

#import "CALayerControllerViewController.h"

@interface CALayerControllerViewController ()

@property(nonatomic, strong) UIView * shadowView;
@property(nonatomic, strong) UIView * contentView;

@property(nonatomic, assign) CGFloat manuY;
@property(nonatomic, assign) CGFloat manuW;
@property(nonatomic, assign) CGFloat manuH;
@property(nonatomic, strong) UIButton *transformBtn;
@property(nonatomic, strong) UIButton *transformYBtn;
@property(nonatomic, strong) UIButton *transformScaleWBtn;
@property(nonatomic, strong) UIButton *transformScaleHBtn;
@property(nonatomic, strong) UIButton *transformbBtn;
@property(nonatomic, strong) UIButton *transformcBtn;
@property(nonatomic, strong) UIButton *scaleBtn;
@property(nonatomic, strong) UIButton *invertBtn;
@property(nonatomic, strong) UIButton *rotateBtn;
@property(nonatomic, strong) UIButton *contactBtn;
@property(nonatomic, strong) UIButton *resetBtn;


@end

@implementation CALayerControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"CGAffineTransform";
    self.manuY = CGRectGetHeight(self.view.frame) - 44 - 250;
    self.manuW = CGRectGetWidth(self.view.frame) / 4;
    self.manuH = 44;
    // Do any additional setup after loading the view.
    [self.view addSubview:self.shadowView];
    [self.shadowView addSubview:self.contentView];
    self.shadowView.frame = CGRectMake(40, 100, 60 , 30);
    self.contentView.frame = self.shadowView.bounds;
    self.shadowView.backgroundColor = [UIColor redColor];
    self.shadowView.layer.shadowColor = [UIColor blueColor].CGColor;
    self.shadowView.layer.shadowRadius = 10;
    self.shadowView.layer.cornerRadius = 10;
    self.shadowView.layer.shadowOffset = CGSizeMake(0, 0);
    self.shadowView.layer.shadowOpacity = 1.0f;
    
    [self.view addSubview:self.transformBtn];
    [self.view addSubview:self.transformYBtn];
    [self.view addSubview:self.transformScaleWBtn];
    [self.view addSubview:self.transformScaleHBtn];
    [self.view addSubview:self.transformbBtn];
    [self.view addSubview:self.transformcBtn];
    [self.view addSubview:self.scaleBtn];
    [self.view addSubview:self.resetBtn];
    [self.view addSubview:self.invertBtn];
    [self.view addSubview:self.rotateBtn];
    [self.view addSubview:self.contactBtn];
    
    [self printCGTransform];

}

- (void)printCGTransform {
    CGAffineTransform transform = self.shadowView.transform;
    NSLog(@"\n a = %lf b = %lf \n c = %lf d = %lf \n tx = %lf ty = %lf", transform.a, transform.b, transform.c, transform.d, transform.tx, transform.ty);
}

- (void)xmov {
    CGAffineTransform transform = self.shadowView.transform;
    transform.tx += 10;
    self.shadowView.transform = transform;
    [self printCGTransform];
}

- (void)ymov {
    CGAffineTransform transform = self.shadowView.transform;
    transform.ty += 10;
    self.shadowView.transform = transform;
    [self printCGTransform];
}

- (void)scaleW {
    CGAffineTransform transform = self.shadowView.transform;
    transform.a += 0.1;
    self.shadowView.transform = transform;
    [self printCGTransform];
}

- (void)scaleH {
    CGAffineTransform transform = self.shadowView.transform;
    transform.d += 0.1;
    self.shadowView.transform = transform;
    [self printCGTransform];
}

- (void)bchange {
    CGAffineTransform transform = self.shadowView.transform;
    transform.b += 0.1;
    self.shadowView.transform = transform;
    [self printCGTransform];
}

- (void)cchange {
    CGAffineTransform transform = self.shadowView.transform;
    transform.c += 0.1;
    self.shadowView.transform = transform;
    [self printCGTransform];
}

- (void)scale {
    CGAffineTransform transform = self.shadowView.transform;
    CGAffineTransform finalTransform = CGAffineTransformScale(transform, 2, 3);
    self.shadowView.transform = finalTransform;
    [self printCGTransform];
}

- (void)invert {
    CGAffineTransform transform = self.shadowView.transform;
    CGAffineTransform finalTransform = CGAffineTransformInvert(transform);
    self.shadowView.transform = finalTransform;
    [self printCGTransform];
}

- (void)rotate {
    CGAffineTransform transform = self.shadowView.transform;
    CGAffineTransform finalTransform = CGAffineTransformRotate(transform, M_PI * 0.3);
    self.shadowView.transform = finalTransform;
    [self printCGTransform];
}

- (void)contact {
    CGAffineTransform transform = self.shadowView.transform;
    CGAffineTransform t2 = CGAffineTransformMake(0.9, 0.1, 0.7, 0.1, 10, 20);
    CGAffineTransform finalTransform = CGAffineTransformConcat(transform, t2);
    self.shadowView.transform = finalTransform;
    [self printCGTransform];
}

- (void)reset {
    self.shadowView.transform = CGAffineTransformIdentity;
}

- (UIView *)shadowView {
    if(!_shadowView) {
        _shadowView = [UIView new];
    }
    return _shadowView;
}

- (UIView *)contentView {
    if(!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(40, 100, 60 , 30)];
        _contentView.backgroundColor = [UIColor blackColor];
        _contentView.layer.cornerRadius = 10;
        _contentView.layer.borderColor = [UIColor orangeColor].CGColor;
        _contentView.layer.borderWidth = 2;
        
        UILabel *tLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 7, 60, 15)];
        tLb.text = @"AAAAA";
        tLb.textAlignment = NSTextAlignmentCenter;
        tLb.font = [UIFont systemFontOfSize:14];
        tLb.textColor = [UIColor redColor];
        
        [_contentView addSubview:tLb];
    }
    return _contentView;
}

- (UIButton *)transformBtn {
    if(!_transformBtn) {
        _transformBtn = [UIButton new];
        _transformBtn.frame = CGRectMake(0, self.manuY, self.manuW, self.manuH);
        [_transformBtn setTitle:@"X mov" forState:UIControlStateNormal];
        [_transformBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_transformBtn addTarget:self action:@selector(xmov) forControlEvents:UIControlEventTouchUpInside];
        _transformBtn.layer.borderColor = [UIColor orangeColor].CGColor;
        _transformBtn.layer.borderWidth = 1;
    }
    return _transformBtn;
}

- (UIButton *)transformYBtn {
    if(!_transformYBtn) {
        _transformYBtn = [UIButton new];
        _transformYBtn.frame = CGRectMake(self.manuW, self.manuY, self.manuW, self.manuH);
        [_transformYBtn setTitle:@"Y mov" forState:UIControlStateNormal];
        [_transformYBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_transformYBtn addTarget:self action:@selector(ymov) forControlEvents:UIControlEventTouchUpInside];
        _transformYBtn.layer.borderColor = [UIColor orangeColor].CGColor;
        _transformYBtn.layer.borderWidth = 1;
    }
    return _transformYBtn;
}

- (UIButton *)transformScaleWBtn {
    if(!_transformScaleWBtn) {
        _transformScaleWBtn = [UIButton new];
        _transformScaleWBtn.frame = CGRectMake(2 * self.manuW, self.manuY, self.manuW, self.manuH);
        [_transformScaleWBtn setTitle:@"scaleW" forState:UIControlStateNormal];
        [_transformScaleWBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_transformScaleWBtn addTarget:self action:@selector(scaleW) forControlEvents:UIControlEventTouchUpInside];
        _transformScaleWBtn.layer.borderColor = [UIColor orangeColor].CGColor;
        _transformScaleWBtn.layer.borderWidth = 1;
    }
    return _transformScaleWBtn;
}

- (UIButton *)transformScaleHBtn {
    if(!_transformScaleHBtn) {
        _transformScaleHBtn = [UIButton new];
        _transformScaleHBtn.frame = CGRectMake(3 * self.manuW, self.manuY, self.manuW, self.manuH);
        [_transformScaleHBtn setTitle:@"scaleH" forState:UIControlStateNormal];
        [_transformScaleHBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_transformScaleHBtn addTarget:self action:@selector(scaleH) forControlEvents:UIControlEventTouchUpInside];
        _transformScaleHBtn.layer.borderColor = [UIColor orangeColor].CGColor;
        _transformScaleHBtn.layer.borderWidth = 1;
    }
    return _transformScaleHBtn;
}

- (UIButton *)transformbBtn {
    if(!_transformbBtn) {
        _transformbBtn = [UIButton new];
        _transformbBtn.frame = CGRectMake(0 * self.manuW, self.manuY + self.manuH, self.manuW, self.manuH);
        [_transformbBtn setTitle:@"b change" forState:UIControlStateNormal];
        [_transformbBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_transformbBtn addTarget:self action:@selector(bchange) forControlEvents:UIControlEventTouchUpInside];
        _transformbBtn.layer.borderColor = [UIColor orangeColor].CGColor;
        _transformbBtn.layer.borderWidth = 1;
    }
    return _transformbBtn;
}

- (UIButton *)transformcBtn {
    if(!_transformcBtn) {
        _transformcBtn = [UIButton new];
        _transformcBtn.frame = CGRectMake(1 * self.manuW, self.manuY + self.manuH, self.manuW, self.manuH);
        [_transformcBtn setTitle:@"c change" forState:UIControlStateNormal];
        [_transformcBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_transformcBtn addTarget:self action:@selector(cchange) forControlEvents:UIControlEventTouchUpInside];
        _transformcBtn.layer.borderColor = [UIColor orangeColor].CGColor;
        _transformcBtn.layer.borderWidth = 1;
    }
    return _transformcBtn;
}

- (UIButton *)scaleBtn {
    if(!_scaleBtn) {
        _scaleBtn = [UIButton new];
        _scaleBtn.frame = CGRectMake(2 * self.manuW, self.manuY + self.manuH, self.manuW, self.manuH);
        [_scaleBtn setTitle:@"scale" forState:UIControlStateNormal];
        [_scaleBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_scaleBtn addTarget:self action:@selector(scale) forControlEvents:UIControlEventTouchUpInside];
        _scaleBtn.layer.borderColor = [UIColor orangeColor].CGColor;
        _scaleBtn.layer.borderWidth = 1;
    }
    return _scaleBtn;
}

- (UIButton *)invertBtn {
    if(!_invertBtn) {
        _invertBtn = [UIButton new];
        _invertBtn.frame = CGRectMake(3 * self.manuW, self.manuY + self.manuH, self.manuW, self.manuH);
        [_invertBtn setTitle:@"invert" forState:UIControlStateNormal];
        [_invertBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_invertBtn addTarget:self action:@selector(invert) forControlEvents:UIControlEventTouchUpInside];
        _invertBtn.layer.borderColor = [UIColor orangeColor].CGColor;
        _invertBtn.layer.borderWidth = 1;
    }
    return _invertBtn;
}

- (UIButton *)rotateBtn {
    if(!_rotateBtn) {
        _rotateBtn = [UIButton new];
        _rotateBtn.frame = CGRectMake(0 * self.manuW, self.manuY + 2 * self.manuH, self.manuW, self.manuH);
        [_rotateBtn setTitle:@"rotate" forState:UIControlStateNormal];
        [_rotateBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_rotateBtn addTarget:self action:@selector(rotate) forControlEvents:UIControlEventTouchUpInside];
        _rotateBtn.layer.borderColor = [UIColor orangeColor].CGColor;
        _rotateBtn.layer.borderWidth = 1;
    }
    return _rotateBtn;
}

- (UIButton *)contactBtn {
    if(!_contactBtn) {
        _contactBtn = [UIButton new];
        _contactBtn.frame = CGRectMake(1 * self.manuW, self.manuY + 2 * self.manuH, self.manuW, self.manuH);
        [_contactBtn setTitle:@"contact" forState:UIControlStateNormal];
        [_contactBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_contactBtn addTarget:self action:@selector(contact) forControlEvents:UIControlEventTouchUpInside];
        _contactBtn.layer.borderColor = [UIColor orangeColor].CGColor;
        _contactBtn.layer.borderWidth = 1;
    }
    return _contactBtn;
}

- (UIButton *)resetBtn {
    if(!_resetBtn) {
        _resetBtn = [UIButton new];
        _resetBtn.frame = CGRectMake(3  * self.manuW, self.manuY + self.manuH * 2, self.manuW, self.manuH);
        [_resetBtn setTitle:@"reset" forState:UIControlStateNormal];
        [_resetBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_resetBtn addTarget:self action:@selector(reset) forControlEvents:UIControlEventTouchUpInside];
        _resetBtn.layer.borderColor = [UIColor orangeColor].CGColor;
        _resetBtn.layer.borderWidth = 1;
    }
    return _resetBtn;
}

@end
