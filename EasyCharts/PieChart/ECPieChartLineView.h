//
//  DrawCircleLineView.h
//  EasyCharts
//
//  Created by 宋永建 on 2017/6/12.
//  Copyright © 2017年 宋永建. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ECPieChartLineView : UIView

- (void)resetLine:(NSArray *)circleModelList;
@property (nonatomic, assign) CGPoint arcCenter;
@end
