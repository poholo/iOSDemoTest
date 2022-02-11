//
//  BlockSyncAsyncTestController.m
//  MCTestProjectDemo
//
//  Created by majiancheng on 2019/3/13.
//  Copyright © 2019 mjc. All rights reserved.
//

#import "BlockSyncAsyncTestController.h"


@interface BlockSyncAsyncTestController ()

@end

@implementation BlockSyncAsyncTestController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self testAsync];
    NSLog(@"-----------------------");
    [self testSync];
}

- (void)testAsync {
    NSDictionary *(^apiAdConfigMaterialSourceTypeCallBack)(id type);
    apiAdConfigMaterialSourceTypeCallBack = ^ NSDictionary *(id type) {
        NSLog(@"async block before");
        BOOL sleep = NO;
        while (!sleep) {
            sleep = YES;
            [[NSRunLoop mainRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:2]];
        }
        NSLog(@"async block end");
        return @{@"msg": @"Hello async block"};
    };
    NSLog(@"aync before");
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSDictionary * dict = apiAdConfigMaterialSourceTypeCallBack(nil);
        NSLog(@"aync callBack %@", dict);
    });
    
    NSLog(@"async end");
}

- (void)testSync {
    NSDictionary *(^apiAdConfigMaterialSourceTypeCallBack)(id type);
    apiAdConfigMaterialSourceTypeCallBack = ^ NSDictionary *(id type) {
        NSLog(@"sync block before");
        BOOL sleep = NO;
        while (!sleep) {
            sleep = YES;
            [[NSRunLoop mainRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:2]];
        }
        NSLog(@"sync block end");
        return @{@"msg": @"Hello aync block"};
    };
    NSLog(@"ync before");
    NSDictionary * dict = apiAdConfigMaterialSourceTypeCallBack(nil);
    NSLog(@"ync callBack %@", dict);
    NSLog(@"sync end");
}

@end
