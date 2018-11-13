//
// Created by majiancheng on 2017/7/28.
// Copyright (c) 2017 waqu. All rights reserved.
//

#import "PlayerController.h"

#import <AVFoundation/AVFoundation.h>

@interface PlayerController ()

@property(nonatomic, strong) AVPlayer *player;
@property(nonatomic, strong) AVPlayerLayer *playerLayer;

@end


@implementation PlayerController {

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _player = ({
        NSString * filePath = [[NSBundle mainBundle] pathForResource:@"59c0defacecaab508c5b9bab" ofType:@"m4a"];
        AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:[NSURL fileURLWithPath:filePath]];
        AVPlayer *player = [[AVPlayer alloc] initWithPlayerItem:playerItem];

        player;
    });

//    _playerLayer = ({
//        AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:_player];
//        layer.frame = CGRectMake(0, 64,
//                [UIScreen mainScreen].bounds.size.width,
//                self.asset.naturalSize.height * [UIScreen mainScreen].bounds.size.width / self.asset.naturalSize.width );
//        [self.view.layer addSublayer:layer];
//        layer;
//    });

    [_player play];
}
@end
