//
// Created by majiancheng on 2019/3/11.
// Copyright (c) 2019 mjc. All rights reserved.
//

#import "PayListController.h"

#import <ReactiveCocoa.h>

#import "PayListDataVM.h"
#import "MMDict.h"
#import "ActionDto.h"
#import "MCGoodsDto.h"
#import "MCIAPPayHelper.h"


@interface PayListController ()

@property(nonatomic, strong) PayListDataVM *dataVM;

@property(nonatomic, strong) MCIAPPayHelper *iapRequestHelper;

@end

@implementation PayListController


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
    MCGoodsDto *dto = self.dataVM.dataList[indexPath.row];
    cell.textLabel.text = dto.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ CNY", dto.price];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MCGoodsDto *dto = self.dataVM.dataList[indexPath.row];
    
    @weakify(self);
    [self.iapRequestHelper startBuyProduct:dto.pid payType:@"" callBack:^(BOOL success, NSString * info) {
        @strongify(self);
        NSLog(@"success %d info:%@", success, info);
    }];
}

#pragma mark - getter

- (PayListDataVM *)dataVM {
    if (!_dataVM) {
        _dataVM = [PayListDataVM new];
    }
    return _dataVM;
}


- (MCIAPPayHelper *)iapRequestHelper {
    if (!_iapRequestHelper) {
        _iapRequestHelper = [MCIAPPayHelper new];
    }
    return _iapRequestHelper;
}
@end
