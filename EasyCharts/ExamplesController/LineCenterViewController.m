//  ************************************************************************
//
//  LineCenterViewController.m
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

#import "LineCenterViewController.h"
#import "EasyCharts.h"

@interface LineCenterViewController ()<ECBrokenLineViewDelegate>

@property (nonatomic, strong) ECBrokenLineView *brokenLineView;
@property (nonatomic, copy) NSArray *pointValveList;

@end

@implementation LineCenterViewController

#pragma mark - LifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationBar];
    [self configOwnProperties];
    [self configSubViews];
    [self setupLineValue];
}

- (void)dealloc {
    NSLog(@"dealloc");
}

#pragma mark - Notifies

#pragma mark - Network

#pragma mark - Functions
- (void)setupNavigationBar {
    
}

- (void)configOwnProperties {
    [self.view setBackgroundColor:ECBackgroundColor];
}

- (void)setupLineValue {
    [self.brokenLineView reloadLineViewDataWithPointValveList:self.pointValveList
                                                    titleText:@[@"Jan",@"Feb",@"Mar",@"Apr",@"May"]];
}

- (void)resetupLineValue {
    self.pointValveList = @[@"34",@"12",@"100",@"16",@"1"];
    [self.brokenLineView reloadLineViewDataWithPointValveList:self.pointValveList
                                                    titleText:self.pointValveList];
}

#pragma ECBrokenLineViewDelegate
- (void)brokenLineView:(ECBrokenLineView *)brokenLineView
   selectedAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - HandleViews
- (void)configSubViews {
    [self setupLineCenterView];
    [self setupTestButton];
}

- (void)setupLineCenterView {
    CGRect frame = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 300);
    ECBrokenLineView *brokenLineView = [ECBrokenLineView lineViewWithFrame:frame
                                                      withBrokenLineConfig:nil
                                                            brokenLineType:BrokenLineTypeCenterPoint];
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
- (NSArray *)pointValveList {
    if (_pointValveList == nil) {
        _pointValveList = @[@"12",@"10",@"0",@"56",@"80"];
    }
    return _pointValveList;
}


#pragma mark - MemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
