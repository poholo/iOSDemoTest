//
// Created by majiancheng on 2017/8/16.
// Copyright (c) 2017 waqu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <JavaScriptCore/JavaScriptCore.h>

@protocol WidtoExport <JSExport>

@property(nonatomic, strong) NSString *uri;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *video_uri;
@property(nonatomic, strong) NSString *video_uri_sd;
@property(nonatomic, strong) NSString *video_uri_ed;
@property(nonatomic, strong) NSString *video_uri_hd720;

@end

@interface Wideo : NSObject <WidtoExport> {
    JSContext *_ctx;
}
- (id)initWithContext:(JSContext *)ctx;

@end