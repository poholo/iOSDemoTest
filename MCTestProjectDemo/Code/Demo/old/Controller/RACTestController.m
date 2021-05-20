//
// Created by majiancheng on 2019/10/28.
// Copyright (c) 2019 mjc. All rights reserved.
//

#import "RACTestController.h"

#import <ReactiveCocoa.h>

#import "RACTestDataVM.h"

@interface RACTestController ()

@property(nonatomic, strong) RACTestDataVM * dataVM;

@end

@implementation RACTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView reloadData];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.dataVM.dataList[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataVM.dataList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * info = self.dataVM.dataList[indexPath.row];
    SEL sel = NSSelectorFromString(info);
    if([self respondsToSelector:sel]) {
        [self performSelector:sel];
    }
}



- (void)bind {
    RACSignal *signal = [RACSignal createSignal:
                         ^RACDisposable *(id<RACSubscriber> subscriber)
                         {
        [subscriber sendNext:@1];
        [subscriber sendNext:@2];
        [subscriber sendNext:@3];
        [subscriber sendCompleted];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"signal dispose");
        }];
    }];
    RACSignal *bindSignal = [signal bind:^RACStreamBindBlock{
        return ^RACSignal *(NSNumber *value, BOOL *stop){
            value = @(value.integerValue * 2);
            return [RACSignal return:value];
        };
    }];
    
    [bindSignal subscribeNext:^(NSObject *x) {
        NSLog(@"subscribe value = %@", x);
    }];
}

- (void)bind_Complex {
    RACSignal * signalII = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"string"];
        [subscriber sendNext:@3];
        [subscriber sendNext:@"info"];
        [subscriber sendCompleted];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"signalII dispose");
        }];
    }];
    
    RACSignal *bindSignalII = [signalII bind:^RACStreamBindBlock{
        return ^RACSignal *(id value, BOOL *stop) {
            if([value isKindOfClass:[NSString class]]) {
                value = [NSString stringWithFormat:@"%@bind", value];
            } else if([value isKindOfClass:[NSNumber class]]) {
                value = @([value floatValue] * 2);
            }
            return [RACSignal return:value];
        };
    }];
    
    [bindSignalII subscribeNext:^(id x) {
        NSLog(@"bindSignalII %@", x);
    }];
}

- (void)concat {
    NSArray<RACSignal *> * array = [self siganals];
    RACSignal *signal = array.firstObject;
    RACSignal *signals = array.lastObject;
    
    // concat
    NSLog(@"-[concat]");
    RACSignal *contatSignal = [signal concat:signals];
    [contatSignal subscribeNext:^(id x) {
        NSLog(@"subscribe value = %@", x);
    }];
}

- (void)zip {
    NSArray<RACSignal *> * array = [self siganals];
    RACSignal *signal = array.firstObject;
    RACSignal *signals = array.lastObject;
    
    NSLog(@"-[zip]");
    // zip
    RACSignal *zipSignal = [signal zipWith:signals];
    [zipSignal subscribeNext:^(id x) {
        NSLog(@"zip subscribe value = %@", x);
    }];
}

- (void)mapReplace {
    NSArray<RACSignal *> * array = [self siganals];
    RACSignal *signal = array.firstObject;
    NSLog(@"-[mapReplace]-[HA]");
    //mapReplace
    RACSignal *mapReplaceSignal = [signal mapReplace:@"HA"];
    [mapReplaceSignal subscribeNext:^(id x) {
        NSLog(@"mapReplace value = %@", x);
    }];
    
}

- (void)reduceEach {
    RACSignal *tupleSignal = [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
        RACTuple *tuple = [RACTuple tupleWithObjects:@1, @2, nil];
        RACTuple *tuple2 = [RACTuple tupleWithObjectsFromArray:@[@3, @4]];
        [subscriber sendNext:tuple];
        [subscriber sendNext:tuple2];
        [subscriber sendCompleted];
        return nil;
    }];

    RACSignal *reduceEachSignal = [tupleSignal reduceEach:^id(NSNumber *n1, NSNumber *n2) {
        return @([n1 integerValue] * [n2 integerValue]);
    }];

    [reduceEachSignal subscribeNext:^(id x) {
        NSLog(@"reduceSignal = %@", x);
    }];
}

