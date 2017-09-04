//
//  BrokenLineBackgroundView.h
//  DrawByCollectionView
//
//  Created by 宋永建 on 2017/8/26.
//  Copyright © 2017年 Global. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ECBrokenLineConfig;
@interface ECBrokenLineNormalBackgroundView : UIView

+ (instancetype)lineBackgroundViewWithFrame:(CGRect)frame
                       withBrokenLineConfig:(ECBrokenLineConfig *)brokenLineConfig;

@end
