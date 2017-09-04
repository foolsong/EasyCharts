//  ************************************************************************
//
//  BrokenLineBackgroundView.m
//  DrawByCollectionView
//
//  Created by 宋永建 on 2017/8/26.
//  Copyright © 2017年 Global. All rights reserved.
//
//  Main function:
//
//  Other specifications:
//
//  ************************************************************************

#import "ECBrokenLineNormalBackgroundView.h"
#import "ECBrokenLineConfig.h"

#define INTERVAL_TEXT_LEFT_MARGIN 10.0
#define INTERVAL_TEXT_MAX_WIDTH 100.0

@interface ECBrokenLineNormalBackgroundView ()

@property (nonatomic, strong) ECBrokenLineConfig *brokenLineConfig;

@end

@implementation ECBrokenLineNormalBackgroundView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self){
        [self setContentMode:UIViewContentModeRedraw];
    }
    return self;
}

+ (instancetype)lineBackgroundViewWithFrame:(CGRect)frame
                             withBrokenLineConfig:(ECBrokenLineConfig *)brokenLineConfig {
    ECBrokenLineNormalBackgroundView *lineBackgroundView = [[self alloc] initWithFrame:frame];
    lineBackgroundView.brokenLineConfig = brokenLineConfig;
    return lineBackgroundView;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIBezierPath *boundsPath = [UIBezierPath bezierPathWithRect:self.bounds];
    CGContextSetFillColorWithColor(context, [[UIColor whiteColor] CGColor]);
    [boundsPath fill];
    
    CGFloat maxHeight = [self viewHeight];
    [[UIColor redColor]setStroke];
    UIBezierPath *gridLinePath = [UIBezierPath bezierPath];
    CGPoint startPoint = CGPointMake(35.0,CGRectGetHeight([self frame]) - 25);
    CGPoint endPoint = CGPointMake(CGRectGetMaxX(rect), CGRectGetHeight([self frame]) - 25);
    [gridLinePath moveToPoint:startPoint];
    [gridLinePath addLineToPoint:endPoint];
    [gridLinePath setLineWidth:0.6];
    
    CGContextSaveGState(context);
    
    NSUInteger numberOfIntervalLines = [self.brokenLineConfig numberOfIntervalLines];
    CGFloat intervalSpacing = (maxHeight/(numberOfIntervalLines-1));
    
    CGFloat maxIntervalValue = [self.brokenLineConfig maxValue];
    CGFloat minIntervalValue = [self.brokenLineConfig minValue];
    CGFloat maxIntervalDiff = (maxIntervalValue - minIntervalValue) / (numberOfIntervalLines-1);
    
    for(NSUInteger i = 0;i<numberOfIntervalLines;i++) {
        [self.brokenLineConfig.backVeiwLineColor setStroke];
        [gridLinePath stroke];
        NSString *stringToDraw = [NSString stringWithFormat:@"%.f",minIntervalValue + i * maxIntervalDiff];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
        [paragraphStyle setLineBreakMode:NSLineBreakByTruncatingTail];
        
        [stringToDraw drawInRect:CGRectMake(INTERVAL_TEXT_LEFT_MARGIN,
                                            (CGRectGetHeight([self frame]) - 20 - [[UIFont systemFontOfSize:16] lineHeight]),
                                            INTERVAL_TEXT_MAX_WIDTH, [[UIFont systemFontOfSize:16] lineHeight])
                  withAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14],
                                   NSForegroundColorAttributeName: self.brokenLineConfig.backVeiwTextColor,
                                   NSParagraphStyleAttributeName: paragraphStyle
                                   }];
        
        CGContextTranslateCTM(context, 0.0, - intervalSpacing);
    }
    
    CGContextRestoreGState(context);
}

- (CGFloat)viewHeight{
    UIFont *font = [UIFont systemFontOfSize:16];
    CGFloat maxHeight = round(CGRectGetHeight([self frame]) - [font lineHeight] - 23);
    return maxHeight;
}

@end
