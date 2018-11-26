//
//  ViewController.m
//  TestFFmpeg
//
//  Created by majiancheng on 2018/11/13.
//  Copyright © 2018 waqu. All rights reserved.
//

#import "ViewController.h"

#include "libavcodec/avcodec.h"
#include "libavformat/avformat.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    AVFormatContext    *pFormatCtx;
    int                i, videoindex;
    AVCodecContext    *pCodecCtx;
    AVCodec            *pCodec;
    AVFrame    *pFrame,*pFrameYUV;
    AVPacket *packet;
    struct SwsContext *img_convert_ctx;
   
    
    av_register_all();
    avformat_network_init();

}


@end
