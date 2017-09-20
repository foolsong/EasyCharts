//
//  RadarChartViewController.m
//  Examples
//
//  Created by 宋永建 on 2017/9/20.
//  Copyright © 2017年 Global. All rights reserved.
//

#import "RadarChartViewController.h"
#import "EasyCharts.h"

@interface RadarChartViewController ()

@end

@implementation RadarChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubviews];
    [self configOwnProperties];
}

- (void)setupSubviews {
    [self setupRadarChartView];
    [self setupRadarChartView2];
}

- (void)configOwnProperties {
    [self.view setBackgroundColor:ECBackgroundColor];
}

- (void)setupRadarChartView {
    ECRadarChartView *rView = [ECRadarChartView radarChartViewWithFrame:CGRectMake(60, 90, 270, 270)];
    [self.view addSubview:rView];
    
    
    ECRadarChartConfig *config = [[ECRadarChartConfig alloc] init];
    config.backgroupLineNum = 5;
    config.radius = 100;
    config.drawPointArray = @[@[@(0.5),@(0.4),@(0.5),@(0.1),@(0.9)],
                              @[@(0.4),@(0.5),@(0.2),@(0.8),@(0.1)],
                              @[@(0.4),@(0.1),@(0.8),@(0.7),@(0.2)]];
    config.drawLineColorArray = @[[UIColor orangeColor],[UIColor greenColor],[UIColor redColor]];
    config.drawLineTitleArray = @[@"Technology",@"Execution",@"Thinking",@"Endurance",@"Speed"];
    [rView setupRadarChartConfig:config];
}

- (void)setupRadarChartView2 {
    ECRadarChartView *rView = [ECRadarChartView radarChartViewWithFrame:CGRectMake(60, 350, 270, 270)];
    [self.view addSubview:rView];
    
    ECRadarChartConfig *config = [[ECRadarChartConfig alloc] init];
    config.backgroupLineNum = 5;
    config.radius = 100;
    config.drawPointArray = @[@[@(0.5),@(0.4),@(0.5),@(0.1),@(0.9),@(0.4)]];
    config.drawLineColorArray = @[[UIColor orangeColor]];
    config.drawLineTitleArray = @[@"Technology",@"Execution",@"Thinking",@"Endurance",@"Speed",@"Power",];
    [rView setupRadarChartConfig:config];
}
@end
