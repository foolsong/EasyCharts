//
//  ECBrokenLinePointModel.m
//  EasyCharts
//
//  Created by yjsong on 17/4/30.
//  Copyright © 2017年 宋永建. All rights reserved.
//

#import "ECBrokenLinePointModel.h"

@interface ECBrokenLinePointModel ()

@end

@implementation ECBrokenLinePointModel

- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%lu    %lu     %@",(unsigned long)_leftLineType,(unsigned long)_rightLineType,_pointY];
}

@end
