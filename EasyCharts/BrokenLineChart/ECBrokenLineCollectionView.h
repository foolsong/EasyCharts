//
//  ECBrokenLineCollectionView.h
//  EasyCharts
//
//  Created by 宋永建 on 2017/8/30.
//  Copyright © 2017年 Global. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ECBrokenLineCollectionView,ECBrokenLineConfig;
@protocol ECBrokenLineCollectionViewDataSource <NSObject>

- (NSArray *)collectionViewPointYList:(ECBrokenLineCollectionView *)collectionView;
- (CGSize)collectionView:(ECBrokenLineCollectionView *)collectionView
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol ECBrokenLineCollectionViewDelegate <NSObject>

- (void)collectionViewPointYList:(ECBrokenLineCollectionView *)collectionView
        didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface ECBrokenLineCollectionView : UICollectionView

//+ (instancetype)collectionViewWithFrame:(CGRect)frame
//                         withDrawConfig:(ECBrokenLineConfig *)brokenLineConfig;
- (void)reloadCollectionData;

@end
