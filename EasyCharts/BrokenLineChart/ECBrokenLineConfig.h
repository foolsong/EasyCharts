//
//  ECBrokenLinePointModel.h
//  EasyCharts
//
//  Created by 宋永建 on 2017/8/29.
//  Copyright © 2017年 宋永建. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ECCommon.h"

@interface ECBrokenLineConfig : NSObject

@property (nonatomic, strong) UIColor *brokenLineColor;
@property (nonatomic, strong) UIColor *backVeiwLineColor;
@property (nonatomic, strong) UIColor *backVeiwTextColor;
@property (nonatomic, strong) UIColor *backVeiwBackGroupColor;
@property (nonatomic, strong) UIColor *brokenAbscissaColor;

@property (nonatomic, assign) CGFloat minValue;  //default 0
@property (nonatomic, assign) CGFloat maxValue;  //default 100

@property (nonatomic, assign) CGFloat numberOfIntervalLines; //default 5
@property (nonatomic, assign) BrokenLineType brokenLineType;


+ (instancetype)configWithBrokenLineType:(BrokenLineType)brokenLineType;

@end