- (void)reduceApply {
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
        id block = ^id(NSNumber *fist, NSNumber *second, NSNumber *third) {
            return @([fist integerValue] * [second integerValue] * [third integerValue]);
        };
        [subscriber sendNext:RACTuplePack(block, @2, @3, @8)];
        [subscriber sendNext:RACTuplePack((id) (^id(NSNumber *x, NSNumber *x1, NSNumber *x2) {
            return @((x.integerValue + x1.integerValue + x2.integerValue) * 10);
        }), @9, @10, @30)];
        [subscriber sendCompleted];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"reduceApply signal dispose");
        }];
    }];
    
    [signal subscribeNext:^(id x) {
        NSLog(@"reduce map before %@", x);
    }];

    RACSignal *reduceSignal = [signal reduceApply];
    [reduceSignal subscribeNext:^(id x) {
        NSLog(@"reduce value = %@", x);
    }];
}

- (void)materialize {
     //materialize
     {
         RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
             [subscriber sendNext:@2];
             NSError *error = [NSError errorWithDomain:@"com.test.t" code:-1 userInfo:@{@"msg": @"error test"}];
             [subscriber sendError:error];
             [subscriber sendCompleted];
             return [RACDisposable disposableWithBlock:^{
                 NSLog(@"materalize dispose");
             }];
         }];

         RACSignal *materialSignal = [signal materialize];

         [materialSignal subscribeNext:^(RACEvent *x) {
             NSLog(@"materalize value = %@", x);
         }];

     }

}

- (void)dematerialize {
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
        [subscriber sendNext:@2];
        NSError *error = [NSError errorWithDomain:@"com.test.t" code:-1 userInfo:@{@"msg": @"error test"}];
        [subscriber sendError:error];
        [subscriber sendCompleted];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"materalize dispose");
        }];
    }];

    RACSignal *materialSignal = [signal materialize];

    [materialSignal subscribeNext:^(RACEvent *x) {
        NSLog(@"materalize value = %@", x);
    }];
    //demetrialize 把 materialize RACEvent信号转为RACSignal正常信号
    RACSignal *dematerialize = [materialSignal dematerialize];
    [dematerialize subscribeNext:^(id x) {
        NSLog(@"demateralize value = %@", x);
    }];
}

- (NSArray<RACSignal *> *)siganals {
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
        [subscriber sendNext:@1];
        [subscriber sendNext:@"a"];
        [subscriber sendNext:@"b"];
        [subscriber sendNext:@"c"];
        [subscriber sendNext:@"c"];
        [subscriber sendNext:@"lastvalue"];
        [subscriber sendCompleted];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"signal dispose");
        }];
    }];
    
    RACSignal *signals = [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
        [subscriber sendNext:@2];
        [subscriber sendNext:@"very good"];
        [subscriber sendNext:@3];
        [subscriber sendNext:@6];
        [subscriber sendCompleted];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"signals dispose");
        }];
    }];
    return @[signal, signals];
}


- (void)not {
    //not
    {
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
            [subscriber sendNext:@1];
            [subscriber sendNext:@0];
            [subscriber sendNext:@YES];
            [subscriber sendNext:@NO];
//            [subscriber sendNext:@"test string"];
            [subscriber sendCompleted];
            return [RACDisposable disposableWithBlock:^{
                NSLog(@"not dispose");
            }];
        }];

        RACSignal *notSignal = [signal not];
        [notSignal subscribeNext:^(id x) {
            NSLog(@"not signal value = %@", x);
        }];
    }

}

