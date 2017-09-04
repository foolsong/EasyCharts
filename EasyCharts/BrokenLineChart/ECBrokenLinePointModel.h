//
//  ECBrokenLinePointModel.h
//  EasyCharts
//
//  Created by yjsong on 17/4/30.
//  Copyright © 2017年 Global. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LineType) {
    LineTypeNormal = 0,
    LineTypeDotted,
    LineTypeNoline
};

@interface ECBrokenLinePointModel : NSObject

@property(nonatomic, assign) LineType leftLineType;
@property(nonatomic, assign) LineType rightLineType;

@property (nonatomic, copy) NSString *pointY;

@property (nonatomic, copy) NSString *titleText;

@end
