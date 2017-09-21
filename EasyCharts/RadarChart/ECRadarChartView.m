//
//  ECRadarChartView.m
//  Examples
//
//  Created by 宋永建 on 2017/9/20.
//  Copyright © 2017年 Global. All rights reserved.
//

#import "ECRadarChartView.h"
#import "ECRadarChartShineLayer.h"
#import "ECRadarChartConfig.h"

@interface ECRadarChartView ()

@property (nonatomic, assign) CGFloat angleNum;
@property (nonatomic, strong) ECRadarChartConfig *config;

@end

@implementation ECRadarChartView

+ (instancetype)radarChartViewWithFrame:(CGRect) frame {
    ECRadarChartView *view = [[self alloc] initWithFrame:frame];
    return view;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

#pragma mark - Functions
- (void)p_configOwnProperties {
    
}

#pragma mark - HandleViews
- (void)p_configSubViews {
    for (int i = 0; i < self.config.backgroupLineNum; i++) {
        [self backgroupLineWithRadius:self.config.radius - (i * (self.config.radius / self.config.backgroupLineNum))];
    }
    
    [self backgroupStraightLine];
    
    
    for (int i = 0; i < [self.config.drawPointArray count]; i++) {
        [self radarLineWithRoleIndex:i];
    }
    
    [self setupLabels];
}


//label
- (void)setupLabels {
    
    
    
    for (NSInteger i = 0; i < self.angleNum; i++) {
        
        NSString *title = self.config.drawLineTitleArray[i];
        
        CGFloat width = [self sizeOfStringWithMaxSize:CGSizeMake(100, 20) textFont:14
                                            aimString:title].width;
        
        CGFloat radius = self.config.radius + fabs(cosf(((360.0 / self.angleNum)
                                                         * (i + 1)  + 90) * M_PI/180) * width * 0.5 ) + 10;
        
        CGPoint point = [self TTcalcCircleCoordinateWithCenter:CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5)
                                                  andWithAngle:(360.0 / self.angleNum) * (i + 1)
                                                 andWithRadius:radius];
        
        UILabel *cacheLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 20)];
        cacheLabel.font = [UIFont systemFontOfSize:14];
        cacheLabel.center = point;
        cacheLabel.text = title;
        cacheLabel.textColor = self.config.titleColor;
        [self addSubview:cacheLabel];
    }
}

// 背景网
- (void)backgroupLineWithRadius:(CGFloat)radius {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPath];
    for (NSInteger i = 0; i < self.angleNum; i++) {
        CGPoint point = [self calcCircleCoordinateWithCenter:
                         CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5)
                                                andWithAngle:(360.0/self.angleNum) * (i + 1)
                                               andWithRadius:radius];
        if (i == 0) {
            [path moveToPoint:point];
        } else {
            [path addLineToPoint:point];
        }
    }
    path.lineWidth = 0.2;
    [path closePath];
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor =  self.config.backgroupColor.CGColor;
    shapeLayer.strokeColor = self.config.backgroupLineColor.CGColor;
    [self.layer addSublayer:shapeLayer];
}

// 雷达线
- (void)radarLineWithRoleIndex:(NSUInteger) index {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    NSArray *valueList = self.config.drawPointArray[index];
    
    UIColor *lineColor = self.config.drawLineColorArray[index];
    for (NSInteger i = 0; i < self.angleNum; i++) {
        CGFloat radius = [valueList[i] floatValue] * self.config.radius;//arc4random_uniform(80) + 10;
        CGPoint point = [self calcCircleCoordinateWithCenter:CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5) andWithAngle:(360.0/self.angleNum) * (i + 1) andWithRadius:radius];
        if (i == 0) {
            [path moveToPoint:point];
        } else {
            [path addLineToPoint:point];
        }
        
        if ([self .config.drawPointArray count] <= 1) {
            ECRadarChartShineLayer *shineLayer = [ECRadarChartShineLayer layer];
            shineLayer.position = point;
            [self.layer insertSublayer:shineLayer below:shapeLayer];
        }
        
        
        CAShapeLayer *pointLayer = [self drawCircleWithLineWidth:3
                                                       lineColor:lineColor
                                                          radius:1.5];
        pointLayer.position = point;
        [self.layer addSublayer:pointLayer];
    }
    
    
    path.lineWidth = 0.2;
    [path closePath];
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor = [lineColor colorWithAlphaComponent:0.5].CGColor;
    shapeLayer.strokeColor = [lineColor colorWithAlphaComponent:0.8].CGColor;
    
    [self.layer insertSublayer:shapeLayer atIndex:6];
}


