//
//  EasyPieChartView.h
//  EasyCharts
//
//  Created by 宋永建 on 2017/6/14.
//  Copyright © 2017年 宋永建. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ECPieChartView : UIView

+ (instancetype)pieChartViewWithFrame:(CGRect)frame;

- (void)drawPieChartWithPercentList:(NSArray<NSNumber *> *)percentList
                          colorList:(NSArray<UIColor *> *)colorList
                        arcTextList:(NSArray<NSString *> *)arcTextList;
@end
