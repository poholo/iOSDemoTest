//
//  RefreshViewController.m
//  DrewTest
//
//  Created by majiancheng on 2017/5/19.
//  Copyright © 2017年 waqu. All rights reserved.
//

#import "RefreshViewController.h"

@interface RefreshViewController () <UIScrollViewDelegate>

@property(nonatomic, strong) UIScrollView * scrollView;

@property(nonatomic, strong) UIRefreshControl * refreshControl;

@end

@implementation RefreshViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.scrollView = ({
        UIScrollView * sc = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 200)];
        sc.backgroundColor = [UIColor redColor];
        [self.view addSubview:sc];
        sc.delegate = self;
        sc;
    });
    
    self.refreshControl = ({
        UIRefreshControl * rc = [[UIRefreshControl alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 44)];
        [self.scrollView addSubview:rc];
        rc;
    });
    
    UIImageView * imageView = ({
        UIImage * image = [UIImage imageNamed:@"timg.jpeg"];
        UIImageView * ig = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), image.size.height)];
        [ig setImage:image];
        [self.scrollView addSubview:ig];
        ig;
    });
    UIImageView * imageView1 = ({
        UIImage * image = [UIImage imageNamed:@"timg-2.jpeg"];
        UIImageView * ig = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame), CGRectGetWidth(self.view.frame), image.size.height)];
        [ig setImage:image];
        [self.scrollView addSubview:ig];
        ig;
    });
    
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetMaxY(imageView1.frame));
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if(self.refreshControl.isRefreshing) return;
    if(scrollView.contentOffset.y < 100) {
        [self.refreshControl beginRefreshing];
        __weak typeof (self) weakSelf = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            __strong typeof (weakSelf) strongSelf = weakSelf;
            [strongSelf.refreshControl endRefreshing];
        });
    }
}

@end
