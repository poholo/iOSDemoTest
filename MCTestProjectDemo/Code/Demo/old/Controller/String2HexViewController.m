//
//  String2HexViewController.m
//  DrewTest
//
//  Created by majiancheng on 2017/7/5.
//  Copyright © 2017年 waqu. All rights reserved.
//

#import "String2HexViewController.h"

@interface String2HexViewController ()

@end

@implementation String2HexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *str = @"ff055008";
    //先以16为参数告诉strtoul字符串参数表示16进制数字，然后使用0x%X转为数字类型
    unsigned long red = strtoul([str UTF8String],0,16);
    NSLog(@"转换完的数字为：%lx",red);
    //strtoul如果传入的字符开头是“0x”,那么第三个参数是0，也是会转为十六进制的,这样写也可以：
    unsigned long red1 = strtoul([@"0x6587" UTF8String],0,0);
    NSLog(@"转换完的数字为1：%lx",red1);
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

@end
