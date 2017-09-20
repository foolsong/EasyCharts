//
//  ECRadarChartConfig.m
//  Examples
//
//  Created by 宋永建 on 2017/9/20.
//  Copyright © 2017年 Global. All rights reserved.
//

#import "ECRadarChartConfig.h"

@implementation ECRadarChartConfig

- (NSInteger)backgroupLineNum {
    if (_backgroupLineNum == 0) {
        _backgroupLineNum = 1;
    }
    return _backgroupLineNum;
}

- (CGFloat)radius {
    if (_radius == 0) {
        _radius = 80;
    }
    return _radius;
}

- (UIColor *)backgroupLineColor {
    if (_backgroupLineColor == nil) {
        _backgroupLineColor = [UIColor colorWithRed:0.81 green:0.81 blue:0.81 alpha:1.0];
    }
    return _backgroupLineColor;
}

- (UIColor *)backgroupColor {
    if (_backgroupColor == nil) {
        _backgroupColor = [UIColor whiteColor];
    }
    return _backgroupColor;
}

- (NSArray *)drawPointArray {
    if (_drawPointArray == nil) {
        _drawPointArray = [NSArray array];
    }
    return _drawPointArray;
}

- (NSArray *)drawLineColorArray {
    if (_drawLineColorArray == nil) {
        _drawLineColorArray = [NSArray array];
    }
    return _drawLineColorArray;
}

- (UIColor *)titleColor {
    if (_titleColor == nil) {
        _titleColor = [UIColor colorWithRed:0.34 green:0.34 blue:0.34 alpha:1.0];
    }
    return _titleColor;
}

@end
