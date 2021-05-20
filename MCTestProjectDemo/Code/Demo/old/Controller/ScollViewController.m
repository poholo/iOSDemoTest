//
//  ScollViewController.m
//  MCTestProjectDemo
//
//  Created by majiancheng on 2019/10/17.
//  Copyright © 2019 mjc. All rights reserved.
//

#import "ScollViewController.h"

@interface ScollViewController () <UIScrollViewDelegate>

@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) UIImageView *imageView;

@property(nonatomic, strong) UILabel * scaleLabel;
@property(nonatomic, strong) UILabel * frameLabel;
@property(nonatomic, strong) UILabel * contentOffsetLabel;
@property(nonatomic, strong) UILabel * contentSizeLabel;
@property(nonatomic, strong) UILabel * rotateLabel;

@property(nonatomic, strong) UIButton *changeImageBtn;

@end

@implementation ScollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.imageView];
    
    [self.view addSubview:self.scaleLabel];
    [self.view addSubview:self.contentOffsetLabel];
    [self.view addSubview:self.frameLabel];
    [self.view addSubview:self.contentSizeLabel];
    [self.view addSubview:self.rotateLabel];
    [self.view addSubview:self.changeImageBtn];
    
  
    self.contentOffsetLabel.text = [NSString stringWithFormat:@"contentOffset: {%lf, %lf}", self.scrollView.contentOffset.x, self.scrollView.contentOffset.y];
    self.scaleLabel.text = [NSString stringWithFormat:@"scale: %lf", self.scrollView.zoomScale];
    self.frameLabel.text  = [NSString stringWithFormat:@"frame: {{%lf, %lf}, {%lf, %lf}}", self.imageView.frame.origin.x, self.imageView.frame.origin.y, self.imageView.frame.size.width, self.imageView.frame.size.height];
    self.contentSizeLabel.text = [NSString stringWithFormat:@"contentSize: {%lf, %lf}", self.scrollView.contentSize.width, self.scrollView.contentSize.height];
    
    CGAffineTransform transform = self.imageView.transform;
     self.rotateLabel.text = [NSString stringWithFormat:@"rotate: {%lf, %lf, %lf, %lf} {%lf, %lf}", transform.a, transform.b, transform.c, transform.d, transform.tx, transform.ty];
    
}

- (void)changeBtnClick {
    self.imageView.image = [UIImage imageNamed:@"timg-2.jpeg"];
    {
          [self.scrollView setZoomScale:2 animated:YES];
          [self.scrollView setContentOffset:CGPointMake(179, 145) animated:YES];
      }
}

- (void)rotate:(UIRotationGestureRecognizer *)rotation {
    if(rotation.view != self.imageView)
        return;
    
    rotation.view.transform = CGAffineTransformRotate(rotation.view.transform, rotation.rotation);
    rotation.rotation = 0.0;
    
    CGAffineTransform transform = self.imageView.transform;
        self.rotateLabel.text = [NSString stringWithFormat:@"rotate: {%lf, %lf, %lf, %lf} {%lf, %lf}", transform.a, transform.b, transform.c, transform.d, transform.tx, transform.ty];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    self.scaleLabel.text = [NSString stringWithFormat:@"scale: %lf", scale];
    self.frameLabel.text  = [NSString stringWithFormat:@"frame:{{%lf, %lf}, {%lf, %lf}}", self.imageView.frame.origin.x, self.imageView.frame.origin.y, self.imageView.frame.size.width, self.imageView.frame.size.height];
    self.contentSizeLabel.text = [NSString stringWithFormat:@"contentSize: {%lf, %lf}", self.scrollView.contentSize.width, self.scrollView.contentSize.height];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.contentOffsetLabel.text = [NSString stringWithFormat:@"contentOffset: {%lf, %lf}", scrollView.contentOffset.x, scrollView.contentOffset.y];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
}


- (UIScrollView *)scrollView {
    if(!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(100, 70, 200, 300)];
        _scrollView.delegate = self;
        _scrollView.minimumZoomScale = 1;
        _scrollView.maximumZoomScale = 10;
    }
    return _scrollView;
}

- (UIImageView *)imageView {
    if(!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:self.scrollView.bounds];
        _imageView.image = [UIImage imageNamed:@"timg.jpeg"];
        _imageView.userInteractionEnabled = YES;
        [_imageView addGestureRecognizer:[[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotate:)]];
    }
    return _imageView;
}

- (UILabel *)scaleLabel {
    if(!_scaleLabel) {
        _scaleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, CGRectGetMaxY(self.scrollView.frame) + 10 , 400, 20)];
        _scaleLabel.font = [UIFont systemFontOfSize:12];
    }
    return _scaleLabel;
}


- (UILabel *)frameLabel {
    if(!_frameLabel) {
        _frameLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, CGRectGetMaxY(self.scaleLabel.frame) + 10 , 400, 20)];
        _frameLabel.font = [UIFont systemFontOfSize:12];
    }
    return _frameLabel;
}

- (UILabel *)contentOffsetLabel {
    if(!_contentOffsetLabel) {
        _contentOffsetLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, CGRectGetMaxY(self.frameLabel.frame) + 10 , 400, 20)];
        _contentOffsetLabel.font = [UIFont systemFontOfSize:12];
    }
    return _contentOffsetLabel;
}

- (UILabel *)contentSizeLabel {
    if(!_contentSizeLabel) {
        _contentSizeLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, CGRectGetMaxY(self.contentOffsetLabel.frame) + 10 , 400, 20)];
        _contentSizeLabel.font = [UIFont systemFontOfSize:12];
    }
    return _contentSizeLabel;
}

- (UILabel *)rotateLabel {
    if(!_rotateLabel) {
        _rotateLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, CGRectGetMaxY(self.contentSizeLabel.frame) + 10 , 400, 40)];
               _rotateLabel.font = [UIFont systemFontOfSize:12];
        _rotateLabel.numberOfLines = 2;
    }
    return _rotateLabel;
}

- (UIButton *)changeImageBtn {
    if(!_changeImageBtn) {
        _changeImageBtn = [[UIButton alloc] initWithFrame:CGRectMake(40, CGRectGetMaxY(self.rotateLabel.frame), 60, 30)];
        [_changeImageBtn setTitle:@"changeImage" forState:UIControlStateNormal];
        [_changeImageBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_changeImageBtn addTarget:self action:@selector(changeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _changeImageBtn;
}

@end
