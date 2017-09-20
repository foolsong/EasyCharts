//
//  ECRadarChartView.h
//  Examples
//
//  Created by 宋永建 on 2017/9/20.
//  Copyright © 2017年 Global. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ECRadarChartConfig;
@interface ECRadarChartView : UIView

+ (instancetype)radarChartViewWithFrame:(CGRect) frame;
- (void)setupRadarChartConfig:(ECRadarChartConfig *)config;

@end
