//
//  ViewController.m
//  DrewTest
//
//  Created by majiancheng on 2017/3/17.
//  Copyright © 2017年 waqu. All rights reserved.
//

#import "ViewController.h"

#import "CircleProgress.h"
#import "TouchShot.h"

@interface ViewController () <NSURLSessionDelegate, UIScrollViewDelegate>

@property(nonatomic, strong) CAShapeLayer *trackLayer;
@property(nonatomic, strong) CAShapeLayer *pregressLayer;

@end

@implementation ViewController

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = YES;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"%lf", scrollView.contentOffset.y);
    NSLog(@"%@", self.navigationController.navigationBar.subviews);
    if(scrollView.contentOffset.y > 0) {
//        [self.navigationController setNavigationBarHidden:NO animated:YES];
        self.navigationController.navigationBar.subviews[0].alpha = 0.0;
    } else {
        self.navigationController.navigationBar.subviews[0].alpha = 0.0;
//        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    NSLog(@"%@", self.navigationController.navigationBar.subviews);
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    UIScrollView * scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    scrollview.backgroundColor = [UIColor redColor];
    scrollview.delegate = self;
    [self.view addSubview:scrollview];
    
    {
        UIImageView * imageView  = [[UIImageView alloc] initWithFrame:self.view.bounds];
        
        imageView.image = [UIImage imageNamed:@"timg-2.jpeg"];
        [scrollview addSubview:imageView];
    }
    {
        UIImageView * imageView  = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
        
        imageView.image = [UIImage imageNamed:@"timg.jpeg"];
        [scrollview addSubview:imageView];
    }
    

    
    scrollview.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height * 2);
    
    
    
    
    

    _trackLayer = [[CAShapeLayer alloc] init];
    [self.view.layer addSublayer:_trackLayer];

    _pregressLayer = [[CAShapeLayer alloc] init];
    [self.view.layer addSublayer:_pregressLayer];

    _pregressLayer.lineWidth = 10;
    _trackLayer.lineWidth = 10;

    _trackLayer.strokeColor = [UIColor orangeColor].CGColor;
    _pregressLayer.strokeColor = [UIColor redColor].CGColor;


    _trackLayer.fillColor = [UIColor clearColor].CGColor;
    _pregressLayer.fillColor = [UIColor clearColor].CGColor;
    _pregressLayer.lineCap = kCALineCapRound;

    _trackLayer.frame = CGRectMake(100, 100, 100, 100);
    _pregressLayer.frame = _trackLayer.frame;

    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(150, 150) radius:50 startAngle:0 endAngle:M_PI * 2 clockwise:YES];

    UIBezierPath *bezierPath2 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(150, 150) radius:50 startAngle:0 endAngle:M_PI / 2 clockwise:YES];

    _trackLayer.path = bezierPath.CGPath;
    _pregressLayer.path = bezierPath2.CGPath;


    CircleProgress *circleProgress = [[CircleProgress alloc] initWithFrame:CGRectMake(100, 200, 100, 100)];
    [self.view addSubview:circleProgress];

    circleProgress.trackColor = [UIColor greenColor];
    circleProgress.progressColor = [UIColor orangeColor];

    circleProgress.lineWidth = 10;

    [circleProgress start];

//    [NSTimer scheduledTimerWithTimeInterval:0.1 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        circleProgress.rate += 0.01;
//    }];
//


    UIBezierPath *bezierPath1 = [[UIBezierPath alloc] init];

    [bezierPath1 moveToPoint:CGPointMake(200, 300)];
    [bezierPath1 addLineToPoint:CGPointMake(200, 340)];
    [bezierPath1 addLineToPoint:CGPointMake(10, 340)];
    [bezierPath1 addLineToPoint:CGPointMake(10, 320)];
    [bezierPath1 addLineToPoint:CGPointMake(10, 310)];

    [bezierPath1 addQuadCurveToPoint:CGPointMake(20, 300) controlPoint:CGPointMake(10, 300)];

    [bezierPath1 addLineToPoint:CGPointMake(200, 300)];

    [bezierPath1 closePath];

    CAShapeLayer *rectShapeLayer = [[CAShapeLayer alloc] init];

    rectShapeLayer.strokeColor = [UIColor colorWithRed:229 / 255.0 green:230 / 255.0 blue:225 / 255.0 alpha:1].CGColor;
    rectShapeLayer.fillColor = [UIColor colorWithRed:0 green:154 / 255.0 blue:1 alpha:1].CGColor;