- (void)and {
    //and
    {
        int b = 0B0001;
        int e = 07777;
        int h = 0x1952a;
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
            [subscriber sendNext:RACTuplePack(@0B0001, @0B0000)];
//            [subscriber sendNext:RACTuplePack(@3, @6)];
            return [RACDisposable disposableWithBlock:^{
                NSLog(@"and dispose");
            }];
        }];

        RACSignal *and = [signal and];
        [and subscribeNext:^(id x) {
            NSLog(@"and signal value = %@", x);
        }];

        NSLog(@"%zd", 0b0001 & 0b0010);
    }
}

- (void)or {
    //or
    {
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
            [subscriber sendNext:RACTuplePack(@0B0000, @0B0010)];
            [subscriber sendCompleted];
            return [RACDisposable disposableWithBlock:^{
                NSLog(@"or dispose");
            }];
        }];

        RACSignal *orSignal = [signal or];
        [orSignal subscribeNext:^(id x) {
            NSLog(@"or signal value = %@", x);
        }];

        NSLog(@"%zd", 0b0001 | 0b0010);

    }
}

- (void)any {
    // any
    {
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
            [subscriber sendNext:@NO];
//            [subscriber sendNext:@YES];
            [subscriber sendCompleted];
            return nil;
        }];
        RACSignal *anySignal = [signal any];

        [anySignal subscribeNext:^(id x) {
            NSLog(@"any Signal value %@", x);
        }];

        [anySignal repeat];
    }

}

- (void)map {
    //map
    {
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
            [subscriber sendNext:@1];
            [subscriber sendNext:@2];
            [subscriber sendCompleted];
            return nil;
        }];

        RACSignal *mapSiganl = [signal map:^id(id value) {
            NSString *string = [NSString stringWithFormat:@"%@~~~ha", value];
            return string;
        }];

        [mapSiganl subscribeNext:^(id x) {
            NSLog(@"map Signal value = %@", x);
        }];
    }

}

- (void)filter {
    //filter
    {
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
            [subscriber sendNext:@1];
            [subscriber sendNext:@2];
            [subscriber sendNext:@3];
            [subscriber sendNext:@4];
            [subscriber sendNext:@5];
            [subscriber sendNext:@6];
            [subscriber sendNext:@7];
            [subscriber sendCompleted];
            return nil;
        }];

        RACSignal *filterSignal = [signal filter:^BOOL(id value) {
            return [value intValue] % 2;
        }];

        [filterSignal subscribeNext:^(id x) {
            NSLog(@"filter signal value = %@", x);
        }];
    }

}

- (void)flatten {
    //flatten
    {

        RACSignal *signal1 = [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
            [subscriber sendNext:@1];
            [subscriber sendNext:@2];
            [subscriber sendNext:@3];
            [subscriber sendNext:@4];
            [subscriber sendNext:@5];
            [subscriber sendNext:@6];
            [subscriber sendNext:@7];
            [subscriber sendCompleted];
            return nil;
        }];
        RACSignal *signal2 = [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
            [subscriber sendNext:@"a"];
            [subscriber sendNext:@"b"];
            [subscriber sendNext:@"c"];
            [subscriber sendNext:@"d"];
            [subscriber sendCompleted];
            return nil;
        }];
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
            [subscriber sendNext:signal1];
            [subscriber sendNext:signal2];
            [subscriber sendNext:signal1];
            [subscriber sendNext:signal2];
            [subscriber sendCompleted];
            return nil;
        }];

        RACSignal *flattenSignal = [signal flatten:1];

        [flattenSignal subscribeNext:^(id x) {
            NSLog(@"A:flatten Signal value = %@", x);
        }];

        [flattenSignal subscribeNext:^(id x) {
            NSLog(@"B:flatten Signal value = %@", x);
        }];
    }
}

- (void)switchToLatest {
    //switchToLatest
    {
        RACSignal *s = [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
            [subscriber sendNext:@"hello"];
            [subscriber sendCompleted];
            return nil;
        }];
        RACSignal *s2 = [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
            [subscriber sendNext:@"hello2"];
            [subscriber sendCompleted];
            return nil;
        }];

        RACSignal *s3 = [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
            [subscriber sendNext:s];
            [subscriber sendCompleted];
            return nil;
        }];
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
            [subscriber sendNext:s];
            [subscriber sendNext:s2];
            [subscriber sendNext:s3];
            [subscriber sendCompleted];
            return nil;
        }];

        [[signal switchToLatest] subscribeNext:^(id x) {
            NSLog(@"switchToLatest signal value = %@", x);
        }];
    }
}

