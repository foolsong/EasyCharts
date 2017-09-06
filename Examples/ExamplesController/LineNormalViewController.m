//  ************************************************************************
//
//  LineNormalViewController.m
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

#import "LineNormalViewController.h"
#import "EasyCharts.h"

@interface LineNormalViewController ()<ECBrokenLineViewDelegate>

@property (nonatomic, strong) ECBrokenLineView *brokenLineView;

@end

@implementation LineNormalViewController

#pragma mark - LifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationBar];
    [self configOwnProperties];
    [self configSubViews];
    [self setupLineValue];
}

- (void)dealloc {
    ECLog(@"dealloc");
}

#pragma mark - Notifies

#pragma mark - Network

#pragma mark - Functions
- (void)setupNavigationBar {
    self.title = @"BrokenLine";
}

- (void)configOwnProperties {
    [self.view setBackgroundColor:ECBackgroundColor];
}

- (void)setupLineValue {
    [self.brokenLineView reloadLineViewDataWithPointValveList:@[@"12",@"80",@"-1",
    @"56",@"80",@"-12",@"0",@"1",@"56",@"-14",@"12",@"80",@"1",@"56",@"34"]
                                                    titleText:@[@"Jan",@"Feb",@"Mar",
    @"Apr",@"May",@"Jun",@"Jul",@"Aug",@"Sept",@"Oct",@"Nov",@"Dec",@"Jan",@"Feb",@"Mar"]];
}

- (void)resetupLineValue {
    [self.brokenLineView reloadLineViewDataWithPointValveList:@[@"34",@"12",@"100",@"16",@"1"]
                                                    titleText:@[@"Jan",@"Feb",@"Mar",@"Apr",@"May"]];
}


#pragma ECBrokenLineViewDelegate
- (void)brokenLineView:(ECBrokenLineView *)brokenLineView
   selectedAtIndexPath:(NSIndexPath *)indexPath {
    ECLog(@"delegate---%ld",(long)indexPath.row);
}

#pragma mark - HandleViews
- (void)configSubViews {
    [self setupLineNormalView];
    [self setupTestButton];
}

- (void)setupLineNormalView {
    CGRect frame = CGRectMake(0, 120, ECScreenW, 300);
    ECBrokenLineView *brokenLineView = [ECBrokenLineView lineViewWithFrame:frame
                                                      withBrokenLineConfig:nil
                                                            brokenLineType:BrokenLineTypeNormal];
    brokenLineView.delegate = self;
    [self.view addSubview:brokenLineView];
    self.brokenLineView = brokenLineView;
}

- (void)setupTestButton {
    CGFloat width = 80;
    CGFloat height = 40;
    CGFloat x = (ECScreenW - width) * 0.5;
    CGFloat y = CGRectGetMaxY(self.brokenLineView.frame) + 100;
    UIButton *testButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [testButton setTitle:@"Reset" forState:UIControlStateNormal];
    [testButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [testButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    testButton.frame = CGRectMake(x, y, width, height);
    [testButton addTarget:self
                   action:@selector(testButtonClicked:)
         forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:testButton];
}

- (void)testButtonClicked:(UIButton *)button {
    [self resetupLineValue];
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
