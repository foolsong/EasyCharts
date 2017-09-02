//
//  DrawBarCollectionView.h
//  DrawByCollectionView
//
//  Created by 宋永建 on 2017/6/9.
//  Copyright © 2017年 宋永建. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ECBarCollectionView : UICollectionView

+ (instancetype)collectionView;
- (void)reset:(NSInteger)cellCount;

@end
