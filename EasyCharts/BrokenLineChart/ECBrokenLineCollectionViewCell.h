//
//  ECBrokenLineCollectionViewCell.h
//  EasyCharts
//
//  Created by 宋永建 on 2017/4/24.
//  Copyright © 2017年 Global. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ECBrokenLineConfig;
@interface ECBrokenLineCollectionViewCell : UICollectionViewCell

- (void)configureCellWithPointYList:(NSArray *)pointXList
                          withIndex:(NSInteger)index;
- (void)setItemSize:(CGSize)size;
- (void)setupCellSelected:(BOOL)selected;

- (void)setupBrokenLineConfig:(ECBrokenLineConfig *)brokenLineConfig;

@end
