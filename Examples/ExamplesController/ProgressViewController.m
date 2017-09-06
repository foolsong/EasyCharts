//  ************************************************************************
//
//  ProgressViewController.m
//  Examples
//
//  Created by 宋永建 on 2017/9/2.
//  Copyright © 2017年 Global. All rights reserved.
//
//  Main function:
//
//  Other specifications:
//
//  ************************************************************************

#import "ProgressViewController.h"
#import "EasyCharts.h"

@interface ProgressViewController ()

@property (nonatomic, strong) ECProgressChartView *progressView;

@end

@implementation ProgressViewController

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
    
}

- (void)configOwnProperties {
    [self.view setBackgroundColor:ECBackgroundColor];
}

#pragma mark - Delegates

#pragma mark - HandleViews
- (void)configSubViews {
    [self setupDrawProgressByShapeLayer];
    [self setupTestButton];
}

- (void)setupDrawProgressByShapeLayer {
    
    CGFloat width = 200;
    CGFloat height = 200;
    CGFloat x = (ECScreenW - width) * 0.5;
    CGFloat y = CGRectGetMaxY(self.progressView.frame) + 100;
    
    CGRect frame = CGRectMake(x ,y ,width , height);;
    ECProgressChartView *progressView = [ECProgressChartView progressChartViewWithFrame:frame];
    [self.view addSubview:progressView];
    self.progressView = progressView;
}

- (CGFloat)createProgress {
    return arc4random_uniform(100) / 100.0;
}

- (void)setupTestButton {
    CGFloat width = 80;
    CGFloat height = 40;
    CGFloat x = (ECScreenW - width) * 0.5;
    CGFloat y = CGRectGetMaxY(self.progressView.frame) + 100;
    UIButton *testButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [testButton setTitle:@"Reset" forState:UIControlStateNormal];
    [testButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    testButton.frame = CGRectMake(x, y, width, height);
    [testButton addTarget:self
                   action:@selector(testButtonClicked:)
         forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:testButton];
}

- (void)testButtonClicked:(UIButton *)button {
    [self.progressView resetProgress:[self createProgress]];
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
