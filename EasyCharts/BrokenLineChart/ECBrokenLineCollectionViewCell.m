//  ************************************************************************
//
//  ECBrokenLineCollectionViewCell.m
//  EasyCharts
//
//  Created by 宋永建 on 2017/4/24.
//  Copyright © 2017年 Global. All rights reserved.
//
//  Main function:
//
//  Other specifications:
//
//  ************************************************************************

#import "ECBrokenLineCollectionViewCell.h"
#import "ECBrokenLinePointModel.h"
#import "ECCommon.h"
#import "ECBrokenLineConfig.h"
#import "ECBrokenLineCircleLayer.h"

#define CIRCLE_SIZE 7.0

@interface ECBrokenLineCollectionViewCell ()

@property (nonatomic, assign) CGSize cellSize;

@property (nonatomic, copy) NSArray *pointYList;
@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) ECBrokenLinePointModel *pointModel;

@property (nonatomic, assign) CGContextRef context;

@property (nonatomic, strong) UIImage *circleImage;

@property (nonatomic, strong) ECBrokenLineCircleLayer *circleLayer;
@property (nonatomic, strong) ECBrokenLineCircleLayer *circleSelectedLayer;

@property (nonatomic, strong) UILabel *datelabel;

@property (nonatomic, strong) NSMutableArray *lineLayerList;

@property (nonatomic, strong) ECBrokenLineConfig *brokenLineConfig;

@end

@implementation ECBrokenLineCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setupNumLabel];
    }
    return self;
}

- (void)setupBrokenLineConfig:(ECBrokenLineConfig *)brokenLineConfig {
    self.brokenLineConfig = brokenLineConfig;
    [self.datelabel setTextColor:self.brokenLineConfig.brokenAbscissaColor];
}

- (void)configureCellWithPointYList:(NSArray *)pointYList
                          withIndex:(NSInteger)index {
    if (index > [pointYList count] - 1) {
        return;
    }
    [self clearLineLayerList];
    self.pointYList = pointYList;
    self.index = index;
    self.pointModel = self.pointYList[self.index];
    [self.datelabel setText:self.pointModel.titleText];
    
    [self drawLeftLine];
    [self drawRightLine];
    [self resetCircleLayerFrame];
}

- (void)resetCircleLayerFrame {
    CGRect frame = self.circleLayer.frame;
    frame.origin.y = [self.pointModel.pointY floatValue] - 4.25;
    frame.origin.x = self.cellSize.width * 0.5 - 4.25;
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    [self.circleLayer setFrame: frame];
    [CATransaction commit];
    
    if (_circleSelectedLayer) {
        [_circleSelectedLayer removeFromSuperlayer];
        _circleSelectedLayer = nil;
        [self p_setupCircleSelectedLayer];
    }
}

- (void)setItemSize:(CGSize)size {
    _cellSize = size;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
}

- (void)drawLeftLine {
    CGPoint firstPoint = CGPointMake(0, [self lastPointY]);
    CGPoint nextPoint = CGPointMake(self.cellSize.width * 0.5, [self currentPointY]);
    if (self.pointModel.leftLineType == LineTypeNormal) {
        [self drawLineFirstPoint:firstPoint nextPoint:nextPoint dotted:NO lineWidth:1.3];
    } else if (self.pointModel.leftLineType == LineTypeDotted) {
        [self drawLineFirstPoint:firstPoint nextPoint:nextPoint dotted:YES lineWidth:1.3];
    }
}

- (void)drawRightLine {
    CGPoint firstPoint = CGPointMake(self.cellSize.width * 0.5, [self currentPointY]);
    CGPoint nextPoint = CGPointMake(self.cellSize.width, [self nextPointY]);
    if (self.pointModel.rightLineType == LineTypeNormal) {
        [self drawLineFirstPoint:firstPoint nextPoint:nextPoint dotted:NO lineWidth:1.3];
    } else if (self.pointModel.rightLineType == LineTypeDotted) {
        [self drawLineFirstPoint:firstPoint nextPoint:nextPoint dotted:YES lineWidth:1.3];
    }
}

