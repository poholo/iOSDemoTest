//
// Created by majiancheng on 2018/11/26.
// Copyright (c) 2018 mjc. All rights reserved.
//

#import "AlgorithmListController.h"

#import "AlgorithmListDataVM.h"
#import "ActionDto.h"

@interface AlgorithmListController ()

@property(nonatomic, strong) AlgorithmListDataVM *dataVM;

@end


@implementation AlgorithmListController


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
//    UIViewController *vc = (UIViewController *) [[dto.targetClass alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - getter

- (AlgorithmListDataVM *)dataVM {
    if (!_dataVM) {
        _dataVM = [AlgorithmListDataVM new];
    }
    return _dataVM;
}

@end