//背景直线
- (void)backgroupStraightLine {
    for (NSInteger i = 0; i < self.angleNum; i++) {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        UIBezierPath *path = [UIBezierPath bezierPath];
        CGPoint point = [self calcCircleCoordinateWithCenter:CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5) andWithAngle:(360.0/self.angleNum) * (i + 1) andWithRadius:self.config.radius];
        [path moveToPoint:CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5)];
        [path addLineToPoint:point];
        path.lineWidth = 0.2;
        [path closePath];
        shapeLayer.path = path.CGPath;
        shapeLayer.strokeColor = self.config.backgroupLineColor.CGColor;
        [self.layer addSublayer:shapeLayer];
    }
}

//  计算 以一定圆心、半径 在旋转一定角度之后的坐标
-(CGPoint) calcCircleCoordinateWithCenter:(CGPoint) center
                            andWithAngle : (CGFloat) angle
                            andWithRadius: (CGFloat) radius{
    
    
    angle += 90;
    CGFloat x2 = radius * cosf(angle * M_PI/180);
    CGFloat y2 = radius * sinf(angle * M_PI/180);
    return CGPointMake(center.x+x2, center.y-y2);
}

//  计算 以一定圆心、半径 在旋转一定角度之后的坐标
-(CGPoint) TTcalcCircleCoordinateWithCenter:(CGPoint) center
                              andWithAngle : (CGFloat) angle
                              andWithRadius: (CGFloat) radius{
    angle += 90;
    
    //    CGFloat width = [self sizeOfStringWithMaxSize:CGSizeMake(100, 20) textFont:14 aimString:@"发送到发"].width;
    
    //    radius += fabs(cosf(angle * M_PI/180) * width * 0.5 ) + 10;
    
    CGFloat x2 = radius * (cosf(angle * M_PI/180));
    CGFloat y2 = radius * (sinf(angle * M_PI/180));
    return CGPointMake(center.x+x2, center.y-y2);
}

- (CAShapeLayer *)drawCircleWithLineWidth:(CGFloat )lineWidth
                                lineColor:(UIColor *)color
                                   radius:(CGFloat ) radius {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = CGRectMake(0, 0, 0, 0);
    CGFloat startA = -M_PI_2;
    CGFloat endA = -M_PI_2 +  M_PI * 2;
    
    [shapeLayer setBackgroundColor:(__bridge CGColorRef _Nullable)([UIColor redColor])];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(0, 0)
                                                        radius:radius
                                                    startAngle:startA
                                                      endAngle:endA
                                                     clockwise:YES];
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = lineWidth;
    shapeLayer.lineCap = kCALineCapButt;
    shapeLayer.strokeColor = color.CGColor;
    [self.layer addSublayer:shapeLayer];
    return shapeLayer;
}

- (CGSize)sizeOfStringWithMaxSize:(CGSize)maxSize textFont:(CGFloat)fontSize aimString:(NSString *)aimString{
    return [[NSString stringWithFormat:@"%@",aimString] boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size;
    
}

- (CGFloat)angleNum {
    return [self.config.drawLineTitleArray count];
}

- (void)setupRadarChartConfig:(ECRadarChartConfig *)config {
    self.config = config;
    [self p_configSubViews];
}

@end
