//
// Created by majiancheng on 2019/5/16.
// Copyright (c) 2019 mjc. All rights reserved.
//

#import "LifeCircleController.h"


@interface LifeCircleController ()

@property(nonatomic, strong) NSMutableArray<NSString *> *dataList;

@end

@implementation LifeCircleController

- (void)log:(NSString *)info {
    NSLog(@"%@", info);
    [self.dataList addObject:info];
    [self.tableView reloadData];
}

- (instancetype)initWithRouterParams:(MMDict *)params {
    self = [super initWithRouterParams:params];
    if (self) {
        [self log:[NSString stringWithFormat:@"%s", __func__]];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self log:[NSString stringWithFormat:@"%s", __func__]];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self log:[NSString stringWithFormat:@"%s", __func__]];
    }
    return self;
}

- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self log:[NSString stringWithFormat:@"%s", __func__]];
    }
    return self;
}

+ (void)initialize {
    NSLog(@"%@", [NSString stringWithFormat:@"%s", __func__]);
}

+ (void)load {
    NSLog(@"%@", [NSString stringWithFormat:@"%s", __func__]);
}

- (void)loadView {
    [super loadView];
    [self log:[NSString stringWithFormat:@"%s", __func__]];
}

- (void)loadViewIfNeeded {
    [super loadViewIfNeeded];
    [self log:[NSString stringWithFormat:@"%s", __func__]];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    [self log:[NSString stringWithFormat:@"%s", __func__]];
}

- (void)viewWillUnload {
    [super viewWillUnload];
    [self log:[NSString stringWithFormat:@"%s", __func__]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuseIdentifier"];
    [self log:[NSString stringWithFormat:@"%s", __func__]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self log:[NSString stringWithFormat:@"%s", __func__]];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self log:[NSString stringWithFormat:@"%s", __func__]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self log:[NSString stringWithFormat:@"%s", __func__]];

}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self log:[NSString stringWithFormat:@"%s", __func__]];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self log:[NSString stringWithFormat:@"%s", __func__]];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self log:[NSString stringWithFormat:@"%s", __func__]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [self log:[NSString stringWithFormat:@"%s", __func__]];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    cell.textLabel.text = self.dataList[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}

- (NSMutableArray<NSString *> *)dataList {
    if (!_dataList) {
        _dataList = [NSMutableArray new];
    }
    return _dataList;
}

@end