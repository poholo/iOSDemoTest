//
//  TestFFmpeg.c
//  TestMac
//
//  Created by majiancheng on 2018/11/7.
//  Copyright © 2018 waqu. All rights reserved.
//

#include "TestFFmpeg.h"



#include "libavcodec/avcodec.h"
#include "libavformat/avformat.h"
#include "libswscale/swscale.h"
#include "SDL.h"

int main(int argc, char *argv[]) {
    AVFormatContext * pFormatCtx;
    int i, videoIndex;
    printf("hello, ffmpeg\n");
    avformat_network_init();
//    av_register_all();
    return 0;
}
