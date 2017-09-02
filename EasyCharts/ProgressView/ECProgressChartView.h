//
//  ECProgressChartView.h
//  EasyCharts
//
//  Created by 宋永建 on 2017/5/8.
//  Copyright © 2017年 宋永建. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ECProgressChartView : UIView

+ (instancetype)progressChartViewWithFrame:(CGRect)frame;
- (void)resetProgress:(CGFloat)progress;

@end
