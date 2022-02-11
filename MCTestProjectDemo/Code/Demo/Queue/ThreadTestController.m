//
//  OprationController.m
//  MCTestProjectDemo
//
//  Created by Ma Jiancheng on 2022/2/9.
//  Copyright © 2022 mjc. All rights reserved.
//

#import "ThreadTestController.h"

@interface ThreadTestController ()

@property (weak, nonatomic) IBOutlet UILabel *watchLogLb;

@property(nonatomic, strong) NSMutableArray<NSString *> *infos;

@property(nonatomic, strong) NSThread *thread;
@property(nonatomic, assign) BOOL isInsertExitSignal;
@property(nonatomic, strong) NSLock *lock;

@end

@implementation ThreadTestController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lock = [NSLock new];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actionNSThreadWillExitNotification) name:NSThreadWillExitNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actionNSWillBecomeMultiThreadedNotification) name:NSWillBecomeMultiThreadedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actionNSDidBecomeSingleThreadedNotification) name:NSDidBecomeSingleThreadedNotification object:nil];
    self.thread = [[NSThread alloc] initWithTarget:self selector:@selector(test) object:nil];
    self.thread.name = @"mm";
    
}

- (void)actionNSThreadWillExitNotification {
    [self log:@"actionNSThreadWillExitNotification"];
    [self log:[NSString stringWithFormat:@"threadnm = %@ isMain = %d isExecuting %d", NSThread.currentThread.name, NSThread.currentThread.isMainThread, NSThread.currentThread.isExecuting]];
}

- (void)actionNSWillBecomeMultiThreadedNotification {
    [self log:@"actionNSWillBecomeMultiThreadedNotification"];
    [self log:[NSString stringWithFormat:@"threadnm = %@ isMain = %d isExecuting %d", NSThread.currentThread.name, NSThread.currentThread.isMainThread, NSThread.currentThread.isExecuting]];
}

- (void)actionNSDidBecomeSingleThreadedNotification {
    [self log:@"actionNSDidBecomeSingleThreadedNotification"];
    [self log:[NSString stringWithFormat:@"threadnm = %@ isMain = %d isExecuting %d", NSThread.currentThread.name, NSThread.currentThread.isMainThread, NSThread.currentThread.isExecuting]];
}

- (void)clear {
    [self.infos removeAllObjects];
    if(NSThread.isMainThread) {
        self.watchLogLb.text = @"...";
    } else {
        [self.lock lock];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.watchLogLb.text = @"...";
        });
        [self.lock unlock];
    }
}

- (void)log:(NSString *)info {
    [self.infos addObject:info];
    if(NSThread.isMainThread) {
        self.watchLogLb.text = [self.infos componentsJoinedByString:@"\n"];
    } else {
        [self.lock lock];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.watchLogLb.text = [self.infos componentsJoinedByString:@"\n"];
        });
        [self.lock unlock];
    }
}

- (IBAction)threadClick:(id)sender {
    if(self.thread.isExecuting) {
        [self log:[NSString stringWithFormat:@"thread %@ isExecuting", self.thread.name]];
        return;
    }
    [self.thread start];
    [self log:@"action start"];
}

- (IBAction)attach:(id)sender {
    [self.thread performSelector:@selector(test) withObject:nil];
    [self log:@"attach"];
}

- (IBAction)threadSleep10:(id)sender {
    [NSThread sleepUntilDate:[NSDate dateWithTimeIntervalSinceNow:10]];
    [self log:@"sleep 10"];
}
- (IBAction)detachNewThreadSelectorTest:(id)sender {
    
    [NSThread detachNewThreadSelector:@selector(detachNewThreadSelectorTesting) toTarget:self withObject:nil];
}

- (void)detachNewThreadSelectorTesting {
    [self clear];
    [self log:@"detachNewThreadSelectorTesting"];
    [self log:[NSString stringWithFormat:@"%@ isMainThread = %d isExecuting = %d", NSThread.currentThread.name, NSThread.currentThread.isMainThread, NSThread.currentThread.isExecuting]];
    
}

- (IBAction)cancelThread:(id)sender {
    [self.thread cancel];
    [self log:@"cancel"];
}

- (IBAction)exitThread:(id)sender {
    self.isInsertExitSignal = true;
    [self log:@"exit"];
}

- (void)test {
    [self.infos addObject:[NSString stringWithFormat:@"current isMainThread %d ", self.thread.isMainThread]];
    [self log:@"start test.."];
    NSInteger t = 0;
    while (t < 10) {
        sleep(1);
        t++;
        [self log:[NSString stringWithFormat:@"... %zd", t]];
        if(self.isInsertExitSignal) {
            [self log:@"eixt..ing"];
            self.isInsertExitSignal = false;
            [NSThread exit];
            [self log:@"eixt..ing next"];
        }
    }
    [self log:@"finished"];
    
}


- (NSMutableArray<NSString *> *)infos {
    if(!_infos) {
        _infos = [NSMutableArray new];
    }
    return _infos;
}

@end
