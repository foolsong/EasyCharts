//
//  ECBrokenLineProtocol.h
//  DrawByCollectionView
//
//  Created by 宋永建 on 2017/8/30.
//  Copyright © 2017年 宋永建. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ECBrokenLineConfig;
@protocol ECBrokenLineProtocol <NSObject>

+ (id<ECBrokenLineProtocol>)collectionViewWithFrame:(CGRect)frame
                   withBrokenLineConfig:(ECBrokenLineConfig *)brokenLineConfig;
- (void)reloadCollectionData;

@end
