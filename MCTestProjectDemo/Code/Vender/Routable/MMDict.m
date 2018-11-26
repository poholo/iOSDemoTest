//
// Created by 赵江明 on 16/4/29.
// Copyright (c) 2016 GymChina inc. All rights reserved.
//


#import "MMDict.h"

NSString *const ROUTE_DTO = @"route_dto";


@interface MMDict ()

@property(nonatomic, strong) NSMutableDictionary *mmMap;

@end

@implementation MMDict

- (instancetype)init {
    self = [super init];
    if (self) {
        self.mmMap = [NSMutableDictionary new];
    }

    return self;
}


- (BOOL)hasKey:(NSString *)key {
    if (key == nil || [key isEqual:[NSNull null]]) {
        return NO;
    }

    return self.mmMap[key] != nil;
}

- (id)objForKey:(NSString *)key {
    if (key == nil || [key isEqual:[NSNull null]]) {
        return nil;
    }

    return self.mmMap[key];
}

- (NSString *)stringForKey:(id)key {
    id value = self.mmMap[key];
    if (value == nil || [value isEqual:[NSNull null]]) {
        return nil;
    }
    if ([[value description] isEqualToString:@"(null)"]) {
        return nil;
    }
    if ([value isKindOfClass:[NSString class]]) {
        return (NSString *) value;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value stringValue];
    }

    return nil;
}

- (NSNumber *)numberForKey:(id)key {
    if (key == nil || [key isEqual:[NSNull null]]) {
        return nil;
    }

    id value = self.mmMap[key];
    if ([value isKindOfClass:[NSNumber class]]) {
        return (NSNumber *) value;
    }
    if ([value isKindOfClass:[NSString class]]) {
        NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        return [f numberFromString:(NSString *) value];
    }
    return nil;
}

- (NSDecimalNumber *)decimalNumberForKey:(id)key {
    if (key == nil || [key isEqual:[NSNull null]]) {
        return nil;
    }

    id value = self.mmMap[key];
    if ([value isKindOfClass:[NSDecimalNumber class]]) {
        return value;
    } else if ([value isKindOfClass:[NSNumber class]]) {
        NSNumber *number = (NSNumber *) value;
        return [NSDecimalNumber decimalNumberWithDecimal:[number decimalValue]];
    } else if ([value isKindOfClass:[NSString class]]) {
        NSString *str = (NSString *) value;
        return [str isEqualToString:@""] ? nil : [NSDecimalNumber decimalNumberWithString:str];
    }
    return nil;
}


- (NSArray *)arrayForKey:(id)key {
    if (key == nil || [key isEqual:[NSNull null]]) {
        return nil;
    }

    id value = self.mmMap[key];
    if (value == nil || value == [NSNull null]) {
        return nil;
    }
    if ([value isKindOfClass:[NSArray class]]) {
        return value;
    }
    return nil;
}

- (NSDictionary *)dictionaryForKey:(id)key {
    if (key == nil || [key isEqual:[NSNull null]]) {
        return nil;
    }

    id value = self.mmMap[key];
    if (value == nil || value == [NSNull null]) {
        return nil;
    }
    if ([value isKindOfClass:[NSDictionary class]]) {
        return value;
    }
    return nil;
}

- (NSInteger)integerForKey:(id)key {
    if (key == nil || [key isEqual:[NSNull null]]) {
        return 0;
    }

    id value = self.mmMap[key];
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        return [value integerValue];
    }
    return 0;
}

- (NSUInteger)unsignedIntegerForKey:(id)key {
    if (key == nil || [key isEqual:[NSNull null]]) {
        return 0;
    }

    id value = self.mmMap[key];
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        return [value unsignedIntegerValue];
    }
    return 0;
}

- (BOOL)boolForKey:(id)key {
    if (key == nil || [key isEqual:[NSNull null]]) {
        return NO;
    }

    id value = self.mmMap[key];
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value boolValue];
    }
    if ([value isKindOfClass:[NSString class]]) {
        return [value boolValue];
    }
    return NO;
}

- (int16_t)int16ForKey:(id)key {
    if (key == nil || [key isEqual:[NSNull null]]) {
        return 0;
    }

    id value = self.mmMap[key];
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value shortValue];
    }
    if ([value isKindOfClass:[NSString class]]) {
        return [value intValue];
    }
    return 0;
}

- (int32_t)int32ForKey:(id)key {

    if (key == nil || [key isEqual:[NSNull null]]) {
        return 0;
    }

    id value = self.mmMap[key];
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value intValue];
    }
    return 0;
}

- (int64_t)int64ForKey:(id)key {

    if (key == nil || [key isEqual:[NSNull null]]) {
        return 0;
    }

    id value = self.mmMap[key];
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value longLongValue];
    }
    return 0;
}

- (char)charForKey:(id)key {
    if (key == nil || [key isEqual:[NSNull null]]) {
        return 0;
    }

    id value = self.mmMap[key];
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value charValue];
    }
    return 0;
}

- (short)shortForKey:(id)key {
    if (key == nil || [key isEqual:[NSNull null]]) {
        return 0;
    }

    id value = self.mmMap[key];
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value shortValue];
    }
    if ([value isKindOfClass:[NSString class]]) {
        return [value intValue];
    }
    return 0;
}

- (float)floatForKey:(id)key {
    if (key == nil || [key isEqual:[NSNull null]]) {
        return 0;
    }

    id value = self.mmMap[key];
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value floatValue];
    }
    return 0;
}

