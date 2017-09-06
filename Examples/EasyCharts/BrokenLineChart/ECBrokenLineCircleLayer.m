//  ************************************************************************
//
//  ECBrokenLineCircleLayer.m
//  EasyCharts
//
//  Created by 宋永建 on 2017/6/8.
//  Copyright © 2017年 Global. All rights reserved.
//
//  Main function:
//
//  Other specifications:
//
//  ************************************************************************

#import "ECBrokenLineCircleLayer.h"
#import <UIKit/UIKit.h>
#import "ECCommon.h"
#import "ECBrokenLineConfig.h"

#define CIRCLE_SIZE 8.5

#define SELECT_CIRCLE_SIZE 21.0

@interface ECBrokenLineCircleLayer ()

@property (nonatomic, strong) ECBrokenLineConfig *brokenLineConfig;

@end

@implementation ECBrokenLineCircleLayer

+ (instancetype)circlePointLayerWithBrokenLineConfig:(ECBrokenLineConfig *)brokenLineConfig {
    ECBrokenLineCircleLayer *circleLayer = [self layer];
    circleLayer.brokenLineConfig = brokenLineConfig;
    UIImage *img = [self circleImageWithDrawConfig:brokenLineConfig];
    [circleLayer setContents:(id)img.CGImage];
    [circleLayer setFrame:CGRectMake(0,0, img.size.width, img.size.height)];
    [circleLayer setGeometryFlipped:YES];
    [circleLayer setLineJoin:kCALineJoinBevel];
    circleLayer = circleLayer;
    return circleLayer;
}

+ (instancetype)circlePointSelectedLayerWithBrokenLineConfig:(ECBrokenLineConfig *)brokenLineConfig {
    ECBrokenLineCircleLayer *circleLayer = [self layer];
    circleLayer.brokenLineConfig = brokenLineConfig;
    [circleLayer setFrame:CGRectMake(0,0,21,21)];
    [circleLayer setGeometryFlipped:YES];
    [circleLayer setLineJoin:kCALineJoinBevel];
    [circleLayer drawBackGroupCircle];
    return circleLayer;
}

- (void)drawBackGroupCircle {
    //kColorC5_1  kColorC3_1
    [self drawCircleWithLineWidth:4.5f
                        lineColor:self.brokenLineConfig.backVeiwBackGroupColor
                           radius:2.25];
    [self drawCircleWithLineWidth:2.0f
                        lineColor:self.brokenLineConfig.brokenLineColor
                           radius:5.5];
    [self drawCircleWithLineWidth:4.0f
                        lineColor:[self.brokenLineConfig.brokenLineColor colorWithAlphaComponent:0.3]
                           radius:8.5];
}

- (CAShapeLayer *)drawCircleWithLineWidth:(CGFloat )lineWidth
                                lineColor:(UIColor *)color
                                   radius:(CGFloat ) radius {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.bounds;
    CGFloat startA = -M_PI_2;
    CGFloat endA = -M_PI_2 +  M_PI * 2;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(10.5, 10.5)
                                                        radius:radius
                                                    startAngle:startA
                                                      endAngle:endA
                                                     clockwise:YES];
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = lineWidth;
    shapeLayer.lineCap = kCALineCapButt;
    shapeLayer.strokeColor = color.CGColor;
    [self addSublayer:shapeLayer];
    return shapeLayer;
}


+ (UIImage *)circleImageWithDrawConfig:(ECBrokenLineConfig *)brokenLineConfig{
    UIImage *circleImage;
    CGSize imageSize = CGSizeMake(CIRCLE_SIZE, CIRCLE_SIZE);
    CGFloat strokeWidth = 1.5;
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [[UIColor clearColor] setFill];
    CGContextFillRect(context, (CGRect){CGPointZero, imageSize});
    
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: (CGRect){CGPointMake(strokeWidth/2.0, strokeWidth/2.0),
        CGSizeMake(CIRCLE_SIZE-strokeWidth, CIRCLE_SIZE-strokeWidth)}];
    
    CGContextSaveGState(context);
    // 圆圈填充
    UIColor *color = brokenLineConfig.backVeiwBackGroupColor;
    [color setFill];
    
    [ovalPath fill];
    CGContextRestoreGState(context);
    
    // 圆圈边框
    [brokenLineConfig.brokenLineColor setStroke];
    [ovalPath setLineWidth:strokeWidth];
    [ovalPath stroke];
    
    circleImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return circleImage;
}

//+ (UIImage *)circleSelectedImage{
//    UIImage *circleImage;
//    CGSize imageSize = CGSizeMake(SELECT_CIRCLE_SIZE, SELECT_CIRCLE_SIZE);
//    CGFloat strokeWidth = 4.0;
//
//    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);//[UIImage imageNamed:@"circle"];
//    CGContextRef context = UIGraphicsGetCurrentContext();
//
//    [[UIColor clearColor] setFill];
//    CGContextFillRect(context, (CGRect){CGPointZero, imageSize});
//
//    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: (CGRect){CGPointMake(strokeWidth/2.0, strokeWidth/2.0),
//        CGSizeMake(SELECT_CIRCLE_SIZE-strokeWidth, SELECT_CIRCLE_SIZE-strokeWidth)}];
//
//
//    UIColor *color = [UIColor colorWithRed:(255)/255.0 green:(255)/255.0 blue:(255)/255.0 alpha:0.3];
//
//    CGContextSaveGState(context);
//    //yjSong 圆圈填充
//    [color setFill];
//
//    [ovalPath fill];
//    CGContextRestoreGState(context);
//
//    // 圆圈边框
////    UIColor *color = [UIColor colorWithRed:(255)/255.0 green:(255)/255.0 blue:(255)/255.0 alpha:0.3];
//    [color setStroke];
//    [ovalPath setLineWidth:strokeWidth];
//    [ovalPath stroke];
//
//
//   UIColor *bColor = [UIColor colorWithRed:(255)/255.0 green:(209)/255.0 blue:(93)/255.0 alpha:1.0];
//        UIBezierPath* ovalPathT = [UIBezierPath bezierPathWithOvalInRect: (CGRect){CGPointMake((SELECT_CIRCLE_SIZE - 4)/2.0, (SELECT_CIRCLE_SIZE - 4)/2.0),
//            CGSizeMake(4, 4)}];
//         [ovalPath fill];
//        [bColor setStroke];
//        [ovalPathT setLineWidth:strokeWidth];
//        [ovalPathT stroke];
//
//
//
//    circleImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    //    }
//    return circleImage;
//}

@end
