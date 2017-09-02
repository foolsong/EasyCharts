//
//  ECBrokenLineNormalCollectionView.h
//  EasyCharts
//
//  Created by 宋永建 on 2017/8/26.
//  Copyright © 2017年 宋永建. All rights reserved.
//

#import "ECBrokenLineCollectionView.h"
#import "ECBrokenLineProtocol.h"

@class ECBrokenLineNormalCollectionView,ECBrokenLineConfig;

@interface ECBrokenLineNormalCollectionView : ECBrokenLineCollectionView <ECBrokenLineProtocol>

@property (nonatomic, weak) id<ECBrokenLineCollectionViewDataSource> drawLineDataSource;
@property (nonatomic, weak) id<ECBrokenLineCollectionViewDelegate> drawLineDelegate;

+ (instancetype)collectionViewWithFrame:(CGRect)frame
                   withBrokenLineConfig:(ECBrokenLineConfig *)brokenLineConfig;

@end


typedef  void (^ScrollIndexBlock)(NSInteger);


@interface ECBrokenLineNormalCollectionViewFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, copy) ScrollIndexBlock indexBlock;

@end
