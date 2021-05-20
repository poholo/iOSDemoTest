//
//  MethodInvocationDto.m
//  MCTestProjectDemo
//
//  Created by Ma Jiancheng on 2021/5/20.
//  Copyright © 2021 mjc. All rights reserved.
//

#import "MethodInvocationDto.h"

#import <objc/runtime.h>


void instanceTest(id self, SEL sel) {
    NSLog(@"instanceTest:%@ %s", self, sel_getName(sel));
}

void cx_clsMethod(id self, SEL sel) {
    NSLog(@"out cx_clsMethod");
}

@interface MethodForwarding : NSObject

- (void)test;

@end

@implementation MethodForwarding

- (void)test {
    NSLog(@"%@ %s", NSStringFromClass(self.class), _cmd);
}

@end


@interface MethodInvocation : NSObject

- (void)test;

@end

@implementation MethodInvocation

- (void)test {
    NSLog(@"%@ %s", NSStringFromClass(self.class), _cmd);
}

@end

@implementation MethodInvocationDto

- (void)instanceTestM2 {
    NSLog(@"test forwarding -> instanceTestM2");
}

//2
- (id)forwardingTargetForSelector:(SEL)aSelector {
    NSLog(@"%s", _cmd);
//    if(aSelector == @selector(test)) {
//        return [MethodForwarding new];
//    }
    return [super forwardingTargetForSelector:aSelector];
}
//1
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    NSLog(@"%s", _cmd);
//    if(sel == @selector(test)) {
//        class_addMethod(self, sel, (IMP)instanceTest, "v@:");
//        return YES;
//    }
    
    //resolveClassMethod
    if (sel == @selector(cx_classTest)) {
        class_addMethod(self, sel, (IMP)cx_clsMethod, "v@:");
        return  [super resolveInstanceMethod:sel];
    }
    return [super resolveInstanceMethod:sel];
}

//c1
+ (BOOL)resolveClassMethod:(SEL)sel {
    //https://blog.csdn.net/qq_24656927/article/details/86529863
    NSLog(@"%s", _cmd);
    if(sel == @selector(classTest)) {
        Class cls = objc_getClass(NSStringFromClass(self).UTF8String);
        Class cls2 = self.class;
        IMP impPoint = class_getMethodImplementation(cls, @selector(cx_classTest));
        Method clsMethod = class_getClassMethod(cls, @selector(cx_classTest));
        const char *encoding = method_getTypeEncoding(clsMethod);
        class_addMethod(cls, @selector(cx_classTest), impPoint, encoding);
        return YES;
    }
    return [super resolveClassMethod:sel];
}

+ (void)cx_classTest {
    NSLog(@"class cx_test");
}

//
- (void)testMethodSignature {
    NSLog(@"testMethodSignature");
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSLog(@"%s", _cmd);
    if(aSelector == @selector(test)) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    NSLog(@"%s", _cmd);
    SEL sel = anInvocation.selector;
    if (sel == @selector(test)) {
        [anInvocation invokeWithTarget:[MethodInvocation new]];
    } else {
        [super forwardInvocation:anInvocation];
    }
}
@end
