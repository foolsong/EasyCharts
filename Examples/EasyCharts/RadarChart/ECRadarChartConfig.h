//
//  ECRadarChartConfig.h
//  Examples
//
//  Created by 宋永建 on 2017/9/20.
//  Copyright © 2017年 Global. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ECRadarChartConfig : NSObject

@property (nonatomic, assign) NSInteger backgroupLineNum;
@property (nonatomic, assign) CGFloat radius;

@property (nonatomic, strong) UIColor *backgroupLineColor;
@property (nonatomic, strong) UIColor *backgroupColor;

@property (nonatomic, strong) UIColor *titleColor;

@property (nonatomic, strong) NSArray * drawPointArray;
@property (nonatomic, strong) NSArray * drawLineColorArray;
@property (nonatomic, strong) NSArray * drawLineTitleArray;

@end
