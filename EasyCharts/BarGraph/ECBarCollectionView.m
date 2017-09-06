//  ************************************************************************
//
//  DrawBarCollectionView.m
//  DrawByCollectionView
//
//  Created by 宋永建 on 2017/6/9.
//  Copyright © 2017年 Global. All rights reserved.
//
//  Main function:
//
//  Other specifications:
//
//  ************************************************************************

#import "ECBarCollectionView.h"
#import "ECBarCollectionViewCell.h"
#import "ECCommon.h"

#define ScreenW [UIScreen mainScreen].bounds.size.width

@interface ECBarCollectionView ()<UICollectionViewDelegate,
                                  UICollectionViewDataSource>

@property (nonatomic, assign) NSInteger cellCount;

@end

@implementation ECBarCollectionView

+ (instancetype)collectionView {
    ECBarCollectionView *collectionView =
    [[self alloc]initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width ,210)
          collectionViewLayout:[self collectionViewFlowLayout]];
    [collectionView registerClass:[ECBarCollectionViewCell class] forCellWithReuseIdentifier:@"ECBarCollectionViewCell"];
    return collectionView;
}

- (instancetype)initWithFrame:(CGRect)frame
         collectionViewLayout:(nonnull UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self p_configOwnProperties];
    }
    return self;
}

#pragma mark - functions
- (void)p_configOwnProperties {
    self.backgroundColor = [UIColor clearColor];
    self.delegate = self;
    self.dataSource = self;
    self.scrollsToTop = NO;
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
}

+ (UICollectionViewFlowLayout *)collectionViewFlowLayout {
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    return layout;
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _cellCount;//[self.pointYList count];
}

- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ECBarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ECBarCollectionViewCell" forIndexPath:indexPath];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(87, 200);
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    [(ECBarCollectionViewCell *)cell reset];
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
}


- (void)reset:(NSInteger)cellCount {
    _cellCount = cellCount;
    [self reloadData];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.contentOffset = CGPointMake( -ScreenW * 0.5 + 87 * 0.5 * cellCount, 0);
    });
    
    ECLog(@"%ld -      %f",(long)cellCount,-ScreenW * 0.5 + 87 * 0.5 * cellCount);
    
//    [self layoutIfNeeded];
}

@end
