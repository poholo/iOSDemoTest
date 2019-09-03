//
//  LockController.m
//  MCTestProjectDemo
//
//  Created by majiancheng on 2019/8/16.
//  Copyright © 2019 mjc. All rights reserved.
//

#import "LockController.h"

#import <libkern/OSAtomic.h>
#import <os/lock.h>
#import <pthread.h>

@interface LockController ()

@property(nonatomic, assign) NSInteger money;
@property(nonatomic, assign) OSSpinLock lock;

@property(nonatomic, assign) os_unfair_lock unfair_lock;
@property(nonatomic, assign) pthread_mutex_t mutex_lock;

@end

@implementation LockController

- (void)dealloc {
    if(&_mutex_lock) {
        pthread_mutex_destroy(&_mutex_lock);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.money = 100;
    self.lock = OS_SPINLOCK_INIT;
    
    self.unfair_lock = OS_UNFAIR_LOCK_INIT;
    
    [self configMutextLock];
    
    [self moneyTest];
}

- (void)configMutextLock {
    // 初始化属性
    pthread_mutexattr_t attr;
    pthread_mutexattr_init(&attr);
    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_DEFAULT);
    // 初始化锁
    pthread_mutex_init(&_mutex_lock, &attr);
    // 销毁属性
    pthread_mutexattr_destroy(&attr);
    
    // 上面五行相当于下面一行
    //pthread_mutex_init(&mutex, NULL); //传空，相当于PTHREAD_MUTEX_DEFAULT
}

- (void)moneyTest {
    dispatch_queue_global_t queue = dispatch_get_global_queue(0, 0);
    
    dispatch_async(queue, ^{
        for(int i = 0; i < 5; i++) {
            [self saveMoney];
        }
    });
    
    dispatch_async(queue, ^{
        for(int i = 0; i < 5; i++) {
            [self drawMoney];
        }
    });
    
}

- (void)saveMoney {
//    OSSpinLockLock(&_lock);
//    os_unfair_lock_lock(&_unfair_lock);
    pthread_mutex_lock(&_mutex_lock);
    [self __saveMoney];
    pthread_mutex_unlock(&_mutex_lock);
//    os_unfair_lock_unlock(&_unfair_lock);
//    OSSpinLockUnlock(&_lock);
}

- (void)drawMoney {
//    OSSpinLockLock(&_lock);
//    os_unfair_lock_lock(&_unfair_lock);
    pthread_mutex_lock(&_mutex_lock);
    [self __drawMoney];
    pthread_mutex_unlock(&_mutex_lock);
//    os_unfair_lock_unlock(&_unfair_lock);
//    OSSpinLockUnlock(&_lock);
}

- (void)__saveMoney {
    NSInteger oldMoney = self.money;
    sleep(.2);
    oldMoney += 10;
    self.money = oldMoney;
    NSLog(@"存10元，还剩余%zd, %@", self.money, NSThread.currentThread);
}

- (void)__drawMoney {
    NSInteger oldMoney = self.money;
    sleep(.2);
    oldMoney -= 20;
    self.money = oldMoney;
    NSLog(@"取20元，还剩余%zd, %@", self.money, NSThread.currentThread);
}

/* 自旋锁多用于多线程同步，线程反复检查锁变量是否可以用，
 用于线程在这一过程中保持执行，所以是一种忙等待。一旦获得自旋锁，线程会一直保持该锁，直至显示释放自旋锁
 阻塞比较短的时间
 
 互斥锁 用于多线程编程中防止两条线程同时对同一公共资源进行读写操作
 */

@end
