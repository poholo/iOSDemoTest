//
//  QueueViewController.m
//  MCTestProjectDemo
//
//  Created by Ma Jiancheng on 2022/2/9.
//  Copyright © 2022 mjc. All rights reserved.
//

#import "QueueViewController.h"

@interface QueueViewController ()

@property (weak, nonatomic) IBOutlet UILabel *watchLogLb;

@property(nonatomic, strong) NSMutableArray<NSString *> *infos;

@property(nonatomic, strong) NSOperation *oprationA;
@property(nonatomic, strong) NSOperation *invocationOpration;
@property(nonatomic, strong) NSOperationQueue *syncQueue;

@property(nonatomic, strong) NSOperationQueue *otherSyncQueue;
@property(nonatomic, strong) NSLock *lock;

@end

@implementation QueueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.oprationA = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(dependAAction) object:nil];
    
}


- (void)clear {
    [self.lock lock];
    [self.infos removeAllObjects];
    if(NSThread.isMainThread) {
        self.watchLogLb.text = @"...";
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.watchLogLb.text = @"...";
        });
    }
    [self.lock unlock];
}

- (void)log:(NSString *)info {
    NSLog(@"%@", info);
    [self.lock lock];
    [self.infos addObject:info];
    NSString * i = [self.infos componentsJoinedByString:@"\n"];
    if(NSThread.isMainThread) {
        self.watchLogLb.text = i;
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.watchLogLb.text = i;
        });
    }
    [self.lock unlock];
}

- (void)logThredInfos {
    NSThread *ct = [NSThread currentThread];
    [self log:[NSString stringWithFormat:@"nm:%@ isMain:%d isexecuting:%d isfinished:%d", ct.name, ct.isMainThread, ct.isExecuting, ct.isFinished]];
}

- (void)dependAAction {
    [self log:@"dependAAction"];
    [self logThredInfos];
}

- (IBAction)oprationTest:(id)sender {
    NSOperation * opration = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(invocationOprationTest) object:nil];
    opration.name = @"InvocationOpration";
    self.invocationOpration = opration;
    [opration start];
}

- (void)invocationOprationTest {
    [self logThredInfos];
    [self log:@"invocationOprationTest"];
    
}
- (IBAction)blockOprationClick:(id)sender {
    __weak typeof(self) weakSelf = self;
    NSOperation *opration = [NSBlockOperation blockOperationWithBlock:^{
        [weakSelf log:@"blockOprationClick"];
        [weakSelf logThredInfos];
    }];
    
    [opration start];
}

- (IBAction)dependAClick:(id)sender {
    [self.oprationA addDependency:self.invocationOpration];
    [self.oprationA start];
}

- (IBAction)startQueueAction:(id)sender {
    [self.syncQueue setSuspended:true];
}
- (IBAction)syncMainQueueDeSuspend:(id)sender {
    
    self.syncQueue.suspended = false;
    [self log:@"Desuspend"];
}
- (IBAction)syncQueueStartClick:(id)sender {
    self.otherSyncQueue.suspended = true;
}
- (IBAction)syncQueueDesuspendClick:(id)sender {
    self.otherSyncQueue.suspended = false;
}


- (NSMutableArray<NSString *> *)infos {
    if(!_infos) {
        _infos = [NSMutableArray new];
    }
    return _infos;
}

- (NSOperationQueue *)syncQueue {
    if(!_syncQueue) {
        _syncQueue = [NSOperationQueue mainQueue];
        
        [_syncQueue addOperation:[self createAOpration:@"aaa"]];
        [_syncQueue addOperation:[self createAOpration:@"bbb"]];
        [_syncQueue addOperation:[self createAOpration:@"cccc"]];
    }
    return _syncQueue;
}

- (NSOperationQueue *)otherSyncQueue {
    if(!_otherSyncQueue) {
        _otherSyncQueue = [[NSOperationQueue alloc] init];
        _otherSyncQueue.name = @"otherSyncQueue";
        __weak typeof(self) weakSelf = self;
        [_otherSyncQueue addOperationWithBlock:^{
            sleep(1);
            int a = 0;
            while (a < 5) {
                a ++;
                [weakSelf log:[NSString stringWithFormat:@"oA - %d", a]];
            }
        }];
        
        [_otherSyncQueue addOperationWithBlock:^{
            sleep(1);
            int a = 0;
            while (a < 5) {
                a ++;
                [weakSelf log:[NSString stringWithFormat:@"oB - %d", a]];
            }
        }];
        
        [_otherSyncQueue addOperationWithBlock:^{
            sleep(1);
            int a = 0;
            while (a < 5) {
                a ++;
                [weakSelf log:[NSString stringWithFormat:@"oC - %d", a]];
            }
        }];
        
        _otherSyncQueue.maxConcurrentOperationCount = 1;
    }
    return _otherSyncQueue;
}

- (NSLock *)lock {
    if(!_lock) {
        _lock = [NSLock new];
    }
    return _lock;
}

- (NSOperation *)createAOpration:(NSString *)name {
    NSInvocationOperation *opration = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(aOprationAction:) object:name];
    opration.name = name;
    return opration;
}

- (void)aOprationAction:(NSString *)opnm {
    int a = 0;
    while (a < 4) {
        [self logThredInfos];
        sleep(1);
        [self log:[NSString stringWithFormat:@"%@...%d", opnm, a]];
        a++;
    }
}

@end
