//
// Created by majiancheng on 2019/10/30.
// Copyright (c) 2019 mjc. All rights reserved.
//

#import "ThreadController.h"

#import <ReactiveCocoa.h>
#import <Masonry.h>


@interface ThreadController()

@property(nonatomic, strong) UIButton *btnI;
@property(nonatomic, strong) UIButton *btnII;
@property(nonatomic, strong) UIButton *btnIII;
@property(nonatomic, strong) UIButton *btnIV;

@property(nonatomic, strong) UILabel *respLb;

@end

@implementation ThreadController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Thread";
    
    [self.view addSubview:self.btnI];
    [self.view addSubview:self.btnII];
    [self.view addSubview:self.btnIII];
    [self.view addSubview:self.btnIV];
    [self.view addSubview:self.respLb];
    
    [self.btnI mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.top.equalTo(self.view).offset(15);
        make.width.equalTo(self.btnII);
        make.right.equalTo(self.btnII.mas_left).offset(15);
        make.height.mas_equalTo(50);
    }];
    
    [self.btnII mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.btnI.mas_right).offset(15);
        make.top.equalTo(self.btnI);
        make.width.equalTo(self.btnI);
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.height.equalTo(self.btnI);
    }];
    
    [self.btnIII mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.left.right.equalTo(self.btnI);
        make.top.equalTo(self.btnI.mas_bottom).offset(15);
    }];
    
    [self.btnIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.left.right.equalTo(self.btnII);
        make.top.equalTo(self.btnIII);
    }];
    
    
    [self.respLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.top.equalTo(self.btnIII.mas_bottom).offset(15);
    }];
    
    
    
    
    
    
    
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

    /*{
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
     */
    
//    [self syncSerialTest];
//    [self syncConcurrentTest];
//    [self asyncSerialTest];
    [self asyncConcurrentTest];
}


- (void)syncSerialTest {
    @weakify(self);
    self.respLb.text = nil;
    dispatch_queue_t queue = dispatch_queue_create("com.mc.test", DISPATCH_QUEUE_SERIAL);
    dispatch_sync(queue, ^{
        @strongify(self);
        sleep(1);
        NSString * str = [NSString stringWithFormat:@"%s block1", __func__];
        [self showText:str];
        NSLog(@"%@", str);
    });
    
    dispatch_sync(queue, ^{
        @strongify(self);
        NSString * str = [NSString stringWithFormat:@"%s block2", __func__];
        [self showText:str];
        NSLog(@"%@", str);
    });
}

- (void)syncConcurrentTest {
    @weakify(self);
    self.respLb.text = nil;
    dispatch_queue_t queue = dispatch_queue_create("com.mc.test", DISPATCH_QUEUE_CONCURRENT);
    dispatch_sync(queue, ^{
        @strongify(self);
        sleep(2);
        NSString * str = [NSString stringWithFormat:@"%s block1", __func__];
        [self showText:str];
        NSLog(@"%@", str);
    });
    
    dispatch_sync(queue, ^{
        @strongify(self);
        NSString * str = [NSString stringWithFormat:@"%s block2", __func__];
        [self showText:str];
        NSLog(@"%@", str);
    });
}

- (void)asyncSerialTest {
    @weakify(self);
    self.respLb.text = nil;
    dispatch_queue_t queue = dispatch_queue_create("com.mc.test", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        @strongify(self);
        sleep(2);
        NSString * str = [NSString stringWithFormat:@"%s block1", __func__];
        [self showText:str];
        NSLog(@"%@", str);
    });
    dispatch_async(queue, ^{
        @strongify(self);
        NSString * str = [NSString stringWithFormat:@"%s block2", __func__];
        [self showText:str];
        NSLog(@"%@", str);
    });
}

- (void)asyncConcurrentTest {
    @weakify(self);
    self.respLb.text = nil;
    dispatch_queue_t queue = dispatch_queue_create("com.mc.test", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        @strongify(self);
        sleep(2);
        NSString * str = [NSString stringWithFormat:@"%s block1", __func__];
        [self showText:str];
        NSLog(@"%@", str);
    });
    dispatch_async(queue, ^{
        @strongify(self);
        sleep(1);
        NSString * str = [NSString stringWithFormat:@"%s block2", __func__];
        [self showText:str];
        NSLog(@"%@", str);
    });
}

- (void)showText:(NSString *)text {
    if([NSThread isMainThread]) {
        text = [NSString stringWithFormat:@"%@\n%@", self.respLb.text ? self.respLb.text : @"", text];
        self.respLb.text = text;
    } else {
        @weakify(self);
        dispatch_async(dispatch_get_main_queue(), ^{
            @strongify(self);
            NSString *info = [NSString stringWithFormat:@"%@\n%@", self.respLb.text ? self.respLb.text : @"", text];
            self.respLb.text = info;
        });
    }
}

#pragma mark - getter
- (UIButton *)btnI {
    if(!_btnI) {
        _btnI = [UIButton new];
        _btnI.backgroundColor = [UIColor blueColor];
        [_btnI setTitle:@"syncSerialTest" forState:UIControlStateNormal];
        @weakify(self);
        [[_btnI rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            [self syncSerialTest];
        }];
    }
    return _btnI;
}

- (UIButton *)btnII {
    if(!_btnII) {
        _btnII = [UIButton new];
        _btnII.backgroundColor = [UIColor blueColor];
        [_btnII setTitle:@"syncConcurrentTest" forState:UIControlStateNormal];
        @weakify(self);
        [[_btnII rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            [self syncConcurrentTest];
        }];
    }
    return _btnII;
}

- (UIButton *)btnIII {
    if(!_btnIII) {
        _btnIII = [UIButton new];
        _btnIII.backgroundColor = [UIColor blueColor];
        [_btnIII setTitle:@"asyncSerialTest" forState:UIControlStateNormal];
        @weakify(self);
        [[_btnIII rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            [self asyncSerialTest];
        }];
    }
    return _btnIII;
}

- (UIButton *)btnIV {
    if(!_btnIV) {
        _btnIV = [UIButton new];
        _btnIV.backgroundColor = [UIColor blueColor];
        [_btnIV setTitle:@"asyncConcurrentTest" forState:UIControlStateNormal];
        @weakify(self);
        [[_btnIV rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            [self asyncConcurrentTest];
        }];
    }
    return _btnIV;
}

- (UILabel *)respLb {
    if(!_respLb) {
        _respLb = [UILabel new];
        _respLb.numberOfLines = 0;
        _respLb.textAlignment = NSTextAlignmentCenter;
    }
    return _respLb;
}

@end