//    rectShapeLayer.lineWidth = 3;

    rectShapeLayer.path = bezierPath1.CGPath;

    [self.view.layer addSublayer:rectShapeLayer];


    TouchShot *touchShot = [[TouchShot alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];

    touchShot.trackColor = [UIColor colorWithRed:229 / 255.0 green:230 / 255.0 blue:225 / 255.0 alpha:1];
    touchShot.progressColor = [UIColor colorWithRed:0 green:154 / 255.0 blue:1 alpha:1];
    touchShot.seconds = 30;
    touchShot.lineWidth = 6;

    [self.view addSubview:touchShot];


    CAGradientLayer *bottomGradientLayer = ({
        CAGradientLayer *layer = [CAGradientLayer layer];
        layer.colors = @[(__bridge id) [UIColor blackColor].CGColor, (__bridge id) [UIColor clearColor].CGColor];
        layer.locations = @[@(.5)];
        layer.startPoint = CGPointMake(0, 0);
        layer.endPoint = CGPointMake(0.0, 1.0);
        layer.frame = CGRectMake(0, 0, 300, 100);
        layer;
    });

    [self.view.layer addSublayer:bottomGradientLayer];

    /*{
        NSURLSession *session = [NSURLSession sharedSession];
        NSURL *url = [NSURL URLWithString:@"http://img.waqu.com/qudian/resource/ar/otu.zip"];
        NSLog(@"%@", [NSThread currentThread]);
        NSURLSessionTask *task = [session dataTaskWithURL:url completionHandler:^(NSData *_Nullable data, NSURLResponse *_Nullable response, NSError *_Nullable error) {
            NSLog(@"%@", [NSThread currentThread]);
            [data writeToFile:[NSTemporaryDirectory() stringByAppendingPathComponent:@"aa.zip"] atomically:YES];
            NSLog(@"%@", response.URL);
        }];

        [task resume];
    }*/

    {
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                                              delegate:self delegateQueue:[[NSOperationQueue alloc] init]];
        NSURLSessionTask *task = [session dataTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://img.waqu.com/qudian/resource/ar/otu.zip"]]];

        [task resume];

    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/* The last message a session receives.  A session will only become
 * invalid because of a systemic error or when it has been
 * explicitly invalidated, in which case the error parameter will be nil.
 */
- (void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(nullable NSError *)error {
    NSLog(@"%s--%zd", __func__, __LINE__);
}


/* If an application has received an
 * -application:handleEventsForBackgroundURLSession:completionHandler:
 * message, the session delegate will receive this message to indicate
 * that all messages previously enqueued for this session have been
 * delivered.  At this time it is safe to invoke the previously stored
 * completion handler, or to begin any internal updates that will
 * result in invoking the completion handler.
 */
- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session NS_AVAILABLE_IOS(7_0) {
    NSLog(@"%s--%zd", __func__, __LINE__);

}


/* An HTTP request is attempting to perform a redirection to a different
 * URL. You must invoke the completion routine to allow the
 * redirection, allow the redirection with a modified request, or
 * pass nil to the completionHandler to cause the body of the redirection
 * response to be delivered as the payload of this request. The default
 * is to follow redirections.
 *
 * For tasks in background sessions, redirections will always be followed and this method will not be called.
 */
- (void)        URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
willPerformHTTPRedirection:(NSHTTPURLResponse *)response
                newRequest:(NSURLRequest *)request
         completionHandler:(void (^)(NSURLRequest *_Nullable))completionHandler {
    NSLog(@"%s--%zd", __func__, __LINE__);
}

/* The task has received a request specific authentication challenge.
 * If this delegate is not implemented, the session specific authentication challenge
 * will *NOT* be called and the behavior will be the same as using the default handling
 * disposition.
 */
- (void) URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
  completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *_Nullable credential))completionHandler {
    NSLog(@"%s--%zd", __func__, __LINE__);
}

/* Sent if a task requires a new, unopened body stream.  This may be
 * necessary when authentication has failed for any request that
 * involves a body stream.
 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
 needNewBodyStream:(void (^)(NSInputStream *_Nullable bodyStream))completionHandler {
    NSLog(@"%s--%zd", __func__, __LINE__);
}

/* Sent periodically to notify the delegate of upload progress.  This
 * information is also available as properties of the task.
 */
- (void)      URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
         didSendBodyData:(int64_t)bytesSent
          totalBytesSent:(int64_t)totalBytesSent
totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend {
    NSLog(@"%s--%zd", __func__, __LINE__);
}


/*
 * Sent when complete statistics information has been collected for the task. s1
 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didFinishCollectingMetrics:(NSURLSessionTaskMetrics *)metrics API_AVAILABLE(macosx(10.12), ios(10.0), watchos(3.0), tvos(10.0)) {
    NSLog(@"%s--%zd", __func__, __LINE__);

}

/* If implemented, when a connection level authentication challenge
 * has occurred, this delegate will be given the opportunity to
 * provide authentication credentials to the underlying
 * connection. Some types of authentication will apply to more than
 * one request on a given connection to a server (SSL Server Trust
 * challenges).  If this delegate message is not implemented, the
 * behavior will be to use the default handling, which may involve user
 * interaction.
 */
- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *_Nullable credential))completionHandler {
    NSLog(@"%s--%zd", __func__, __LINE__);
    // 如果是请求证书信任，我们再来处理，其他的不需要处理
    if (challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust) {
        NSURLCredential *cre = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        // 调用block
        completionHandler(NSURLSessionAuthChallengeUseCredential, cre);
    }
}


// 1.接收到服务器的响应
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    // 允许处理服务器的响应，才会继续接收服务器返回的数据
    completionHandler(NSURLSessionResponseAllow);
}

// 2.接收到服务器的数据（可能调用多次）
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    // 处理每次接收的数据
    NSLog(@"%s--%zd", __func__, __LINE__);
    NSLog(@"%zd", data.length);
}

// 3.请求成功或者失败（如果失败，error有值）
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    // 请求完成,成功或者失败的处理
    NSLog(@"%s--%zd", __func__, __LINE__);
    NSLog(@"%@", error);
}


@end
