//
// Created by majiancheng on 2019/10/30.
// Copyright (c) 2019 mjc. All rights reserved.
//

#import "ThreadController.h"


@implementation ThreadController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Thread";
//    dispatch_sync(dispatch_get_main_queue(), ^{
//        NSLog(@"%@", [NSThread currentThread]);
//    });

    {
//        dispatch_queue_t queue = dispatch_queue_create("com.test.tt1.thread", DISPATCH_QUEUE_SERIAL);
//        dispatch_sync(queue, ^{
//            NSLog(@"%@ sync", [NSThread currentThread]);
//        });
//
//        dispatch_async(queue, ^{
//            NSLog(@"%@ async", [NSThread currentThread]);
//        });
//        NSLog(@"exe end");
    }

    {
        dispatch_queue_t queue = dispatch_get_main_queue();
        dispatch_async(queue, ^{
            NSLog(@"1");
            NSThread *mainThread = [NSThread currentThread];
            NSLog(@"currentThread == %@", mainThread);
            sleep(3);
            NSLog(@"2");
        });
        NSLog(@"主线程执行完了");
    }
}
@end
