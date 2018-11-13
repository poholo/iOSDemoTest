//
// Created by majiancheng on 2017/8/16.
// Copyright (c) 2017 waqu. All rights reserved.
//

#import "Wideo.h"


@implementation Wideo {

}

@synthesize uri, title, video_uri, video_uri_sd, video_uri_ed, video_uri_hd720;

- (id)initWithContext:(JSContext *)ctx {
    if (self = [super init]) {
        _ctx = ctx;

    }
    return self;
}

@end