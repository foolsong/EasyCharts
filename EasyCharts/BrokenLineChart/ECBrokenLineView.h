//
//  ECBrokenLineView.h
//  EasyCharts
//
//  Created by 宋永建 on 2017/4/24.
//  Copyright © 2017年 Global. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECCommon.h"

@class ECBrokenLineConfig,ECBrokenLineView;

@protocol ECBrokenLineViewDelegate <NSObject>

- (void)brokenLineView:(ECBrokenLineView *)brokenLineView
   selectedAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface ECBrokenLineView : UIView

@property (nonatomic, weak) id<ECBrokenLineViewDelegate> delegate;

+ (instancetype)lineViewWithFrame:(CGRect) frame
              withBrokenLineConfig:(ECBrokenLineConfig *)brokenLineConfig
                    brokenLineType:(BrokenLineType)brokenLineType;

/**
 Data filling

 @param pointValueList  valueList
 @param titleTextList textList
 */
- (void)reloadLineViewDataWithPointValveList:(NSArray *)pointValueList
                                   titleText:(NSArray *)titleTextList;

@end
