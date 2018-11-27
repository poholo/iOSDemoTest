//
// Created by majiancheng on 2018/10/19.
// Copyright (c) 2018 poholo Inc. All rights reserved.
//

#import "ScanQRCodeController.h"

#import <AVFoundation/AVFoundation.h>
#import <ReactiveCocoa.h>

#import "ScanQRCodeDataVM.h"
#import "ScanQRView.h"


@interface ScanQRCodeController () <AVCaptureMetadataOutputObjectsDelegate>

@property(nonatomic, strong) UIView *contentView;
@property(nonatomic, strong) ScanQRCodeDataVM *dataVM;
@property(nonatomic, strong) ScanQRView *scanQRView;

@property(nonatomic, strong) AVCaptureDevice *avCaptureDevice;
@property(nonatomic, strong) AVCaptureInput *avCaptureInput;
@property(nonatomic, strong) AVCaptureMetadataOutput *avCaptureMetadataOutput;
@property(nonatomic, strong) AVCaptureSession *avCaptureSession;
@property(nonatomic, strong) AVCaptureVideoPreviewLayer *avCaptureVideoPreviewLayer;

@end


@implementation ScanQRCodeController

- (void)dealloc {
    [self stopRunning];
    [self.avCaptureVideoPreviewLayer removeFromSuperlayer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"扫一扫";

    CGFloat h = [UIScreen mainScreen].bounds.size.height;
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    CGFloat rw = w * .6f;
    CGFloat top = (h - 64 - rw) / 2.0f - 100;

    [self.view addSubview:self.contentView];

    self.scanQRView = [[ScanQRView alloc] initWithFrame:CGRectMake((w - rw) / 2.0f, top, rw, rw)];
    [self.view addSubview:self.scanQRView];

    [self setupCamera];

    [self drawCropRect:CGRectMake((w - rw) / 2.0f, top, rw, rw)];
    @weakify(self);
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIApplicationWillResignActiveNotification object:nil] subscribeNext:^(id x) {
        @strongify(self);
        [self stopRunning];
    }];

    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIApplicationDidBecomeActiveNotification object:nil] subscribeNext:^(id x) {
        @strongify(self);
        [self startRunning];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self startRunning];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self stopRunning];
}

- (void)handleQRInfo:(NSString *)info {
    if ([self.dataVM validateRecongnizerInfo:info]) {
        NSLog(@"无法识别的内容");
        [self startRunning];
        return;
    }
    //TODO:: your logic
}

- (void)startRunning {
    [self.avCaptureSession startRunning];
    [self.scanQRView start];
}

- (void)stopRunning {
    [self.avCaptureSession stopRunning];
    [self.scanQRView stop];
}

#pragma mark - configView

- (void)setupCamera {
    self.avCaptureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];

    self.avCaptureInput = [AVCaptureDeviceInput deviceInputWithDevice:self.avCaptureDevice error:nil];

    self.avCaptureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];

    CGFloat h = [UIScreen mainScreen].bounds.size.height;
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    CGFloat rw = w * .6f;
    CGFloat top = (h - 64 - rw) / 2.0f - 100;

    self.avCaptureMetadataOutput.rectOfInterest = CGRectMake((top) / h, ((w - rw) / 2) / w, rw / h, rw / w);
    [self.avCaptureMetadataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];

    self.avCaptureSession = [[AVCaptureSession alloc] init];
    [self.avCaptureSession setSessionPreset:AVCaptureSessionPresetHigh];
    if ([self.avCaptureSession canAddInput:self.self.avCaptureInput]) {
        [self.avCaptureSession addInput:self.avCaptureInput];
    }

    if ([self.avCaptureSession canAddOutput:self.avCaptureMetadataOutput]) {
        [self.avCaptureSession addOutput:self.self.avCaptureMetadataOutput];
    }

    if (![[self.avCaptureMetadataOutput availableMetadataObjectTypes] containsObject:AVMetadataObjectTypeQRCode]) {
        NSLog(@"此设备不支持AVMetadataObjectTypeQRCode");
        return;
    }
    self.avCaptureMetadataOutput.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
    self.avCaptureVideoPreviewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.avCaptureSession];
    self.avCaptureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.avCaptureVideoPreviewLayer.frame = self.contentView.bounds;
    [self.contentView.layer insertSublayer:self.self.avCaptureVideoPreviewLayer atIndex:0];
    [self startRunning];
}

- (void)drawCropRect:(CGRect)cropRect {
    CAShapeLayer *cropLayer = [[CAShapeLayer alloc] init];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, nil, cropRect);
    CGPathAddRect(path, nil, self.contentView.bounds);

    [cropLayer setFillRule:kCAFillRuleEvenOdd];
    [cropLayer setPath:path];
    [cropLayer setFillColor:[UIColor blackColor].CGColor];
    [cropLayer setOpacity:0.6];

    [cropLayer setNeedsDisplay];

    [self.contentView.layer addSublayer:cropLayer];
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {

    NSString *stringValue;

    if ([metadataObjects count] > 0) {
        AVMetadataMachineReadableCodeObject *metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
    }

    [self stopRunning];
    NSLog(@"[QR]%@", stringValue);
    [self handleQRInfo:stringValue];
}


#pragma mark - getter

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:self.view.bounds];
    }
    return _contentView;
}

- (ScanQRCodeDataVM *)dataVM {
    if (!_dataVM) {
        _dataVM = [ScanQRCodeDataVM new];
    }
    return _dataVM;
}

@end
