//
//  ECRadarChartShineLayer.m
//  Examples
//
//  Created by 宋永建 on 2017/9/20.
//  Copyright © 2017年 Global. All rights reserved.
//

#import "ECRadarChartShineLayer.h"

@interface ECRadarChartShineLayer()

@property (nonatomic, strong) CAAnimationGroup *animationGroup;

@end

@implementation ECRadarChartShineLayer

- (id)initWithRepeatCount:(float) repeatCount
{
    self = [super init];
    if (self) {
        self.contentsScale = [UIScreen mainScreen].scale;
        self.opacity = 0;
        
        // default
        self.radius = 10;
        self.fromValueForRadius = 0.0;
        self.fromValueForAlpha = 0.45;
        self.keyTimeForHalfOpacity = 0.3;
        self.animationDuration = 2;
        self.pulseInterval = 0;
        self.animationRepeatCount = repeatCount;
        self.backgroundColor = [[UIColor colorWithRed:255/255.0 green:106/255.0 blue:0/255.0 alpha:1] CGColor];
        self.useTimingFunction = YES;
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
            
            [self setupAnimationGroup];
            
            if(self.pulseInterval != INFINITY) {
                
                dispatch_async(dispatch_get_main_queue(), ^(void) {
                    
                    [self addAnimation:self.animationGroup forKey:@"pulse"];
                });
            }
        });
    }
    return self;
    
}

- (id)init {
    return [self initWithRepeatCount:INFINITY];
}

- (void)setRadius:(CGFloat)radius {
    
    _radius = radius;
    
    CGPoint tempPos = self.position;
    
    CGFloat diameter = self.radius * 2;
    
    self.bounds = CGRectMake(0, 0, diameter, diameter);
    self.cornerRadius = self.radius;
    self.position = tempPos;
}

- (void)setupAnimationGroup {
    
    
    self.animationGroup = [CAAnimationGroup animation];
    self.animationGroup.duration = self.animationDuration + self.pulseInterval;
    self.animationGroup.repeatCount = self.animationRepeatCount;
    self.animationGroup.removedOnCompletion = NO;
    if (self.useTimingFunction) {
        CAMediaTimingFunction *defaultCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
        self.animationGroup.timingFunction = defaultCurve;
    }
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.xy"];
    scaleAnimation.fromValue = @(self.fromValueForRadius);
    scaleAnimation.toValue = @1.0;
    scaleAnimation.duration = self.animationDuration;
    
    CAKeyframeAnimation *opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.duration = self.animationDuration;
    opacityAnimation.values = @[@(self.fromValueForAlpha), @0.45, @0];
    opacityAnimation.keyTimes = @[@0, @(self.keyTimeForHalfOpacity), @1];
    opacityAnimation.removedOnCompletion = NO;
    
    NSArray *animations = @[scaleAnimation, opacityAnimation];
    
    self.animationGroup.animations = animations;
}


@end
