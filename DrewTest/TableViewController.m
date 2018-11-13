//
//  TableViewController.m
//  DrewTest
//
//  Created by majiancheng on 2017/5/19.
//  Copyright © 2017年 waqu. All rights reserved.
//

#import "TableViewController.h"

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

@interface TableViewController ()

@property(nonatomic, strong) NSArray<NSString *> *titles;
@property(nonatomic, strong) NSArray<Class> *targetClasses;

@end

@implementation TableViewController

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
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
