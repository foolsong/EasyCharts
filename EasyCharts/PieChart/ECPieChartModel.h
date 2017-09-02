//
//  ECPieChartModel.h
//  EasyCharts
//
//  Created by 宋永建 on 2017/6/10.
//  Copyright © 2017年 宋永建. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ArcCenterQuadrant) {
    ArcCenterQuadrantFirst = 0,
    ArcCenterQuadrantSecond,
    ArcCenterQuadrantThird,
    ArcCenterQuadrantFourth
};

@interface ECPieChartModel : UIView

@property (nonatomic, assign) CGFloat startAngle;
@property (nonatomic, assign) CGFloat endAngle;
@property (nonatomic, assign) CGFloat arcPercent;
@property (nonatomic, assign) CGPoint arcCenter;

@property (nonatomic, assign) CGPoint arcCenterPoint;   // 圆弧中心点
@property (nonatomic, assign) CGPoint inflectionPoint;  // 拐点
@property (nonatomic, assign) CGPoint textLeftCenterPoint;

@property (nonatomic, assign) ArcCenterQuadrant arcCenterQuadrant;
@property (nonatomic, strong) UIColor *circleColor;
@property (nonatomic, strong) NSString *arcText;

+ (instancetype)circleModelWithSrartAngle:(CGFloat)startAngle
                               arcPercent:(NSNumber *) arcPercent
                                    color:(UIColor *)color
                                  arcText:(NSString *)arcText
                                arcCenter:(CGPoint)arcCenter;

- (void)resetLinePositionWithLastPointY:(CGFloat)pointY;
@end
