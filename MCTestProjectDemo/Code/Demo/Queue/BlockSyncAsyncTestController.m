//
//  BlockSyncAsyncTestController.m
//  MCTestProjectDemo
//
//  Created by majiancheng on 2019/3/13.
//  Copyright © 2019 mjc. All rights reserved.
//

#import "BlockSyncAsyncTestController.h"


@interface BlockSyncAsyncTestController ()

@property(nonatomic, assign) NSInteger ticket;

@end

@implementation BlockSyncAsyncTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ticket = 100;
//    [self testAsync];
    NSLog(@"-----------------------");
//    [self testSync];
//    [self testGroup];
//    [self testSerialAsync2Sync];
//    [self testOperation];
//    [self testOperationQueue];
//    [self testOperationDepend];
//    [self testOperationDependOtherQueueOperation];
    [self sellA];
    [self sellB];
}

- (void)sellA {
    dispatch_queue_t queue = dispatch_queue_create("aQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        while (self.ticket > 0) {
            self.ticket -= 1;
            if(self.ticket < 0) {
                NSLog(@"a 卖完了");
                return;
            }
            NSLog(@"A left %zd %@", self.ticket, [NSThread currentThread]);
            
        }
    });
}

- (void)sellB {
    dispatch_queue_t queue = dispatch_queue_create("bQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        while (self.ticket > 0) {
            self.ticket -= 1;
            if(self.ticket < 0) {
                NSLog(@"B 卖完了");
                return;
            }
            NSLog(@"B left %zd %@", self.ticket, [NSThread currentThread]);
            
        }
    });
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

- (void)testGroup {
    //1.创建队列组
    dispatch_group_t group = dispatch_group_create();
    //2.创建队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

    //3.多次使用队列组的方法执行任务, 只有异步方法
    //3.1.执行3次循环
    dispatch_group_async(group, queue, ^{
        for (NSInteger i = 0; i < 3; i++) {
            NSLog(@"group-01 - %@", [NSThread currentThread]);
        }
    });

    //3.2.主队列执行8次循环
    dispatch_group_async(group, dispatch_get_main_queue(), ^{
        for (NSInteger i = 0; i < 8; i++) {
            NSLog(@"group-02 - %@", [NSThread currentThread]);
        }
    });

    //3.3.执行5次循环
    dispatch_group_async(group, queue, ^{
        for (NSInteger i = 0; i < 5; i++) {
            NSLog(@"group-03 - %@", [NSThread currentThread]);
        }
    });

    //4.都完成后会自动通知
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"完成 - %@", [NSThread currentThread]);
    });
}

- (void)testSerialAsync2Sync {
    dispatch_queue_t queue = dispatch_queue_create("com.test.mm", DISPATCH_QUEUE_SERIAL);
    NSLog(@"1.....");
    dispatch_async(queue, ^{
        NSLog(@"2.....");
        dispatch_sync(queue, ^{
            NSLog(@"3....");
        });
        
        NSLog(@"4....");
        
    });
    
    NSLog(@"5....");
}

- (void)testOperation {
    //1.创建NSBlockOperation对象
     NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
         NSLog(@"%@", [NSThread currentThread]);
     }];

     //添加多个Block
     for (NSInteger i = 0; i < 5; i++) {
         [operation addExecutionBlock:^{
             NSLog(@"第%ld次：%@", i, [NSThread currentThread]);
         }];
     }

     //2.开始任务
     [operation start];
}

- (void)testOperationQueue {
    //1.创建一个其他队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];

    //2.创建NSBlockOperation对象
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"%@", [NSThread currentThread]);
    }];

    //3.添加多个Block
    for (NSInteger i = 0; i < 5; i++) {
        [operation addExecutionBlock:^{
            NSLog(@"第%ld次：%@", i, [NSThread currentThread]);
        }];
    }

    //4.队列添加任务
    [queue addOperation:operation];
}

- (void)testOperationDepend {
    //1.任务一：下载图片
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"下载图片 - %@", [NSThread currentThread]);
        [NSThread sleepForTimeInterval:1.0];
    }];

    //2.任务二：打水印
    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"打水印   - %@", [NSThread currentThread]);
        [NSThread sleepForTimeInterval:1.0];
    }];

    //3.任务三：上传图片
    NSBlockOperation *operation3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"上传图片 - %@", [NSThread currentThread]);
        [NSThread sleepForTimeInterval:1.0];
    }];

    //4.设置依赖
    [operation2 addDependency:operation1];      //任务二依赖任务一
    [operation3 addDependency:operation2];      //任务三依赖任务二

    //5.创建队列并加入任务
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperations:@[operation3, operation2, operation1] waitUntilFinished:NO];
}


- (void)testOperationDependOtherQueueOperation {
    //1.任务一：下载图片
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"下载图片 - %@", [NSThread currentThread]);
        [NSThread sleepForTimeInterval:1.0];
    }];

    //2.任务二：打水印
    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"打水印   - %@", [NSThread currentThread]);
        [NSThread sleepForTimeInterval:1.0];
    }];

    //3.任务三：上传图片
    NSBlockOperation *operation3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"上传图片 - %@", [NSThread currentThread]);
        [NSThread sleepForTimeInterval:1.0];
    }];
    
    NSBlockOperation *operation4 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"保存到本地... %@", [NSThread currentThread]);
    }];

    //4.设置依赖
    [operation2 addDependency:operation1];      //任务二依赖任务一
    [operation4 addDependency:operation2];
    [operation3 addDependency:operation4];      //任务三依赖任务二

    //5.创建队列并加入任务
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperations:@[operation3, operation2, operation1] waitUntilFinished:NO];
    
    NSOperationQueue *otherQueue = [[NSOperationQueue alloc] init];
    [otherQueue addOperation:operation4];
}


@end
