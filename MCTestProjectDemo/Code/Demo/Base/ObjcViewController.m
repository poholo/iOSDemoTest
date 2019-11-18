//
//  ObjcViewController.m
//  MCTestProjectDemo
//
//  Created by majiancheng on 2019/11/12.
//  Copyright © 2019 mjc. All rights reserved.
//

#import "ObjcViewController.h"

#import <objc/runtime.h>


@interface Bird : NSObject

- (void)singSong;

- (void)fly;

+ (NSString *)cate;

@end

@implementation Bird

- (void)fly {
    NSLog(@"Bird fly");
}

- (void)singSong {
    NSLog(@"I want sing a song");
}

+ (NSString *)cate {
    return @"I'm a bird class";
}


@end

@interface ObjcViewController ()

@end

@implementation ObjcViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Bird * bird = [Bird new];
    
    //error 
    BOOL resolve = [Bird resolveInstanceMethod:@selector(singSong)];
    if(resolve) {
        [bird singSong];
    } else {
        NSLog(@"un resolve SEL: singSong");
    }
    [bird fly];
    
    BOOL resolveC = [Bird resolveClassMethod:@selector(cate)];
    if(resolveC) {
        NSLog(@"resolve cate result %@", [Bird cate]);
    } else {
        NSLog(@"un resolve SEL: cate");
    }
}

@end
