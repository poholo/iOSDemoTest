//
// Created by majiancheng on 2017/8/15.
// Copyright (c) 2017 waqu. All rights reserved.
//

#import "JSCoreController.h"
#import "Wideo.h"

#import <AVFoundation/AVFoundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@interface JSCoreController ()

@property(nonatomic, strong) AVPlayer *player;
@property(nonatomic, strong) AVPlayerLayer *playerLayer;

@end

@implementation JSCoreController {

}

- (void)viewDidLoad {
    [super viewDidLoad];


    {
        JSContext *context = [[JSContext alloc] init];

        // load lib into JSContext
        NSError *error = nil;
        NSString *libPath = [[NSBundle mainBundle] pathForResource:@"Test" ofType:@"js"];
        NSString *lib = [NSString stringWithContentsOfFile:libPath encoding:NSUTF8StringEncoding error:&error];
        [context evaluateScript:lib];

        // test libs
        [context evaluateScript:@"var a = hello()"];
        JSValue *o = context[@"a"];
        NSLog(@"object: %@", [o toString]);

        [context evaluateScript:@"var b = add(10 , 20)"];
        JSValue *b = context[@"b"];
        NSLog(@"object b: %d", [b toInt32]);
    }

    {
        JSContext *context = [[JSContext alloc] init];

        NSError *error;
        NSString *libPath = [[NSBundle mainBundle] pathForResource:@"script2" ofType:@"js"];
        NSString *lib = [NSString stringWithContentsOfFile:libPath encoding:NSUTF8StringEncoding error:&error];
        if (error) {
            NSLog(@"readError::::::%@", error);
        } else {
            context.exceptionHandler = ^(JSContext *ctx, JSValue *exception) {
                NSLog(@"Exception::::::%@", exception);
            };

            [context evaluateScript:lib];
            context[@"log"] = ^(JSValue *value) {
                NSLog(@"log:::::%@", [value toString]);
            };

            context[@"getHtmlUrl"] = ^(JSValue *url, JSValue *header) {
                NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[url toString]]];
                NSString *html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                return html;
            };



//            [context evaluateScript:@"var bb = test()"];
//            JSValue *bb = context[@"bb"];
//            NSLog(@"test:::::%@", [bb toString]);
            JSValue  *result = [context evaluateScript:@"var url = sniff('http://www.meipai.com/media/813367392', 'ios')"];
            id obj = [result toObject];
            NSLog(@"result:::::%@", obj);

            {
                _player = ({
                    AVPlayer *player = [AVPlayer playerWithURL:[NSURL URLWithString:obj[@"video_uri"]]];
                    player;
                });

                _playerLayer = ({
                    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:_player];
                    [self.view.layer addSublayer:layer];
                    layer.frame = CGRectMake(0, 64, self.view.frame.size.width, 300);
                    layer;
                });

                [_player play];
            }

        }
    }


}
@end
