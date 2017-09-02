//  ************************************************************************
//
//  PieChartViewController.m
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

#import "PieChartViewController.h"
#import "EasyCharts.h"

@interface PieChartViewController ()

@property (nonatomic, copy) NSArray<NSNumber *> *percentList;
@property (nonatomic, copy) NSArray<UIColor *> *colorList;
@property (nonatomic, copy) NSArray<NSString *> *arcTextList;

@property (nonatomic, strong) ECPieChartView *pieView;

@end

@implementation PieChartViewController

#pragma mark - LifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configOwnProperties];
    [self configSubViews];
}

- (void)dealloc {
    NSLog(@"dealloc");
}

#pragma mark - Notifies

#pragma mark - Network

#pragma mark - Functions
- (void)configOwnProperties {
    [self.view setBackgroundColor:ECBackgroundColor];
}


#pragma mark - Delegates

#pragma mark - HandleViews
- (void)configSubViews {
    [self setupPieView];
    [self setupTestButton];
}

- (void)setupPieView {
    ECPieChartView *pieView = [ECPieChartView pieChartViewWithFrame:CGRectMake(0, 100, ECScreenW, 200)];
    [self.view addSubview:pieView];
    self.pieView = pieView;
    
    [pieView drawPieChartWithPercentList:self.percentList
                               colorList:self.colorList
                             arcTextList:self.arcTextList];
}

- (NSArray<NSNumber *> *)percentList {
    if (_percentList == nil) {
        _percentList = @[@(0.2),@(0.4),@(0.1),@(0.3)];
    }
    return _percentList;
}

- (NSArray<UIColor *> *)colorList {
    if (_colorList == nil) {
        _colorList = @[[UIColor colorWithRed:(64)/255.0 green:(186)/255.0 blue:(255)/255.0 alpha:1.0],
                       [UIColor colorWithRed:(255)/255.0 green:(133)/255.0 blue:(155)/255.0 alpha:1.0],
                       [UIColor colorWithRed:(255)/255.0 green:(179)/255.0 blue:(0)/255.0 alpha:1.0],
                       [UIColor colorWithRed:(152)/255.0 green:(230)/255.0 blue:(123)/255.0 alpha:1.0]];
    }
    return _colorList;
}

- (NSArray<NSString *> *)arcTextList {
    if (_arcTextList == nil) {
        _arcTextList = @[@"T1",@"T2",@"T3",@"T4"];
    }
    return _arcTextList;
}

- (void)setupTestButton {
    CGFloat width = 80;
    CGFloat height = 40;
    CGFloat x = (ECScreenW - width) * 0.5;
    CGFloat y = CGRectGetMaxY(self.pieView.frame) + 180;
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
    
    //    [[UIApplication sharedApplication]openURL:[NSURL   URLWithString:@"mailto:example@example.com"]];
    
    [self randomNumList];
    [self randomColorList];
    [self randomText];
    
    [self.pieView drawPieChartWithPercentList:self.percentList
                                    colorList:self.colorList
                                  arcTextList:self.arcTextList];
}

- (void)randomNumList {
    NSMutableArray *numMutableList = [NSMutableArray array];
    int sum = 0;
    while (YES) {
        int temp = arc4random_uniform(60) + 1;
        if (sum + temp >= 100 || [numMutableList count] >= 7) {
            [numMutableList addObject:@((100 - sum) / 100.0)];
            break;
        } else {
            [numMutableList addObject:@(temp / 100.0)];
            sum += temp;
        }
    }
    self.percentList = numMutableList;
}

- (void) randomColorList {
    NSMutableArray *colorMutableList = [NSMutableArray array];
    for (int i = 0; i < [self.percentList count]; i++) {
        [colorMutableList addObject:randomColor];
    }
    
    self.colorList = colorMutableList;
}

- (void)randomText {
    NSMutableArray *textMutableList = [NSMutableArray array];
    NSArray *textList = @[@"T1",@"T2",@"T3",@"T4",@"T5",@"T6",@"T7",@"T8"];
    for (int i = 0; i < [self.percentList count]; i++) {
        [textMutableList addObject:textList[i]];
    }
    self.arcTextList = textMutableList;
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
