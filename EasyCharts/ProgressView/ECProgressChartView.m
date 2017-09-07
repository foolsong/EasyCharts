//  ************************************************************************
//
//  ECProgressChartView.m
//  EasyCharts
//
//  Created by 宋永建 on 2017/5/8.
//  Copyright © 2017年 Global. All rights reserved.
//
//  Main function:  进度条
//
//  Other specifications:
//
//  ************************************************************************

#import "ECProgressChartView.h"

#define ECAnimationDuration 0.4

@interface ECProgressChartView ()

@property (nonatomic, assign) CGFloat currentProgress;
@property (nonatomic, assign) CGFloat fromValue;
@property (nonatomic, assign) CGFloat toValue;

@property (nonatomic, strong) UILabel *numLabel;
@property (nonatomic, strong) CAShapeLayer *progresShapeLayer;

@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) CGPoint circleCenter;

@property (nonatomic, strong) CABasicAnimation *progressPathAnima;

@end

@implementation ECProgressChartView

- (instancetype)init {
    self = [super init];
    if (self) { 
    }
    return self;
}

+ (instancetype)progressChartViewWithFrame:(CGRect)frame {
    ECProgressChartView *chartView = [[ECProgressChartView alloc] init];
    [chartView computerRadiusAndCircleCenterWithFrame:frame];
    chartView.frame = frame;
    [chartView setupNumlabelWithFrame:frame];
    [chartView setupProperty];
    [chartView setDefaultValue];
    [chartView drawBackGroupCircle];
    return chartView;
}

- (void)setDefaultValue {
    self.fromValue = 0;
    self.toValue = 0;
    self.currentProgress = 0;
    [self resetProgress:self.currentProgress];
}

- (void)setupProperty {
    [self setBackgroundColor:[UIColor colorWithRed:(255)/255.0
                                             green:(156)/255.0
                                              blue:(14)/255.0
                                             alpha:1.0]];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self animationChangeProgress];
}

- (void)setupNumlabelWithFrame:(CGRect)frame {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width,
                                                               frame.size.height)];
    label.center = self.circleCenter;
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    self.numLabel = label;
}

#pragma mark - function
- (void)animationChangeProgress {
    self.progressPathAnima.fromValue = [NSNumber numberWithFloat:self.fromValue];
    self.progressPathAnima.toValue = [NSNumber numberWithFloat:self.toValue];
    [self.progresShapeLayer addAnimation:self.progressPathAnima forKey:@"strokeEndAnimation"];
}

- (void)resetProgress:(CGFloat)progress {
    self.fromValue =  _currentProgress ;
    self.toValue = progress;
    self.currentProgress = progress;
    [self hideProgresShapeLayerIfNeeded];
    [self.numLabel setText:[NSString stringWithFormat:@"%.0f%%",self.currentProgress * 100]];
    [self setNeedsDisplay];
}

- (void)hideProgresShapeLayerIfNeeded {
    if (self.currentProgress * 100 == 0) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(ECAnimationDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (self.currentProgress * 100 == 0) {
                self.progresShapeLayer.hidden = YES;
            }
        });
    } else {
        self.progresShapeLayer.hidden = NO;
    }
}

- (void)computerRadiusAndCircleCenterWithFrame:(CGRect) frame {
    CGFloat sideLength = frame.size.width > frame.size.height ?
                                            frame.size.height : frame.size.width;
    self.radius = (sideLength - 13) * 0.5;
    self.circleCenter = CGPointMake(frame.size.width * 0.5, frame.size.height * 0.5);
}

#pragma mark - sublayers
- (void)drawBackGroupCircle {
    UIColor *backGroupColor = [UIColor colorWithRed:(255)/255.0 green:(179)/255.0
                                               blue:(0)/255.0 alpha:0.4];
    [self drawCircleWithLineWidth:13.0f lineColor:backGroupColor];
    
    UIColor *backLinecolor = [UIColor colorWithRed:(255)/255.0 green:(209)/255.0
                                              blue:(93)/255.0 alpha:1.0];
    [self drawCircleWithLineWidth:5.0f lineColor:backLinecolor];
}

- (CAShapeLayer *)drawCircleWithLineWidth:(CGFloat)lineWidth lineColor:(UIColor *)color {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.bounds;
    CGFloat startA = -M_PI_2;
    CGFloat endA = -M_PI_2 +  M_PI * 2;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.circleCenter
                                                        radius:self.radius
                                                    startAngle:startA endAngle:endA
                                                     clockwise:YES];
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = lineWidth;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.strokeColor = color.CGColor;
    [self.layer addSublayer:shapeLayer];
    return shapeLayer;
}

#pragma mark - LazyLoads
- (CAShapeLayer *)progresShapeLayer {
    if (_progresShapeLayer == nil) {
        _progresShapeLayer = [self drawCircleWithLineWidth:5.0f
                                                 lineColor:[UIColor whiteColor]];
        _progresShapeLayer.hidden = YES;
    }
    return _progresShapeLayer;
}

- (CABasicAnimation *)progressPathAnima {
    if (_progressPathAnima == nil) {
        CABasicAnimation *pathAnima = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnima.duration = ECAnimationDuration;
        pathAnima.timingFunction =
            [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        pathAnima.fillMode = kCAFillModeForwards;
        pathAnima.removedOnCompletion = NO;
        _progressPathAnima = pathAnima;
    }
    return _progressPathAnima;
}

@end
