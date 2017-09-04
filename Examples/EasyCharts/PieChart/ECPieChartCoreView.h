//
//  ECPieChartCoreView.h
//  EasyCharts
//
//  Created by yjsong on 17/5/7.
//  Copyright © 2017年 Global. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ECPieChartCoreView : UIView

@property (nonatomic, assign) CGPoint arcCenter;

- (void)resetCircleList:(NSArray *)circleModelList;

@end
