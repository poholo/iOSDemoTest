//
//  PlayerTestViewController.m
//  DrewTest
//
//  Created by majiancheng on 2017/6/26.
//  Copyright © 2017年 waqu. All rights reserved.
//

#import "PlayerTestViewController.h"

#import <AVFoundation/AVFoundation.h>

@interface PlayerTestViewController ()

@property(nonatomic, strong) AVPlayer *player;
@property(nonatomic, strong) AVPlayerLayer *playerLayer;
@property(nonatomic, strong) AVURLAsset *asset;

@property(nonatomic, assign) CFAbsoluteTime startTime;


@end

@implementation PlayerTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.asset = [AVURLAsset assetWithURL:[NSURL URLWithString:@"https://vssauth.waqu.com/3jdqfuipe0iy8w7y/hd2.mp4?auth_key=1498474319-0-0-90e277e345b37c702bbb15cb8541be58"]];
    AVPlayerItem *item = [AVPlayerItem playerItemWithAsset:self.asset];
    _player = [[AVPlayer alloc] initWithPlayerItem:item];


    _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    _playerLayer.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 300);
    [self.view.layer addSublayer:_playerLayer];

    [_player play];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];

}

- (void)playEnd {

    NSString *documentDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *myPathDocument = [documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp4", @"ccccccc"]];


    NSURL *fileUrl = [NSURL fileURLWithPath:myPathDocument];

    if (self.asset != nil) {
        AVMutableComposition *mixComposition = [[AVMutableComposition alloc] init];
        AVMutableCompositionTrack *firstTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];
        [firstTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, self.asset.duration) ofTrack:[[self.asset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0] atTime:kCMTimeZero error:nil];

        AVMutableCompositionTrack *audioTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:kCMPersistentTrackID_Invalid];
        [audioTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, self.asset.duration) ofTrack:[[self.asset tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0] atTime:kCMTimeZero error:nil];

        AVAssetExportSession *exporter = [[AVAssetExportSession alloc] initWithAsset:mixComposition presetName:AVAssetExportPresetHighestQuality];

        self.startTime = CFAbsoluteTimeGetCurrent();
        exporter.outputURL = fileUrl;
        if (exporter.supportedFileTypes) {
            exporter.outputFileType = [exporter.supportedFileTypes objectAtIndex:0];
            exporter.shouldOptimizeForNetworkUse = YES;

            NSLog(@"start");

            __weak  typeof(self) weakSelf = self;
            [exporter exportAsynchronouslyWithCompletionHandler:^{
                __strong typeof(weakSelf) strongSelf = weakSelf;
                NSLog(@"end");
                NSLog(@"losttime: %lf", CFAbsoluteTimeGetCurrent() - strongSelf.startTime);
            }];

        }
    }
}

@end
