//  ************************************************************************
//
//  ECPieChartModel.m
//  EasyCharts
//
//  Created by 宋永建 on 2017/6/10.
//  Copyright © 2017年 宋永建. All rights reserved.
//
//  Main function:
//
//  Other specifications:
//
//  ************************************************************************

#import "ECPieChartModel.h"
#define ScreenW [UIScreen mainScreen].bounds.size.width

@interface ECPieChartModel ()

@property (nonatomic, assign) CGFloat offset;

@end

@implementation ECPieChartModel

+ (instancetype)circleModelWithSrartAngle:(CGFloat)startAngle
                               arcPercent:(NSNumber *) arcPercent
                                    color:(UIColor *)color
                                  arcText:(NSString *)arcText
                                arcCenter:(CGPoint)arcCenter {
    ECPieChartModel *model = [[self alloc] init];
    model.arcCenter = arcCenter;
    model.circleColor = color;
    model.arcPercent = [arcPercent floatValue];
    model.startAngle = startAngle;
    model.arcText = arcText;
    [model computerEndAngle];
    [model computerArcCenterPoint];
    [model computerLinePoint];
    
    return model;
}

- (void)computerEndAngle {
    self.endAngle = _startAngle + 2 * M_PI * _arcPercent;
    _offset = 10;
}

- (void)computerArcCenterPoint {
    CGFloat pointY = self.arcCenter.y + 76.5 * sin(_endAngle - (M_PI * _arcPercent));
    CGFloat pointX = self.arcCenter.x + 76.5 * cos(_endAngle - (M_PI * _arcPercent));
    self.arcCenterPoint = CGPointMake(pointX, pointY);
}

- (void)computerLinePoint {
    if (self.arcCenterPoint.x >= self.arcCenter.x  && self.arcCenterPoint.y <= self.arcCenter.y) {
        [self fourthQuadrant];
        self.arcCenterQuadrant = ArcCenterQuadrantFourth;
    } else if (self.arcCenterPoint.x > self.arcCenter.x  && self.arcCenterPoint.y > self.arcCenter.y) {
        [self firstQuadrant];
        self.arcCenterQuadrant = ArcCenterQuadrantFirst;
    } else  if (self.arcCenterPoint.x <= self.arcCenter.x  && self.arcCenterPoint.y >= self.arcCenter.y) {
        [self secondQuadrant];
        self.arcCenterQuadrant = ArcCenterQuadrantSecond;
    } else {
        [self thirdQuadrant];
        self.arcCenterQuadrant = ArcCenterQuadrantThird;
    }
}

- (void)resetLinePositionWithLastPointY:(CGFloat)pointY {
    CGFloat currentPointY = 0;//= self.textLeftCenterPoint.y;
    if (self.arcCenterQuadrant == ArcCenterQuadrantFirst) {
        currentPointY = pointY + 15;
    } else if (self.arcCenterQuadrant == ArcCenterQuadrantSecond) {
        currentPointY = pointY - 15;
    } else if (self.arcCenterQuadrant == ArcCenterQuadrantThird) {
        currentPointY = pointY - 15;
    } else if (self.arcCenterQuadrant == ArcCenterQuadrantFourth) {
        currentPointY = pointY + 15;
    }
    
    self.textLeftCenterPoint = CGPointMake(self.textLeftCenterPoint.x, currentPointY);
    self.inflectionPoint = CGPointMake(self.inflectionPoint.x, self.textLeftCenterPoint.y);
}

- (void)firstQuadrant {
    self.textLeftCenterPoint = CGPointMake(ScreenW - 64, self.arcCenterPoint.y + _offset);
    self.inflectionPoint = CGPointMake(self.arcCenterPoint.x + _offset, self.textLeftCenterPoint.y);
}

- (void)secondQuadrant {
    self.textLeftCenterPoint = CGPointMake(60, self.arcCenterPoint.y + _offset);
    self.inflectionPoint = CGPointMake(self.arcCenterPoint.x - _offset, self.textLeftCenterPoint.y);
}

- (void)thirdQuadrant {
    self.textLeftCenterPoint = CGPointMake(60, self.arcCenterPoint.y - _offset);
    self.inflectionPoint = CGPointMake(self.arcCenterPoint.x - _offset, self.textLeftCenterPoint.y);
}

- (void)fourthQuadrant {
    self.textLeftCenterPoint = CGPointMake(ScreenW - 64, self.arcCenterPoint.y - 10);
    self.inflectionPoint = CGPointMake(self.arcCenterPoint.x + 10, self.textLeftCenterPoint.y);
}
@end
