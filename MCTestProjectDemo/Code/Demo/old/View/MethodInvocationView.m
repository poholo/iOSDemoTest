//
//  MethodInvocationView.m
//  MCTestProjectDemo
//
//  Created by Ma Jiancheng on 2021/5/20.
//  Copyright © 2021 mjc. All rights reserved.
//

#import "MethodInvocationView.h"

#import "MethodInvocationMsgCell.h"
#import "MethodInvocationDataVM.h"
#import "MethodInvocationDto.h"

@interface MethodInvocationView() <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation MethodInvocationView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.table registerNib:[UINib nibWithNibName:[MethodInvocationMsgCell identifier] bundle:nil] forCellReuseIdentifier:[MethodInvocationMsgCell identifier]];
    self.table.estimatedRowHeight = 44;
}

- (IBAction)instanceInvocationClick:(id)sender {
//    [self.dataVM.dto performSelector:@selector(test)];
    [self.dataVM.dataList removeAllObjects];
    [self.dataVM.dataList addObjectsFromArray:@[
        @"thread #1, queue = 'com.apple.main-thread', stop reason = signal SIGABRT",
        @"libsystem_kernel.dylib`__pthread_kill + 8",
        @"libsystem_pthread.dylib`pthread_kill + 212",
        @"libsystem_c.dylib`abort + 100",
        @"libc++abi.dylib`abort_message + 128",
        @"libc++abi.dylib`demangling_terminate_handler() + 296",
        @"libobjc.A.dylib`_objc_terminate() + 124",
        @"libc++abi.dylib`std::__terminate(void (*)()) + 16",
        @"libc++abi.dylib`__cxa_rethrow + 144",
        @"libobjc.A.dylib`objc_exception_rethrow + 40",
        @"CoreFoundation`CFRunLoopRunSpecific + 808",
        @"GraphicsServices`GSEventRunModal + 160",
        @"UIKitCore`-[UIApplication _run] + 1052",
        @"UIKitCore`UIApplicationMain + 164",
        @"MCTestProjectDemo`main(argc=1, argv=0x000000016f8a7878) at main.m:14:16",
        @"libdyld.dylib`start + 4",
    ]];
    [self.table reloadData];
}

- (IBAction)classInvocationClick:(id)sender {
//    [MethodInvocationDto performSelector:@selector(test1)];
    [self.dataVM.dataList removeAllObjects];
    [self.dataVM.dataList addObjectsFromArray:@[
    
        @"CoreFoundation`+[NSObject(NSObject) doesNotRecognizeSelector:] + 140",
        @"CoreFoundation`___forwarding___ + 1440",
        @"CoreFoundation`_CF_forwarding_prep_0 + 92",
        @"MCTestProjectDemo`-[MethodInvocationView classInvocationClick:](self=0x0000000158a0ae00, _cmd='classInvocationClick:', sender=0x0000000158a0b660) at MethodInvocationView.m:35:5",
        @"UIKitCore`-[UIApplication sendAction:to:from:forEvent:] + 96",
        @"UIKitCore`-[UIControl sendAction:to:forEvent:] + 240",
        @"UIKitCore`-[UIControl _sendActionsForEvents:withEvent:] + 352",
        @"UIKitCore`-[UIControl touchesEnded:withEvent:] + 532",
        @"UIKitCore`-[UIWindow _sendTouchesForEvent:] + 1244",
        @"UIKitCore`-[UIWindow sendEvent:] + 3824",
        @"UIKitCore`-[UIApplication sendEvent:] + 744",
        @"UIKitCore`__dispatchPreprocessedEventFromEventQueue + 1032",
        @"UIKitCore`__processEventQueue + 6440",
        @"UIKitCore`__eventFetcherSourceCallback + 156",
        @"CoreFoundation`__CFRUNLOOP_IS_CALLING_OUT_TO_A_SOURCE0_PERFORM_FUNCTION__ + 24",
        @"CoreFoundation`__CFRunLoopDoSource0 + 204",
        @"CoreFoundation`__CFRunLoopDoSources0 + 256",
        @"CoreFoundation`__CFRunLoopRun + 776",
        @"CoreFoundation`CFRunLoopRunSpecific + 572",
        @"GraphicsServices`GSEventRunModal + 160",
        @"UIKitCore`-[UIApplication _run] + 1052",
        @"UIKitCore`UIApplicationMain + 164",
        @"MCTestProjectDemo`main(argc=1, argv=0x000000016d93f878) at main.m:14:16",
        @"libdyld.dylib`start + 4",]];
    [self.table reloadData];
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    MethodInvocationMsgCell *cell = [tableView dequeueReusableCellWithIdentifier:[MethodInvocationMsgCell identifier]];
    [cell loadData:self.dataVM.dataList[indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataVM.dataList.count;
}

@end
