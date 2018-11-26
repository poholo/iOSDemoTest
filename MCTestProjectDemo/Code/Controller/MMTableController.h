//
// Created by Jiangmingz on 2017/3/15.
// Copyright (c) 2017 GymChina inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMController.h"

@interface MMTableController : MMController <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, assign) UIEdgeInsets edgeInsets;

- (void)reloadData;

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

- (UITableViewStyle)tableStyle;

@end
