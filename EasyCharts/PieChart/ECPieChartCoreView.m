//
//  ECPieChartCoreView.m
//  EasyCharts
//
//  Created by yjsong on 17/5/7.
//  Copyright © 2017年 Global. All rights reserved.
//

#import "ECPieChartCoreView.h"
#import "ECPieChartModel.h"
#import "ECBrokenLineCircleLayer.h"

@interface ECPieChartCoreView()

@property (nonatomic, copy) NSArray *circleModelList;
@property (nonatomic, strong) NSMutableArray *layerMutableArray;

@end

@implementation ECPieChartCoreView
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
}

#pragma mark - function
- (void)resetCircleList:(NSArray *)circleModelList {
    [self clearLayerMutableArray];
    self.circleModelList = circleModelList;
    for (ECPieChartModel *model in self.circleModelList) {
        [self drawBackGroupCircle:model];
    }
}

- (void)clearLayerMutableArray {
    for (CAShapeLayer *shapeLayer in self.layerMutableArray) {
        [shapeLayer removeFromSuperlayer];
    }
    [self.layerMutableArray removeAllObjects];
}

#pragma mark - subviewsDrawCircleModel
- (void)drawBackGroupCircle:(ECPieChartModel *)model {
    [self drawCircleWithLineWidth:5.0f
                        lineColor:[model.circleColor colorWithAlphaComponent:0.4]
                           radius:35
                           startA:model.startAngle
                             endA:model.endAngle];
    [self drawCircleWithLineWidth:39.0f
                        lineColor:[model.circleColor colorWithAlphaComponent:1]
                           radius:57
                           startA:model.startAngle
                             endA:model.endAngle];
    [self drawCircleWithLineWidth:5.0f
                        lineColor:[model.circleColor colorWithAlphaComponent:0.2]
                           radius:79
                           startA:model.startAngle
                             endA:model.endAngle];
}

- (CAShapeLayer *)drawCircleWithLineWidth:(CGFloat )lineWidth
                                lineColor:(UIColor *)color
                                   radius:(CGFloat ) radius
                                   startA:(CGFloat ) startA
                                     endA:(CGFloat ) endA{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.bounds;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.arcCenter radius:radius startAngle:startA endAngle:endA clockwise:YES];
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = lineWidth;
    shapeLayer.lineCap = kCALineCapButt;
    shapeLayer.strokeColor = color.CGColor;
    [self.layerMutableArray addObject:shapeLayer];
    [self.layer addSublayer:shapeLayer];
    return shapeLayer;
}

#pragma mark - LazyLoads
- (NSArray *)circleModelList {
    if (_circleModelList == nil) {
        _circleModelList = @[];
    }
    return _circleModelList;
}

-(NSMutableArray *)layerMutableArray {
    if (_layerMutableArray == nil) {
        _layerMutableArray = [NSMutableArray array];
    }
    return _layerMutableArray;
}
@end
