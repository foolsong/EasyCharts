//  ************************************************************************
//
//  ECPieChartView.m
//  EasyCharts
//
//  Created by 宋永建 on 2017/6/14.
//  Copyright © 2017年 宋永建. All rights reserved.
//
//  Main function:
//
//  Other specifications:
//
//  ************************************************************************

#import "ECPieChartView.h"
#import "ECPieChartCoreView.h"
#import "ECPieChartLineView.h"
#import "ECPieChartModel.h"

@interface ECPieChartView ()

@property (nonatomic, assign) CGPoint arcCenter;
@property (nonatomic, strong) ECPieChartCoreView *pieChartView;
@property (nonatomic, strong) ECPieChartLineView *pieChartLineView;

@property (nonatomic, copy) NSArray<NSNumber *> *percentList;
@property (nonatomic, copy) NSArray<UIColor *> *colorList;
@property (nonatomic, copy) NSArray<NSString *> *arcTextList;

@property (nonatomic, strong) NSMutableArray *pieChartModelList;

@end

@implementation ECPieChartView

+ (instancetype)pieChartViewWithFrame:(CGRect)frame {
    ECPieChartView *pieChartView = [[self alloc] initWithFrame:frame];
    pieChartView.arcCenter = CGPointMake(frame.size.width * 0.5, frame.size.height * 0.5);
    [pieChartView setupSubviews];
    return pieChartView;
}

- (void)setupSubviews {
    [self setupDrawCircleView];
    [self setupDrawCircleLineView];
}

- (void)setupDrawCircleView {
    ECPieChartCoreView *pieChartView = [[ECPieChartCoreView alloc] init];
    pieChartView.arcCenter = self.arcCenter;
    pieChartView.frame = self.frame;
    [self addSubview:pieChartView];
    self.pieChartView = pieChartView;
}

- (void)setupDrawCircleLineView {
    ECPieChartLineView *pieChartLineView = [[ECPieChartLineView alloc] init];
    pieChartLineView.arcCenter = self.arcCenter;
    pieChartLineView.frame = self.frame;
    [self addSubview:pieChartLineView];
    self.pieChartLineView = pieChartLineView;
}

- (void)drawPieChartWithPercentList:(NSArray<NSNumber *> *)percentList
                          colorList:(NSArray<UIColor *> *)colorList
                        arcTextList:(NSArray<NSString *> *)arcTextList {
    self.percentList = percentList;
    self.colorList = colorList;
    self.arcTextList = arcTextList;
    if (![self isLegalOfDataList]) {
        NSAssert(NO, @"invalid data");
        return;
    }
    [self extractPieChartModelList];
    [self checkExceptionData];
    [self redrawPieChart];
}

- (BOOL)isLegalOfDataList {
    if (!([self.percentList count] == [self.colorList count] &&
          [self.colorList count] == [self.arcTextList count])) {
        return NO;
    }
    if (fabs([self computerPercentSum] - 1) > 0.001) {
        return NO;
    }
    return YES;
}

- (CGFloat)computerPercentSum {
    CGFloat sum = 0;
    for (NSNumber *num in self.percentList) {
        sum += [num floatValue];
    }
    return sum;
}

- (void)extractPieChartModelList{
    [self.pieChartModelList removeAllObjects];
    
    CGFloat startAngle = 0;
    for (int i = 0 ; i < [self.percentList count]; i++) {
        ECPieChartModel *model = [ECPieChartModel circleModelWithSrartAngle:startAngle
                                                                 arcPercent:self.percentList[i]
                                                                      color:self.colorList[i]
                                                                    arcText:self.arcTextList[i]
                                                                  arcCenter:self.arcCenter];
        startAngle = model.endAngle;
        [self.pieChartModelList addObject:model];
    }
}

- (void)checkExceptionData {
    ECPieChartModel *lastModel = nil;
    
    for (ECPieChartModel *model in self.pieChartModelList) {
        if (lastModel == nil) {
            lastModel = [self.pieChartModelList lastObject];
        }
        
        if (model.arcCenterQuadrant == lastModel.arcCenterQuadrant &&
            (fabs(model.textLeftCenterPoint.y - lastModel.textLeftCenterPoint.y) < 15)) {
            [model resetLinePositionWithLastPointY:lastModel.textLeftCenterPoint.y];
        }
        lastModel = model;
    }
}

- (void)redrawPieChart {
    [self.pieChartView resetCircleList:self.pieChartModelList];
    [self.pieChartLineView resetLine:self.pieChartModelList];
}

#pragma mark - LazyLoads
- (NSArray *)colorList {
    if (_colorList == nil) {
        _colorList = [NSArray array];
    }
    return _colorList;
}

- (NSArray *)percentList {
    if (_percentList == nil) {
        _percentList = [NSArray array];
    }
    return _percentList;
}

- (NSArray *)arcTextList {
    if (_arcTextList == nil) {
        _arcTextList = [NSArray array];
    }
    return _arcTextList;
}

- (NSMutableArray *)pieChartModelList {
    if (_pieChartModelList == nil) {
        _pieChartModelList = [NSMutableArray array];
    }
    return _pieChartModelList;
}

@end
