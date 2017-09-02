//
//  ViewController.m
//  Examples
//
//  Created by 宋永建 on 2017/9/2.
//  Copyright © 2017年 Global. All rights reserved.
//

#import "ViewController.h"
#import "EasyCharts.h"
#import "LineNormalViewController.h"
#import "LineCenterViewController.h"
#import "ProgressViewController.h"
#import "PieChartViewController.h"
#import "PieChartViewController.h"
#import "LineViewAndProgressViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, copy) NSArray *titleList;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setupNavigationBar];
    [self p_configOwnProperties];
    [self p_configSubViews];
}

#pragma mark - Functions
- (void)p_setupNavigationBar {
    
}

- (void)p_configOwnProperties {
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

#pragma mark - HandleViews
- (void)p_configSubViews {
    [self setupTableView];
}

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] init];
    tableView.tableFooterView = [[UITableView alloc] init];
    tableView.frame = CGRectMake(0, 64, ECScreenW, ECScreenH - 64);
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.estimatedRowHeight = 200;
    [self.view addSubview:tableView];
}

- (void)jump2LineNormalViewController {
    LineNormalViewController *vc = [[LineNormalViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)jump2LineCenterViewController {
    LineCenterViewController *vc = [[LineCenterViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)jump2ProgressViewController {
    ProgressViewController *vc = [[ProgressViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)jump2PieChartViewController {
    PieChartViewController *vc = [[PieChartViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)jump2LineViewAndProgressViewController {
    LineViewAndProgressViewController *vc = [[LineViewAndProgressViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma  mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.titleList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"DrawVCIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellID];
    }
    [cell.textLabel setText:self.titleList[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [self jump2LineNormalViewController];
    } else if (indexPath.row == 1) {
        [self jump2LineCenterViewController];
    } else if (indexPath.row == 2) {
        [self jump2ProgressViewController];
    } else if (indexPath.row == 3) {
        [self jump2LineViewAndProgressViewController];
    } else if (indexPath.row == 4) {
        [self jump2PieChartViewController];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSArray *)titleList {
    if (_titleList == nil) {
        _titleList = @[@"LineChart-1",@"LineChart-2",@"ProgressCircle",@"LineChart & ProgressCircle",@"PieChart"]; //,@"柱状图"
    }
    return _titleList;
}



@end
