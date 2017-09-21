//
//  ECRadarChartShineLayer.h
//  Examples
//
//  Created by 宋永建 on 2017/9/20.
//  Copyright © 2017年 Global. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface ECRadarChartShineLayer : CALayer

@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) CGFloat fromValueForRadius;
@property (nonatomic, assign) CGFloat fromValueForAlpha;
@property (nonatomic, assign) CGFloat keyTimeForHalfOpacity;
@property (nonatomic, assign) NSTimeInterval animationDuration;
@property (nonatomic, assign) NSTimeInterval pulseInterval;
@property (nonatomic, assign) float animationRepeatCount;
@property (nonatomic, assign) BOOL useTimingFunction;

- (id)initWithRepeatCount:(float)repeatCount;


@end
