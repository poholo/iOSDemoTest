//
//  QueueTestController.m
//  MCTestProjectDemo
//
//  Created by Ma Jiancheng on 2020/12/4.
//  Copyright © 2020 mjc. All rights reserved.
//

#import "QueueTestController.h"

#import "QueueTestDataVM.h"
#import "ActionDto.h"
#import "MMDict.h"

@interface QueueTestController ()

@property(nonatomic, strong) QueueTestDataVM *dataVM;
@end

@implementation QueueTestController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuseIdentifier"];

    [self refresh];
}

- (void)refresh {
    [self.dataVM refresh];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataVM.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    ActionDto *dto = self.dataVM.dataList[indexPath.row];
    cell.textLabel.text = dto.name;
    cell.detailTextLabel.text = dto.desc;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ActionDto *dto = self.dataVM.dataList[indexPath.row];
    MMDict *dict = [MMDict new];
    [dict setObj:dto forKey:ROUTE_DTO];
    MMController *classController = (MMController *) [dto.targetClass alloc];
    MMController *vc = [classController initWithRouterParams:dict];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - getter

- (QueueTestDataVM *)dataVM {
    if (!_dataVM) {
        _dataVM = [QueueTestDataVM new];
    }
    return _dataVM;
}


@end
