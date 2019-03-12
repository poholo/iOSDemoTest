//
//  MCIAPPayHelper.m
//  WaQuVideo
//
//  Created by gdb-work on 16/5/10.
//  Copyright © 2016年 SunYuanYang. All rights reserved.
//

#import "MCIAPPayHelper.h"

#import <ReactiveCocoa.h>
#import <StoreKit/StoreKit.h>

#import "MCPayProtocol.h"
#import "PayDto.h"
#import "HUDView.h"
#import "ToastUtils.h"


NSString *const ERROR_DOMAIM = @"www.waqu.com";
NSString *const ERROR_MESSAGE = @"error_message";
NSString *const ERROR_OBJECT = @"error_object";
NSString *const ERROR_403 = @"error_403";


#define ARRAY_SIZE(a) sizeof(a)/sizeof(a[0])

const char *jailbreak_tool_pathes[] = {
    "/Applications/Cydia.app",
    "/Library/MobileSubstrate/MobileSubstrate.dylib",
    "/bin/bash",
    "/usr/sbin/sshd",
    "/etc/apt"
};

@interface MCIAPPayHelper () <SKProductsRequestDelegate, UIAlertViewDelegate, SKPaymentTransactionObserver>

@property(nonatomic, copy) MCProcessCallback processCallBack;
@property(nonatomic, strong) PayDto *payDto;

@property(nonatomic, assign) BOOL inPurchase;

@end

@implementation MCIAPPayHelper

- (void)dealloc {
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    }
    
    return self;
}


+ (BOOL)isJailBreak {
    for (int i = 0; i < ARRAY_SIZE(jailbreak_tool_pathes); i++) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithUTF8String:jailbreak_tool_pathes[i]]]) {
            NSLog(@"The device is jail broken!");
            return YES;
        }
    }
    NSLog(@"The device is NOT jail broken!");
    return NO;
}

- (void)startBuyProduct:(NSString *)productId payType:(NSString *)payType callBack:(MCProcessCallback)callBack {
    if ([MCIAPPayHelper isJailBreak]) {
        if (callBack) {
            callBack(NO, @"JailBreak");
        }
        return;
    }
    self.payDto = nil;
    self.payDto.productId = productId;
    self.processCallBack = callBack;
    [HUDView show];
#if DEBUG
    SKProductsRequest *productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:self.payDto.productId]];
    productsRequest.delegate = self;
    [productsRequest start];
#else
    @weakify(self);
    RACSignal *signal = nil;//[self createOrder:self.payDto.productId payType:@"iap"];
    [signal subscribeNext:^(NSDictionary *dict) {
        @strongify(self);
        [HUDView dismiss];
        NSArray *transactions = [SKPaymentQueue defaultQueue].transactions;
        if (transactions.count > 0) {
            //检测是否有未完成的交易
            SKPaymentTransaction *transaction = [transactions firstObject];
            [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
        }
        
        self.payDto.requestId = dict[@"requestId"];
        self.payDto.orderId = dict[@"orderId"];
        if (![SKPaymentQueue canMakePayments]) {
            if (self.processCallBack) {
                self.processCallBack(NO, @"this device is not able or allowed to make payments");
            }
            return;
        }
        
        if (self.payDto.requestId.length == 0 || self.payDto.orderId.length == 0) {
            if (self.processCallBack) {
                self.processCallBack(NO, @"request or orderId == NULL");
            }
            return;
        }
        
        [HUDView show];
        SKProductsRequest *productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:self.payDto.productId]];
        productsRequest.delegate = self;
        [productsRequest start];
    }               error:^(NSError *error) {
        @strongify(self);
        [HUDView dismiss];
        if ([error.domain isEqualToString:ERROR_DOMAIM]) {
            [ToastUtils showTopTitle:error.userInfo[ERROR_MESSAGE]];
        } else {
            [ToastUtils showTopTitle:@"请求失败"];
        }
        if (self.processCallBack) {
            self.processCallBack(NO, error.userInfo[ERROR_MESSAGE]);
        }
    }];
#endif
}

- (void)processBuyProductStatus:(NSURL *)url callBack:(MCProcessCallback)callBack {
    
}

#pragma mark -
#pragma mark SKPaymentTransactionObserver

- (void)paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue {
    
}

- (void)paymentQueue:(SKPaymentQueue *)queue restoreCompletedTransactionsFailedWithError:(NSError *)error {
    
}

#pragma mark SKProductsRequestDelegate

//请求失败
- (void)request:(SKRequest *)request didFailWithError:(NSError *)error {
    [HUDView dismiss];
    if (self.processCallBack) {
        self.processCallBack(NO, error.domain);
    }
    NSLog(@"%@", error);
}

- (void)requestDidFinish:(SKRequest *)request {
    
}

//请求成功
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    SKProduct *skproduct = [[response products] lastObject];
    [HUDView dismiss];
    if (!skproduct) {
        if (self.processCallBack) {
            self.processCallBack(NO, @"商品列表中无此商品");
        }
    } else {
        [HUDView show];
        SKPayment *payment = [SKPayment paymentWithProduct:skproduct];
        [[SKPaymentQueue defaultQueue] addPayment:payment];
    }
}

//交易回调
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions {
    [HUDView dismiss];
    for (SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchased: {
                if (self.inPurchase) {
                    [self completePurchaseTransaction:transaction];
                } else {
                    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                }
                break;
            }
                
            case SKPaymentTransactionStateRestored: {
                [self completePurchaseTransaction:transaction];
                break;
            }
                
            case SKPaymentTransactionStateFailed: {
                [self handelFailedTransaction:transaction];
                break;
            }
                
            case SKPaymentTransactionStatePurchasing: {
                self.inPurchase = YES;
                break;
            }
            default:
                break;
        }
    }
}