- (void)drawLineFirstPoint:(CGPoint)firstPoint
                 nextPoint:(CGPoint)nextPoint
                    dotted:(BOOL) dotted
                 lineWidth:(CGFloat) lineWidth{
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    [linePath moveToPoint:firstPoint];
    [linePath addLineToPoint:nextPoint];
    
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    if (dotted) {
        lineLayer.lineDashPattern = @[@5, @5];
    }
    lineLayer.lineWidth = lineWidth;
    lineLayer.strokeColor = self.brokenLineConfig.brokenLineColor.CGColor;
    lineLayer.path = linePath.CGPath;
    lineLayer.fillColor = nil; // 默认为blackColor
    [self.layer insertSublayer:lineLayer below:self.circleLayer];
    [self.lineLayerList addObject:lineLayer];
}

- (void)clearLineLayerList {
    for (CAShapeLayer *lineLayer in self.lineLayerList) {
        [lineLayer removeFromSuperlayer];
    }
    [self.lineLayerList removeAllObjects];
}

- (CGFloat)currentPointY {
    return [self.pointModel.pointY floatValue];
}

- (CGFloat)nextPointY {
    if (self.index + 1 >= [self.pointYList count]) {
        return 0;
    }
    ECBrokenLinePointModel *pointModel = self.pointYList[self.index + 1];
    return ([pointModel.pointY floatValue] + [self currentPointY]) * 0.5;
}

- (CGFloat)lastPointY {
    if (self.index - 1 < 0) {
        return 0;
    }
    ECBrokenLinePointModel *pointModel = self.pointYList[self.index - 1];
    return ([pointModel.pointY floatValue] + [self currentPointY]) * 0.5;
}


- (ECBrokenLineCircleLayer *)circleLayer {
    if (_circleLayer == nil) {
        _circleLayer =
        [ECBrokenLineCircleLayer circlePointLayerWithBrokenLineConfig:self.brokenLineConfig];
        [self.layer addSublayer:_circleLayer];
    }
    return _circleLayer;
}

- (ECBrokenLineCircleLayer *)circleSelectedLayer {
    if (_circleSelectedLayer == nil) {
        _circleSelectedLayer =
        [ECBrokenLineCircleLayer circlePointSelectedLayerWithBrokenLineConfig:self.brokenLineConfig];
    }
    return _circleSelectedLayer;
}

- (void)setupNumLabel {
    UILabel *datelabel = [[UILabel alloc] init];
    [datelabel setText:@"12.12~12.19"];
    datelabel.textAlignment = NSTextAlignmentCenter;
    datelabel.frame = CGRectMake(0, self.frame.size.height - 16, self.frame.size.width, 15);
    [datelabel setFont:[UIFont systemFontOfSize:11]];
    [datelabel setTextColor:self.brokenLineConfig.brokenAbscissaColor];
    [self addSubview:datelabel];
    self.datelabel = datelabel;
}

- (void)p_setupCircleSelectedLayer {
    CGRect frame = self.circleLayer.frame;
    frame.origin.x -= 6;
    frame.origin.y += 6;
    self.circleSelectedLayer.frame = frame;
    [self.layer addSublayer:self.circleSelectedLayer];
}

- (void)setupCellSelected:(BOOL)selected {
    if (selected) {
        [self cellSelected];
    } else {
        [self cellUnselected];
    }
}

- (void)cellSelected {
    [self p_setupCircleSelectedLayer];
    [self.datelabel setTextColor:self.brokenLineConfig.brokenLineColor];
    [self.datelabel setFont:[UIFont boldSystemFontOfSize:11]];
    
    if (self.brokenLineConfig.brokenLineType == BrokenLineTypeNormal) {
        CGPoint firstPoint = CGPointMake(self.cellSize.width * 0.5, [self currentPointY]);
        CGPoint nextPoint = CGPointMake(self.cellSize.width * 0.5, self.bounds.size.height - 25);
        [self drawLineFirstPoint:firstPoint nextPoint:nextPoint dotted:YES lineWidth:0.8];
    }
}

- (void)cellUnselected {
    if (_circleSelectedLayer) {
        [_circleSelectedLayer removeFromSuperlayer];
        _circleSelectedLayer = nil;
    }
    [self.datelabel setTextColor:self.brokenLineConfig.brokenAbscissaColor];
    [self.datelabel setFont:[UIFont systemFontOfSize:11]];
}

- (NSMutableArray *)lineLayerList {
    if (_lineLayerList == nil) {
        _lineLayerList = [NSMutableArray array];
    }
    return _lineLayerList;
}

@end