- (void)switchCasesDefault {
    {

//        int a;
//        switch (a) {
//            case 1: {
//            }
//                break;
//        }

        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
            [subscriber sendNext:@4];
            [subscriber sendCompleted];
            return nil;
        }];

        RACSignal *caseSignal = [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
            [subscriber sendNext:@2];
            [subscriber sendCompleted];
            return nil;
        }];

        RACSignal *caseSignal2 = [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
            [subscriber sendNext:@3];
            [subscriber sendCompleted];
            return nil;
        }];

        RACSignal *caseSignal3 = [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
            [subscriber sendNext:@4];
            [subscriber sendCompleted];
            return nil;
        }];


        RACSignal *caseSignal4 = [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
            RACSignal *s = [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
                [subscriber sendNext:@"hello cases"];
                [subscriber sendCompleted];
                return nil;
            }];
            [subscriber sendNext:s];
            [subscriber sendCompleted];
            return nil;
        }];
        RACSignal *resultSignal = [RACSignal switch:signal cases:@{@1: caseSignal, @2: caseSignal2, @3: caseSignal3, @4: caseSignal4} default:nil];
        [resultSignal subscribeNext:^(id x) {
            if ([x isKindOfClass:[RACSignal class]]) {
                [(RACSignal *) x subscribeNext:^(id x) {
                    NSLog(@"switch cases default sub: value = %@", x);
                }];
            } else {
                NSLog(@"switch cases default value = %@", x);
            }
        }];
    }

}

- (void)ifThenElse {
    //if then else
    {
        RACSignal *boolSignal = [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
            [subscriber sendNext:@NO];
            [subscriber sendCompleted];
            return nil;
        }];
        RACSignal *trueSignal = [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
            [subscriber sendNext:@"true signal"];
            [subscriber sendCompleted];
            return nil;
        }];
        RACSignal *falseSignal = [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
            [subscriber sendNext:@"false signal"];
            [subscriber sendCompleted];
            return nil;
        }];
        RACSignal *signal = [RACSignal if:boolSignal then:trueSignal else:falseSignal];
        [signal subscribeNext:^(id x) {
            NSLog(@"if/then/else signal value = %@", x);
        }];
    }

}

- (void)relyon {
    NSLog(@"relyon");
    {
        
        RACSignal * signalA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:@{@"a": @"b"}];
            [subscriber sendCompleted];
            return  nil;
        }];
        
        RACSignal *signalB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:@{@"c": @"d"}];
            [subscriber sendCompleted];
            return nil;
        }];
        
        RACSignal *signal = [signalA zipWith:signalB];
        
        [signal subscribeNext:^(id x) {
            RACTuple * tuple = x;
            NSLog(@"%@", tuple.first);
            NSLog(@"%@", tuple.second);
        }];
    }
    
    {
        
        RACSignal * signalA = [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:@{@"a": @"b"}];
            [subscriber sendCompleted];
            return  nil;
        }] map:^id(id value) {
            NSLog(@"%@", value);
            return nil;
        }];
        
        
        RACSignal *signalB = [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:@{@"c": @"d"}];
            [subscriber sendCompleted];
            return nil;
        }] map:^id(id value) {
            NSLog(@"%@", value);
            return nil;
        }];
        
        RACSignal *signal = [signalA zipWith:signalB];
        
        [signal subscribeNext:^(id x) {
            RACTuple * tuple = x;
            NSLog(@"%@", tuple.first);
            NSLog(@"%@", tuple.second);
        }];
    }
    
    
}

- (RACTestDataVM *)dataVM {
    if (!_dataVM) {
        _dataVM = [RACTestDataVM new];
    }
    return _dataVM;
}

@end
