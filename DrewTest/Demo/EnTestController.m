//
//  EnTestController.m
//  DrewTest
//
//  Created by majiancheng on 2017/10/19.
//  Copyright © 2017年 waqu. All rights reserved.
//

#import "EnTestController.h"
#import "NSString+MD5.h"

#import <CommonCrypto/CommonCryptor.h>

@interface EnTestController ()

@property(nonatomic, strong) NSArray *base;

@end

@implementation EnTestController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *a = @"ahqLk70IvHN5JJzzvMuE5LIxJMfgzjeaipYJwnNt8JiPVjubR8l6xN0wAjwlDJi=";
    long timeMillis = 1508412403282L;
    NSLog(@"[4][end]%@", [self encode:@"and" sid:@"bdd6b4f1efdad1eef835356981906db9" appName:@"sharbay" appVersion:@"5.8.0" time:timeMillis key:a]);
//    NSLog(@"[4][end]%@", [self encode:@"and" sid:@"bdd6b4f1efdad1eef835356981906db9" appName:@"sharbay" appVersion:@"5.8.0" time:timeMillis key:a]);
//    NSLog(@"[4][end]%@", [self encode:@"and" sid:@"bdd6b4f1efdad1eef835356981906db9" appName:@"sharbay" appVersion:@"5.8.0" time:timeMillis key:a]);
//    NSLog(@"[4][end]%@", [self encode:@"and" sid:@"bdd6b4f1efdad1eef835356981906db9" appName:@"sharbay" appVersion:@"5.8.0" time:timeMillis key:a]);

    [self testA];
}

- (NSString *)encode:(NSString *)platform sid:(NSString *)sid appName:(NSString *)appName appVersion:(NSString *)appVersion time:(long)timeMillis key:(NSString *)key {
    NSString *so = [NSString stringWithFormat:@"platform='%@'&sid='%@'&appName='%@'&appVersion='%@'&timeMillis='%ld'&", platform, sid, appName, appVersion, timeMillis];
    NSLog(@"[1][comb]%@", so);
    NSString *des = so;
    NSLog(@"[2][des]%@", des);

    return [self condense:so];
}

- (void)testA {
    NSLog(@"[4][end]%@", [self condense:@"aa"]);
}


- (NSString *)encryptDES:(NSString *)plainText key:(NSString *)key {
    NSString *ciphertext = nil;
    NSData *textData = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [textData length];
    unsigned char buffer[1024 * 15];
    memset(buffer, 0, sizeof(char));
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
            kCCOptionPKCS7Padding,
            [key UTF8String], kCCKeySizeDES,
            nil,
            [textData bytes], dataLength,
            buffer, 1024 * 15,
            &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger) numBytesEncrypted];
        //         ciphertext = [GTMBase64 stringByEncodingData:data];
        ciphertext = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    }
    return ciphertext;
}


- (NSString *)condense:(NSString *)desStr {
    NSMutableString *mutableString = [NSMutableString new];
    char md5[16];
    [desStr md5Origin:md5];
   
    NSLog(@"[3][md5]%@", [NSString stringWithCharacters:md5 length:16]);
    for (int index = 0; index < 16; index++) {
        int cha = md5[index];
        int vo = (cha & 0xff);
        NSInteger idx = (int) vo % self.base.count;
        [mutableString appendString:self.base[idx]];
    }
    return mutableString;
}

- (NSArray *)base {
    if (!_base) {
        _base = @[@"a", @"b", @"c", @"d", @"e", @"f", @"g", @"h", @"i", @"j", @"k", @"l", @"m", @"n", @"o", @"p", @"q", @"r", @"s", @"t", @"u", @"v", @"w", @"x", @"y", @"z",
                @"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9",
                @"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z"];
    }
    return _base;
}


@end