- (double)doubleForKey:(id)key {
    if (key == nil || [key isEqual:[NSNull null]]) {
        return 0;
    }

    id value = self.mmMap[key];
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value doubleValue];
    }
    return 0;
}

- (long long)longLongForKey:(id)key {
    if (key == nil || [key isEqual:[NSNull null]]) {
        return 0;
    }

    id value = self.mmMap[key];
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        return [value longLongValue];
    }

    return 0;
}

- (unsigned long long)unsignedLongLongForKey:(id)key {
    if (key == nil || [key isEqual:[NSNull null]]) {
        return 0;
    }

    id value = self.mmMap[key];
    if ([value isKindOfClass:[NSString class]]) {
        NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
        value = [nf numberFromString:value];
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value unsignedLongLongValue];
    }
    return 0;
}

- (NSDate *)dateForKey:(id)key dateFormat:(NSString *)dateFormat {
    if (key == nil || [key isEqual:[NSNull null]]) {
        return nil;
    }

    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    formater.dateFormat = dateFormat;
    id value = self.mmMap[key];

    if (value == nil || value == [NSNull null]) {
        return nil;
    }

    if ([value isKindOfClass:[NSString class]] && ![value isEqualToString:@""] && !dateFormat) {
        return [formater dateFromString:value];
    }
    return nil;
}


//CG
- (CGFloat)CGFloatForKey:(id)key {
    if (key == nil || [key isEqual:[NSNull null]]) {
        return 0.0f;
    }

    CGFloat f = [self.mmMap[key] floatValue];
    return f;
}

- (CGPoint)pointForKey:(id)key {
    if (key == nil || [key isEqual:[NSNull null]]) {
        return CGPointZero;
    }

    CGPoint point = CGPointFromString(self.mmMap[key]);
    return point;
}

- (CGSize)sizeForKey:(id)key {
    if (key == nil || [key isEqual:[NSNull null]]) {
        return CGSizeZero;
    }

    CGSize size = CGSizeFromString(self.mmMap[key]);
    return size;
}

- (CGRect)rectForKey:(id)key {
    if (key == nil || [key isEqual:[NSNull null]]) {
        return CGRectZero;
    }

    CGRect rect = CGRectFromString(self.mmMap[key]);
    return rect;
}

#pragma --mark setter

- (void)addEntriesFromDictionary:(MMDict *)mmDict {
    if (mmDict != nil && mmDict.mmMap != nil) {
        [self.mmMap addEntriesFromDictionary:mmDict.mmMap];
    }
}

- (void)setObj:(id)i forKey:(NSString *)key {
    if (key == nil || [key isEqual:[NSNull null]]) {
        return;
    }

    if (i != nil) {
        self.mmMap[key] = i;
    }
}

- (void)setString:(NSString *)i forKey:(NSString *)key {
    if (key == nil || [key isEqual:[NSNull null]]) {
        return;
    }

    [self.mmMap setValue:i forKey:key];
}

- (void)setBool:(BOOL)i forKey:(NSString *)key {
    if (key == nil || [key isEqual:[NSNull null]]) {
        return;
    }

    self.mmMap[key] = @(i);
}

- (void)setInt:(int)i forKey:(NSString *)key {
    if (key == nil || [key isEqual:[NSNull null]]) {
        return;
    }

    self.mmMap[key] = @(i);
}

- (void)setInteger:(NSInteger)i forKey:(NSString *)key {
    if (key == nil || [key isEqual:[NSNull null]]) {
        return;
    }

    self.mmMap[key] = @(i);
}

- (void)setUnsignedInteger:(NSUInteger)i forKey:(NSString *)key {
    if (key == nil || [key isEqual:[NSNull null]]) {
        return;
    }

    self.mmMap[key] = @(i);
}

- (void)setCGFloat:(CGFloat)f forKey:(NSString *)key {
    if (key == nil || [key isEqual:[NSNull null]]) {
        return;
    }

    self.mmMap[key] = @(f);
}

- (void)setChar:(char)c forKey:(NSString *)key {
    if (key == nil || [key isEqual:[NSNull null]]) {
        return;
    }

    self.mmMap[key] = @(c);
}

- (void)setFloat:(float)i forKey:(NSString *)key {
    if (key == nil || [key isEqual:[NSNull null]]) {
        return;
    }

    self.mmMap[key] = @(i);
}

- (void)setDouble:(double)i forKey:(NSString *)key {
    if (key == nil || [key isEqual:[NSNull null]]) {
        return;
    }

    self.mmMap[key] = @(i);
}

- (void)setLongLong:(long long)i forKey:(NSString *)key {
    if (key == nil || [key isEqual:[NSNull null]]) {
        return;
    }

    self.mmMap[key] = @(i);
}

- (void)setPoint:(CGPoint)o forKey:(NSString *)key {
    if (key == nil || [key isEqual:[NSNull null]]) {
        return;
    }

    self.mmMap[key] = NSStringFromCGPoint(o);
}

- (void)setSize:(CGSize)o forKey:(NSString *)key {
    if (key == nil || [key isEqual:[NSNull null]]) {
        return;
    }

    self.mmMap[key] = NSStringFromCGSize(o);
}

- (void)setRect:(CGRect)o forKey:(NSString *)key {
    if (key == nil || [key isEqual:[NSNull null]]) {
        return;
    }

    self.mmMap[key] = NSStringFromCGRect(o);
}

@end
