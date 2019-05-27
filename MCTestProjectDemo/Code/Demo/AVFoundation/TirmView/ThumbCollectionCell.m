//
// Created by majiancheng on 2017/9/8.
// Copyright (c) 2017 挖趣智慧科技（北京）有限公司. All rights reserved.
//

#import "ThumbCollectionCell.h"

@interface ThumbCollectionCell ()

@property(nonatomic, strong) UIImageView *imageView;

@end


@implementation ThumbCollectionCell {

}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.imageView];
        self.imageView.frame = self.bounds;
    }
    return self;
}

- (void)loadData:(UIImage *)image {
    self.imageView.image = image;
}


- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imageView;
}

+ (NSString *)identifier {
    return NSStringFromClass(self.class);
}


@end