#pragma mark -
#pragma mark SKPaymentTrasactionObserver

- (void)paymentQueue:(SKPaymentQueue *)queue removedTransactions:(NSArray *)transactions {
    
}

//完成购买交易
- (void)completePurchaseTransaction:(SKPaymentTransaction *)transaction {
    //    GOrder *globalOrder = [GOrder new];
    //    globalOrder.entityId = self.orderId;
    //    globalOrder.requestId = self.requestId;
    //    globalOrder.userId = [UserSession share].user.entityId;
    //    globalOrder.type = self.orderType;
    //    [globalOrder MMPersistence];
    
    [self appStoreReciept];
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

- (void)appStoreReciept {
    NSData *receiptData = [NSData dataWithContentsOfURL:[[NSBundle mainBundle] appStoreReceiptURL]];
    //    GOrder *globalOrder = (GOrder *) [GOrder MMFindEntityById:self.orderId];
    NSString *receipt = nil;//[receiptData base64EncodedString];
    //    globalOrder.receipt = receipt;
    //    [globalOrder MMPersistence];
    [self requestVerifyReceipt:receipt];
}

- (void)requestVerifyReceipt:(NSString *)receipt {
    @weakify(self);
    RACSignal *racSignal = nil; //[self verifyReceipt:receipt orderId:self.orderId requestId:self.requestId Uid:[UserSession share].user.entityId];
    [racSignal subscribeNext:^(NSDictionary *dict) {
        @strongify(self);
        if ([dict[@"paySuccess"] boolValue]) {
            if (self.processCallBack) {
                self.processCallBack(YES, nil);
            }
            //            [GOrder MMRemoveById:self.orderId];
        } else {
            [ToastUtils showOnTabTopTitle:@"网络连接超时"];
            if (self.processCallBack) {
                self.processCallBack(NO, @"验证票据失败");
            }
        }
        [HUDView dismiss];
    }                  error:^(NSError *error) {
        @strongify(self);
        if (self.processCallBack) {
            self.processCallBack(NO, @"验证票据网络失败");
        }
        [HUDView dismiss];
    }];
}


//交易失败
- (void)handelFailedTransaction:(SKPaymentTransaction *)transaction {
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    NSString *error = [NSString stringWithFormat:@"本次购买失败。原因：%@%@", @(transaction.error.code), transaction.error.description];
    
    NSLog(@"handelFailedTransaction %@", error);
    NSLog(@"handelFailedTransaction error.code %@", @(transaction.error.code));
    
    if (transaction.error.code != SKErrorPaymentCancelled) {
        if (self.processCallBack) {
            self.processCallBack(NO, @"购买失败");
        }
    } else {
        self.processCallBack(NO, @"取消购买");
    }
    [HUDView dismiss];
}

+ (void)checkOrderErrorsWithType:(NSString *)type {
    //    NSMutableArray *orderList = [GOrder MMFindAll];
    //    for (GOrder *globalOrder in orderList) {
    //        if ([globalOrder.type isEqualToString:type]) {
    //            [[self class] requestOrder:globalOrder];
    //        }
    //    }
}


+ (BOOL)hasOrderErrorsWithType:(NSString *)type {
    NSMutableArray *orderList = [NSMutableArray array];
    //    for (GOrder *globalOrder in [GOrder MMFindAll]) {
    //        if ([globalOrder.type isEqualToString:type]) {
    //            [orderList addObject:globalOrder];
    //        }
    //    }
    return orderList.count > 0;
}

+ (void)checkOrderErrors {
    //    NSMutableArray *orderList = [GOrder MMFindAll];
    //    for (GOrder *globalOrder in orderList) {
    //        [[self class] requestOrder:globalOrder];
    //    }
}


//+ (void)requestOrder:(GOrder *)globalOrder {
//    if ([StringUtils hasText:globalOrder.receipt] && globalOrder.userId && globalOrder.requestId) {
//
//        RACSignal *racSignal = [self verifyReceipt:globalOrder.receipt orderId:globalOrder.entityId requestId:globalOrder.requestId Uid:globalOrder.userId];
//        [racSignal subscribeNext:^(NSDictionary *dict) {
//            if ([dict[@"paySuccess"] boolValue]) {
//                [GOrder MMRemoveById:globalOrder.entityId];
//                NSDictionary *object = @{@"wadiamond" : [NSString stringWithFormat:@"%@", dict[@"wadiamond"]], @"wacoin" : [NSString stringWithFormat:@"%@", dict[@"waCoinCount"]]};
//                [UserSession share].user.level = dict[@"level"]? @([dict[@"level"] integerValue]) :[UserSession share].user.level;
//                [[NSNotificationCenter defaultCenter] postNotificationName:@"requestOrder" object:object];
//            }
//        }                  error:^(NSError *error) {
//        }];
//    } else {
//        @weakify(self);
//        NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:[[NSBundle mainBundle] appStoreReceiptURL] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//            @strongify(self);
//            if (!error && data) {
//                NSString *receipt = [data base64EncodedString];
//                globalOrder.receipt = receipt;
//                [globalOrder MMPersistence];
//
//                [self requestOrder:globalOrder];
//            }
//        }];
//        [dataTask resume];
//    }
//}

- (PayDto *)payDto {
    if(!_payDto) {
        _payDto = [PayDto new];
    }
    return _payDto;
}

@end
