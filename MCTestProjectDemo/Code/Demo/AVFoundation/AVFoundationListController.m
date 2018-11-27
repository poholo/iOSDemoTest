//
// Created by majiancheng on 2018/11/26.
// Copyright (c) 2018 mjc. All rights reserved.
//

#import "AVFoundationListController.h"

#import "AVFoundationDataVM.h"
#import "ActionDto.h"
#import "MMDict.h"

@interface AVFoundationListController ()

@property(nonatomic, strong) AVFoundationDataVM *dataVM;

@end

@implementation AVFoundationListController

- (instancetype)initWithRouterParams:(MMDict *)params {
    self = [super initWithRouterParams:params];
    if (self) {
        self.dataVM.dto = [params objForKey:ROUTE_DTO];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = self.dataVM.dto.name;

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

- (AVFoundationDataVM *)dataVM {
    if (!_dataVM) {
        _dataVM = [AVFoundationDataVM new];
    }
    return _dataVM;
}
@end