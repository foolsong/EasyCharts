//  ************************************************************************
//
//  DrawBarCollectionViewCell.m
//  DrawByCollectionView
//
//  Created by 宋永建 on 2017/6/9.
//  Copyright © 2017年 宋永建. All rights reserved.
//
//  Main function:
//
//  Other specifications:
//
//  ************************************************************************

#import "ECBarCollectionViewCell.h"

@interface ECBarCollectionViewCell()

@property (nonatomic, strong) CAShapeLayer *lastWeekLayer;
@property (nonatomic, strong) CAShapeLayer *currentWeekLayer;

@end

@implementation ECBarCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        
    }
    return self;
}

- (void)reset {
    [self.lastWeekLayer removeFromSuperlayer];
    [self.currentWeekLayer removeFromSuperlayer];
    [self p_addBarLayerToLayer];
}


- (void)p_addBarLayerToLayer {
    CGFloat centerX = self.frame.size.width / 2.0;
    CGFloat margin = 15;
    
    
    UIColor *lastWeekColor = [UIColor colorWithRed:(255)/255.0 green:(179)/255.0 blue:(0)/255.0 alpha:1.0];
    UIColor *currentWeekColor = [UIColor colorWithRed:(255)/255.0 green:(133)/255.0 blue:(133)/255.0 alpha:1.0];
    self.lastWeekLayer = [self generateMaskLayerWithColor:lastWeekColor
                                                             x:(centerX - margin)
                                                        height:200 * (arc4random_uniform(100) / 100.0)];
    self.currentWeekLayer = [self generateMaskLayerWithColor:currentWeekColor
                                                             x:(centerX + margin)
                                                        height:200 * (arc4random_uniform(100) / 100.0)];
    
    [self.contentView.layer addSublayer:self.lastWeekLayer];
    [self.contentView.layer addSublayer:self.currentWeekLayer];
}

- (CAShapeLayer *)generateMaskLayerWithColor:(UIColor *)color
                                           x:(CGFloat)x
                                      height:(CGFloat)height{
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = self.bounds;
    CGFloat lineWidth = 32 *0.5;
    
    UIBezierPath *bar = [UIBezierPath bezierPath];
    [bar moveToPoint:CGPointMake(x, 200)];
    [bar addLineToPoint:CGPointMake(x, 200 - height)];
    
    layer.path = bar.CGPath;
    layer.lineWidth = lineWidth;
    layer.fillColor = color.CGColor;
    layer.strokeColor = color.CGColor;
    layer.lineCap = kCALineCapButt;
    
    return layer;
}


@end
