//
//  OldListController.m
//  DrewTest
//
//  Created by majiancheng on 2017/5/19.
//  Copyright © 2017年 waqu. All rights reserved.
//

#import "OldListController.h"

#import "RefreshViewController.h"
#import "LeftRightViewController.h"
#import "SliderController.h"
#import "UIControlSliderTestController.h"
#import "PlayerTestViewController.h"
#import "PlayerLoadResourceController.h"
#import "String2HexViewController.h"
#import "ViewController.h"
#import "PhotoListController.h"
#import "ALAssetController.h"
#import "JSCoreController.h"
#import "PraiseController.h"
#import "PlayerController.h"
#import "EnTestController.h"
#import "QRCodeViewController.h"

@interface OldListController ()

@property(nonatomic, strong) NSArray<NSString *> *titles;
@property(nonatomic, strong) NSArray<Class> *targetClasses;

@end

@implementation OldListController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.titles = @[@"RefreshViewController", @"LeftRightViewController",
            @"slider", @"UIControlSliderTestController", @"PlayerTestViewController",
            @"PlayerLoadResourceController", @"String2HexViewController",
            @"ViewController", @"PhotoListController", @"ALAssetController",
            @"JSCoreController", @"PraiseController", @"PlayerController", @"EnTestController", @"QRCodeViewController"];
    self.targetClasses = @[[RefreshViewController class], [LeftRightViewController class],
            [SliderController class], [UIControlSliderTestController class],
            [PlayerTestViewController class],
            [PlayerLoadResourceController class],
            [String2HexViewController class],
            [ViewController class],
            [PhotoListController class],
            [ALAssetController class],
            [JSCoreController class],
            [PraiseController class],
            [PlayerController class],
            [EnTestController class],
            [QRCodeViewController class]];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuseIdentifier"];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.targetClasses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];

    cell.textLabel.text = self.titles[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *vc = [[self.targetClasses[indexPath.row] alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
