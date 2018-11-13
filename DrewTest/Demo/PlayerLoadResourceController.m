//
// Created by majiancheng on 2017/6/26.
// Copyright (c) 2017 waqu. All rights reserved.
//

#import "PlayerLoadResourceController.h"

#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface PlayerLoadResourceController () <AVAssetResourceLoaderDelegate, NSURLConnectionDataDelegate>

@property(nonatomic, strong) NSMutableData *songData;
@property(nonatomic, strong) NSURLConnection *connection;
@property(nonatomic, strong) NSHTTPURLResponse *response;
@property(nonatomic, strong) NSMutableArray *pendingRequests;

@end


@implementation PlayerLoadResourceController {
    AVPlayer *_player;
    AVPlayerLayer *_playerLayer;
    AVURLAsset *_asset;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *url = [NSURL URLWithString:@"http://vssauth.waqu.com/3jdqfuipe0iy8w7y/hd2.mp4?auth_key=1498474319-0-0-90e277e345b37c702bbb15cb8541be58"];
    NSURLComponents *components = [[NSURLComponents alloc] initWithURL:url resolvingAgainstBaseURL:NO];
    components.scheme = @"waqu";

    _asset = [AVURLAsset assetWithURL:components.URL];
    [_asset.resourceLoader setDelegate:self queue:dispatch_get_main_queue()];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:_asset];
    if ([UIDevice currentDevice].systemVersion.floatValue >= 9.0) {
        playerItem.canUseNetworkResourcesForLiveStreamingWhilePaused = YES;
    }
    _player = [[AVPlayer alloc] initWithPlayerItem:playerItem];

    _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];

    _playerLayer.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 300);
    [self.view.layer addSublayer:_playerLayer];

    [_player play];
}


#pragma mark - NSURLConnection delegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    self.songData = [NSMutableData data];
    self.response = (NSHTTPURLResponse *) response;
    [self processPendingRequests];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.songData appendData:data];
    [self processPendingRequests];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [self processPendingRequests];
    NSString *cachedFilePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"cached.mp3"];
    [self.songData writeToFile:cachedFilePath atomically:YES];
}

#pragma mark - AVURLAsset resource loading

- (void)processPendingRequests {
    NSMutableArray *requestsCompleted = [NSMutableArray array];
    for (AVAssetResourceLoadingRequest *loadingRequest in self.pendingRequests) {
        [self fillInContentInformation:loadingRequest.contentInformationRequest];
        BOOL didRespondCompletely = [self respondWithDataForRequest:loadingRequest.dataRequest];
        if (didRespondCompletely) {
            [requestsCompleted addObject:loadingRequest];
            [loadingRequest finishLoading];
        }
    }
    [self.pendingRequests removeObjectsInArray:requestsCompleted];
}

- (void)fillInContentInformation:(AVAssetResourceLoadingContentInformationRequest *)contentInformationRequest {
    if (contentInformationRequest == nil || self.response == nil) {
        return;
    }
    NSString *mimeType = [self.response MIMEType];
    CFStringRef contentType = UTTypeCreatePreferredIdentifierForTag(kUTTagClassMIMEType, (__bridge CFStringRef) (mimeType), NULL);
    contentInformationRequest.byteRangeAccessSupported = YES;
    contentInformationRequest.contentType = CFBridgingRelease(contentType);
    contentInformationRequest.contentLength = [self.response expectedContentLength];
}

- (BOOL)respondWithDataForRequest:(AVAssetResourceLoadingDataRequest *)dataRequest {
    long long startOffset = dataRequest.requestedOffset;
    if (dataRequest.currentOffset != 0) {
        startOffset = dataRequest.currentOffset;
    }
// Don't have any data at all for this request
    if (self.songData.length < startOffset) {
        return NO;
    }
// This is the total data we have from startOffset to whatever has been downloaded so far
    NSUInteger unreadBytes = self.songData.length - (NSUInteger) startOffset;
// Respond with whatever is available if we can't satisfy the request fully yet
    NSUInteger numberOfBytesToRespondWith = MIN((NSUInteger) dataRequest.requestedLength, unreadBytes);
    [dataRequest respondWithData:[self.songData subdataWithRange:NSMakeRange((NSUInteger) startOffset, numberOfBytesToRespondWith)]];
    long long endOffset = startOffset + dataRequest.requestedLength;
    BOOL didRespondFully = self.songData.length >= endOffset;
    return didRespondFully;
}

- (BOOL)resourceLoader:(AVAssetResourceLoader *)resourceLoader shouldWaitForLoadingOfRequestedResource:(AVAssetResourceLoadingRequest *)loadingRequest {
    if (self.connection == nil) {
        NSURL *interceptedURL = [loadingRequest.request URL];
        NSURLComponents *actualURLComponents = [[NSURLComponents alloc] initWithURL:interceptedURL resolvingAgainstBaseURL:NO];
        actualURLComponents.scheme = @"http";
        NSURLRequest *request = [NSURLRequest requestWithURL:[actualURLComponents URL]];
        self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
        [self.connection setDelegateQueue:[NSOperationQueue mainQueue]];
        [self.connection start];
    }
    [self.pendingRequests addObject:loadingRequest];
    return YES;
}

- (void)resourceLoader:(AVAssetResourceLoader *)resourceLoader didCancelLoadingRequest:(AVAssetResourceLoadingRequest *)loadingRequest {
    [self.pendingRequests removeObject:loadingRequest];
}
@end
