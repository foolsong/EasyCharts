//  ************************************************************************
//
//  ECBarChartView.m
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

#import "ECBarChartView.h"
#import "ECBarCollectionView.h"
#import "ECCommon.h"

@interface ECBarChartView ()

@property (nonatomic, strong) ECBarCollectionView *collectionView;

@end

@implementation ECBarChartView

+ (instancetype)barChartViewWithFrame:(CGRect)frame {
    ECBarChartView *chartView = [[ECBarChartView alloc] initWithFrame:frame];
    return chartView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self p_configSubViews];
    }
    return self;
}

#pragma mark - Functions
- (void)p_configOwnProperties {
    
}

#pragma mark - HandleViews
- (void)p_configSubViews {
    [self setupBarCollectionView];
}

- (void)setupBarCollectionView {
    ECBarCollectionView *collectionView =[ECBarCollectionView collectionView];
    [collectionView setBackgroundColor:[UIColor whiteColor]];
    collectionView.frame = CGRectMake(0, 0, ECScreenW, 210);
    [collectionView reset:10];
    [self addSubview:collectionView];
    self.collectionView = collectionView;
}

@end
