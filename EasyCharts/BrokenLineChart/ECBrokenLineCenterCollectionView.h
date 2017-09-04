//
//  ECBrokenLineCenterCollectionView.h
//  EasyCharts
//
//  Created by 宋永建 on 2017/4/24.
//  Copyright © 2017年 Global. All rights reserved.
//

#import "ECBrokenLineCollectionView.h"
#import "ECBrokenLineProtocol.h"

@class ECBrokenLineCenterCollectionView,ECBrokenLineConfig;

@interface ECBrokenLineCenterCollectionView : ECBrokenLineCollectionView <ECBrokenLineProtocol>

@property (nonatomic, weak) id<ECBrokenLineCollectionViewDataSource> drawLineDataSource;
@property (nonatomic, weak) id<ECBrokenLineCollectionViewDelegate> drawLineDelegate;

+ (instancetype)collectionViewWithFrame:(CGRect)frame
                   withBrokenLineConfig:(ECBrokenLineConfig *)brokenLineConfig;


@end


typedef  void (^ScrollIndexBlock)(NSInteger);

@interface DrawLineCollectionViewFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, copy) ScrollIndexBlock indexBlock;

@end
