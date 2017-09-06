//  ************************************************************************
//
//  LineViewAndProgressViewController.m
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

#import "LineViewAndProgressViewController.h"
#import "EasyCharts.h"

@interface LineViewAndProgressViewController ()<ECBrokenLineViewDelegate>

@property (nonatomic, strong) ECBrokenLineView *brokenLineView;
@property (nonatomic, strong) ECProgressChartView *progressView;
@property (nonatomic, copy) NSArray *pointValveList;

@end

@implementation LineViewAndProgressViewController

#pragma mark - LifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
    [self configOwnProperties];
    [self configSubViews];
    
    
    [self setupValue];
}

- (void)dealloc {
    ECLog(@"dealloc");
}

#pragma mark - Notifies

#pragma mark - Network

#pragma mark - Functions
- (void)setupNavigationBar {
    self.title = @"Line&Progress";
}

- (void)configOwnProperties {
    [self.view setBackgroundColor:[UIColor colorWithRed:(255)/255.0
                                                  green:(156)/255.0
                                                   blue:(14)/255.0
                                                  alpha:1.0]];
}

#pragma ECBrokenLineViewDelegate
- (void)brokenLineView:(ECBrokenLineView *)brokenLineView
   selectedAtIndexPath:(NSIndexPath *)indexPath {
    [self.progressView resetProgress:([self.pointValveList[indexPath.row] floatValue]) / 100.0];
}


#pragma mark - HandleViews
- (void)configSubViews {
    [self setupDrawProgressByShapeLayer];
    [self setupDrawLineView];
}

- (void)setupDrawProgressByShapeLayer {
    
    CGFloat width = 150;
    CGFloat height = 150;
    CGFloat x = (ECScreenW - width) * 0.5;
    CGFloat y = CGRectGetMaxY(self.progressView.frame) + 100;
    
    CGRect frame = CGRectMake(x ,y ,width , height);;
    ECProgressChartView *progressView = [ECProgressChartView progressChartViewWithFrame:frame];
    self.progressView = progressView;
    [self.view addSubview:progressView];
}

- (void)setupDrawLineView {
    CGRect frame = CGRectMake(0, 280, [UIScreen mainScreen].bounds.size.width, 300);
    ECBrokenLineView *brokenLineView = [ECBrokenLineView lineViewWithFrame:frame
                                                      withBrokenLineConfig:nil
                                                            brokenLineType:BrokenLineTypeCenterPoint];
    brokenLineView.delegate = self;
    [self.view addSubview:brokenLineView];
    self.brokenLineView = brokenLineView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self test1];
}

- (void)setupValue {
    [self.brokenLineView reloadLineViewDataWithPointValveList:self.pointValveList
                                                    titleText:@[@"Jan",@"Feb",@"Mar",@"Apr",@"May"]];
}

- (void)test {
    self.pointValveList = @[@"34",@"12",@"100",@"16",@"1"];
    [self.brokenLineView reloadLineViewDataWithPointValveList: self.pointValveList
                                                    titleText:@[@"Jan",@"Feb",@"Mar",@"Apr",@"May"]];
}

- (NSArray *)pointValveList {
    if (_pointValveList == nil) {
        _pointValveList = @[@"12",@"90",@"0",@"56",@"34"];
    }
    return _pointValveList;
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
