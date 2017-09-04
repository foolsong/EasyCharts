//
//  ECBrokenLineCircleLayer.h
//  EasyCharts
//
//  Created by 宋永建 on 2017/6/8.
//  Copyright © 2017年 Global. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@class ECBrokenLineConfig;
@interface ECBrokenLineCircleLayer : CAShapeLayer

+ (instancetype)circlePointLayerWithBrokenLineConfig:(ECBrokenLineConfig *)brokenLineConfig;
+ (instancetype)circlePointSelectedLayerWithBrokenLineConfig:(ECBrokenLineConfig *)brokenLineConfig;

@end
