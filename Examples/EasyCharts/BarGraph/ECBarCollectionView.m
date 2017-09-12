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

@property (nonatomic, assign) CGFloat cellWidth;

@end

@implementation ECBarCollectionView

+ (instancetype)collectionView {
    ECBarCollectionView *collectionView =
    [[self alloc]initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width ,210)
          collectionViewLayout:[self barCollectionViewFlowLayout]];
    CGFloat margin = CGRectGetWidth(collectionView.bounds) - (collectionView.bounds.size.width / 5.0) * 3;
//    collectionView.contentInset = UIEdgeInsetsMake(0, margin , 0, margin);
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
    
    self.contentInset = UIEdgeInsetsMake(0, self.cellWidth * 2 , 0, self.cellWidth * 2);
}

+ (ECBarCollectionViewFlowLayout *)barCollectionViewFlowLayout {
    ECBarCollectionViewFlowLayout *layout = [ECBarCollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
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
//    return CGSizeMake(87, 200);
    CGRect bounds = [UIScreen mainScreen].bounds;
//    CGFloat cellW = 150 * bounds.size.width / 375.0 / 2.0;
//    return CGSizeMake(cellW, collectionView.bounds.size.height - 1);
    
    CGFloat itemW = bounds.size.width * 0.2;
    return CGSizeMake(self.cellWidth, 200);
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    [(ECBarCollectionViewCell *)cell reset];
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat cellWidth = ([UIScreen mainScreen].bounds.size.width / 5.0);
    CGFloat offsetX = (indexPath.row - 2) * cellWidth;
    ECLog(@"%@",NSStringFromCGPoint(self.contentOffset));
    [UIView animateWithDuration:0.3 animations:^{
        self.contentOffset = CGPointMake(offsetX, 0);
    }];
}


- (void)reset:(NSInteger)cellCount {
    _cellCount = cellCount;
    [self reloadData];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.contentOffset = CGPointMake( -ScreenW * 0.5 + 87 * 0.5 * cellCount, 0);
    });
    
    ECLog(@"-----%ld -      %f",(long)cellCount,-ScreenW * 0.5 + 87 * 0.5 * cellCount);
    
//    [self layoutIfNeeded];
}

- (CGFloat)cellWidth {
    return self.frame.size.width * 0.2 + 0.2;
}


@end


@interface ECBarCollectionViewFlowLayout()

@end

@implementation ECBarCollectionViewFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset
                                 withScrollingVelocity:(CGPoint)velocity {
    //获取期望滑到的位置的点的x值
    CGFloat proposedOffsetX = [super targetContentOffsetForProposedContentOffset:proposedContentOffset
                                                           withScrollingVelocity:velocity].x;
    
    CGRect proposedRect = CGRectMake(proposedContentOffset.x,
                                     proposedContentOffset.y,
                                     self.collectionView.bounds.size.width,
                                     self.collectionView.bounds.size.height);
    
    //拿到正在显示的 cell 的 Attributes
    NSArray *proposedAttrs = [self layoutAttributesForElementsInRect:proposedRect];
    //拿到正在显示的 rect 中点
    CGFloat centerX = proposedOffsetX + self.collectionView.bounds.size.width * 0.5;
    
    CGFloat cache = CGFLOAT_MAX;
    NSInteger index = 0;
    
    for (int i = 0; i < proposedAttrs.count; i++) {
        UICollectionViewLayoutAttributes *attr = proposedAttrs[i];
        //计算 cell 距离正在显示的 rect 中点的距离
        CGFloat centerDiffABS = ABS(attr.center.x - centerX);
        //保留距离最小的 cell 作为最后要显示的cell
        if (centerDiffABS < cache) {
            cache = centerDiffABS;
            index = i;
        }
    }
    
    CGFloat centerDiff = 0;
    //拿到距离屏幕中心最近的cell
    if (proposedAttrs.count > index) {
        UICollectionViewLayoutAttributes *attr = proposedAttrs[index];
        //计算该cell的center和屏幕的center的距离 即偏移量
        centerDiff = attr.center.x - centerX;
    } else {
        centerDiff = CGFLOAT_MAX;
    }
    //返回期望滑到的点的x加偏移量
    return CGPointMake(proposedOffsetX + centerDiff, 0);
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

@end
