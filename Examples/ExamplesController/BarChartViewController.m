//  ************************************************************************
//
//  BarChartViewController.m
//  Examples
//
//  Created by 宋永建 on 2017/9/8.
//  Copyright © 2017年 Global. All rights reserved.
//
//  Main function:
//
//  Other specifications:
//
//  ************************************************************************

#import "BarChartViewController.h"
#import "ECBarChartView.h"
#import "ECCommon.h"
#import "ECBarChartView.h"

@interface BarChartViewController ()



@end

@implementation BarChartViewController

#pragma mark - LifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationBar];
    [self configOwnProperties];
    [self configSubViews];
}

- (void)dealloc {
    ECLog(@"dealloc");
}

#pragma mark - Notifies

#pragma mark - Network

#pragma mark - Functions
- (void)setupNavigationBar {
    self.title = @"BarChart";
}

- (void)configOwnProperties {
    [self.view setBackgroundColor:ECBackgroundColor];
}

#pragma mark - Delegates

#pragma mark - HandleViews
- (void)configSubViews {
    [self setupBarChartView];
}

- (void)setupBarChartView {
    ECBarChartView *chartView = [ECBarChartView barChartViewWithFrame:CGRectMake(0, 100, ECScreenW, 210)];
    [self.view addSubview:chartView];
}

#pragma mark - HandleEvents

#pragma mark - Setter

#pragma mark - Getter

#pragma mark - LazyLoads


#pragma mark - MemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
