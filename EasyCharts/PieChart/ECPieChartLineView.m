//  ************************************************************************
//
//  DrawCircleLineView.m
//  EasyCharts
//
//  Created by 宋永建 on 2017/6/12.
//  Copyright © 2017年 Global. All rights reserved.
//
//  Main function:
//
//  Other specifications:
//
//  ************************************************************************

#import "ECPieChartLineView.h"
#import "ECPieChartModel.h"

@interface ECPieChartLineView ()

@property (nonatomic, strong) NSMutableArray *layerMutableList;

@property (nonatomic, strong) NSMutableArray *labelList;

@end

@implementation ECPieChartLineView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (void)setupLabel:(ECPieChartModel *)model {
    CGRect frame;
    if (model.arcCenterQuadrant == ArcCenterQuadrantFourth || model.arcCenterQuadrant == ArcCenterQuadrantFirst) {
        frame = CGRectMake(model.textLeftCenterPoint.x + 4, model.textLeftCenterPoint.y - 11, 32, 22);
    } else {
        frame = CGRectMake(model.textLeftCenterPoint.x + 4 - 32, model.textLeftCenterPoint.y - 11, 32, 22);
    }
    
    UILabel *label = [[UILabel alloc] init];
    [label setFont:[UIFont systemFontOfSize:13]];
    label.frame = frame;
    [label setText:model.arcText];
    [label setTextColor:model.circleColor];
    [self.labelList addObject:label];
    [self addSubview:label];
}

- (void)resetLine:(NSArray *)circleModelList {
    [self clearLayerList];
    [self drawHalvingLine:circleModelList];
    [self drawDescriptionLabel:circleModelList];
}

- (void)drawHalvingLine:(NSArray *)circleModelList {
    for (int i = 0; i < [circleModelList count]; i ++) {
        ECPieChartModel *model = circleModelList[i];
        if (model.arcPercent >= 1) {
            break;
        }
        [self drawCircleWithLineWidth:49
                            lineColor:[UIColor whiteColor]
                               radius:57
                               startA:model.startAngle
                                 endA:model.startAngle + 0.02];
    }
}

- (void)drawDescriptionLabel:(NSArray *)circleModelList {
    for (int i = 0; i < [circleModelList count]; i ++) {
        ECPieChartModel *model = circleModelList[i];
        [self drawLine:model];
        [self setupLabel:model];
    }
}

- (void)clearLayerList {
    for (CAShapeLayer *layer in self.layerMutableList) {
        [layer removeFromSuperlayer];
    }
    for (UILabel *label in self.labelList) {
        [label removeFromSuperview];
    }
    
    [self.labelList removeAllObjects];
    [self.layerMutableList removeAllObjects];
}

- (void)drawLine:(ECPieChartModel *)model{
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    [linePath moveToPoint:model.textLeftCenterPoint];
    [linePath addLineToPoint:model.inflectionPoint];
    [linePath addLineToPoint:model.arcCenterPoint];
    
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    
    lineLayer.lineWidth = 2 * ((1 / [UIScreen mainScreen].scale) / 2);
    lineLayer.strokeColor = model.circleColor.CGColor;
    lineLayer.path = linePath.CGPath;
    lineLayer.fillColor = nil; // 默认为blackColor
    [self.layerMutableList addObject:lineLayer];
    [self.layer addSublayer:lineLayer];
}

- (CAShapeLayer *)drawCircleWithLineWidth:(CGFloat )lineWidth
                                lineColor:(UIColor *)color
                                   radius:(CGFloat )radius
                                   startA:(CGFloat )startA
                                     endA:(CGFloat )endA {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.bounds;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.arcCenter radius:radius startAngle:startA endAngle:endA clockwise:YES];
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = lineWidth;
    shapeLayer.lineCap = kCALineCapButt;
    shapeLayer.strokeColor = color.CGColor;
    [self.layerMutableList addObject:shapeLayer];
    [self.layer addSublayer:shapeLayer];
    return shapeLayer;
}

-(NSMutableArray *)layerMutableList {
    if (_layerMutableList == nil) {
        _layerMutableList = [NSMutableArray array];
    }
    return _layerMutableList;
}

- (NSMutableArray *)labelList {
    if (_labelList == nil) {
        _labelList = [NSMutableArray array];
    }
    return _labelList;
}

@end
