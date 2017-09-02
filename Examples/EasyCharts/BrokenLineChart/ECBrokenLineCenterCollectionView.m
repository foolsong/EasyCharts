//  ************************************************************************
//
//  ECBrokenLineCenterCollectionView.h
//  EasyCharts
//
//  Created by 宋永建 on 2017/4/24.
//  Copyright © 2017年 宋永建. All rights reserved.
//
//  Main function:
//
//  Other specifications:
//
//  ************************************************************************

#import "ECBrokenLineCenterCollectionView.h"
#import "ECBrokenLineCollectionViewCell.h"
#import "ECBrokenLinePointModel.h"
#import "ECCommon.h"
#import "ECBrokenLineConfig.h"

#define ScreenW [UIScreen mainScreen].bounds.size.width

@interface ECBrokenLineCenterCollectionView ()<UICollectionViewDelegate,
                                   UICollectionViewDataSource>

@property (nonatomic, strong) ECBrokenLineCollectionViewCell *currentCell;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, assign) CGFloat cellWidth;

@property (nonatomic, assign) BOOL isNeedSettingLastCell;

@property (nonatomic, strong) ECBrokenLineConfig *brokenLineConfig;

@end

@implementation ECBrokenLineCenterCollectionView

+ (instancetype)collectionViewWithFrame:(CGRect)frame
                   withBrokenLineConfig:(ECBrokenLineConfig *)brokenLineConfig {
    DrawLineCollectionViewFlowLayout *layout = [self collectionViewFlowLayout];
    ECBrokenLineCenterCollectionView *collectionView =
    [[self alloc]initWithFrame:CGRectMake(0, 0,frame.size.width ,frame.size.height)
          collectionViewLayout:layout];
    collectionView.brokenLineConfig = brokenLineConfig;
    __weak typeof(collectionView) weakself = collectionView;
    layout.indexBlock = ^(NSInteger index){
        weakself.currentIndex = index;
        [weakself didSelectItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    };
    
    [collectionView registerClass:[ECBrokenLineCollectionViewCell class] forCellWithReuseIdentifier:@"ECBrokenLineCollectionViewCell"];
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
- (void)reloadCollectionData {
    [self reloadData];
    [self scrollToRightmostCell];
}

- (void)scrollToRightmostCell {
    CGFloat offsetX = ([[self pointModelList] count] - 3) * self.cellWidth + 0.2 * 2;
    self.contentOffset = CGPointMake(offsetX, 0);
    self.currentIndex = [[self pointModelList] count] - 1;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{
        [self setupCellSelected];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{
        [self didSelectItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    });
}

- (void)setupCellSelected {
    NSInteger index = 0;
    if (self.currentIndex == 0) {
        index = 0;
    } else if (self.currentIndex == 1) {
        index = 1;
    } else {
        index = 2;
    }
    
    if ([self.visibleCells count] > 5) {
        index = 3;
    }
    
    if ([self.visibleCells count] < index) {
        return;
    }
    [self p_setupCellUnSelected];
    
    NSArray *visibleCellIndex = [self visibleCells];
    NSArray *sortedIndexPaths =
        [visibleCellIndex sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSIndexPath *path1 = (NSIndexPath *)[self indexPathForCell:obj1];
        NSIndexPath *path2 = (NSIndexPath *)[self indexPathForCell:obj2];
        return [path1 compare:path2];
    }];
    
    if (index >= [sortedIndexPaths count]) {
        return;
    }
    
    self.currentCell = sortedIndexPaths[index];
    [self.currentCell setupCellSelected:YES];
}

- (void)p_setupCellUnSelected {
    if (self.currentCell) {
        [self.currentCell setupCellSelected:NO];
    }
}

- (void)p_configOwnProperties {
    self.backgroundColor = [UIColor clearColor];
    self.delegate = self;
    self.dataSource = self;
    self.scrollsToTop = NO;
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    
    self.contentInset = UIEdgeInsetsMake(0, self.cellWidth * 2 , 0, self.cellWidth * 2);
}

- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_drawLineDelegate && [_drawLineDelegate respondsToSelector:@selector(collectionViewPointYList:
                                                                             didSelectItemAtIndexPath:)]) {
        [_drawLineDelegate collectionViewPointYList:self didSelectItemAtIndexPath:indexPath];
    }
}

#pragma mark - CollectionViewFlowLayout
+ (DrawLineCollectionViewFlowLayout *)collectionViewFlowLayout {
    DrawLineCollectionViewFlowLayout *layout = [DrawLineCollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    return layout;
}

#pragma mark - UICollectionViewDataSource
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self setupCellSelected];
}

-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    [self p_setupCellUnSelected];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return [[self pointModelList] count];
}

- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                   cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ECBrokenLineCollectionViewCell *cell =
        [collectionView dequeueReusableCellWithReuseIdentifier:@"ECBrokenLineCollectionViewCell"
                                                  forIndexPath:indexPath];
    [cell setItemSize:[self sizeForItemAtIndexPath:indexPath]];
    [cell setupBrokenLineConfig:self.brokenLineConfig];
    
    if ([[self pointModelList] count] - 1 == indexPath.row && self.isNeedSettingLastCell) {
        self.isNeedSettingLastCell = NO;
        [self p_setupCellUnSelected];
        self.currentCell = cell;
        self.currentIndex = indexPath.row;
        [self.currentCell setupCellSelected:YES];
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self sizeForItemAtIndexPath:indexPath];
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (void)collectionView:(UICollectionView *)collectionView
       willDisplayCell:(UICollectionViewCell *)cell
    forItemAtIndexPath:(NSIndexPath *)indexPath {
    
//    [(DrawLineCollectionViewCell *)cell setupDrawConfig:self.drawConfig];
    [(ECBrokenLineCollectionViewCell *)cell configureCellWithPointYList:[self pointModelList]
                                                              withIndex:indexPath.row];
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat offsetX = (indexPath.row - 2) * self.cellWidth + 0.2 * 2;
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.contentOffset = CGPointMake(offsetX, 0);
                     } completion:^(BOOL finished) {
                         if (self.currentIndex != indexPath.row) {
                             [self p_setupCellUnSelected];
                             self.currentIndex = indexPath.row;
                             [self setupCellSelected];
                         }
                     }];
    
    if (_drawLineDelegate && [_drawLineDelegate respondsToSelector:@selector(collectionViewPointYList:
                                                                             didSelectItemAtIndexPath:)]) {
        [_drawLineDelegate collectionViewPointYList:self didSelectItemAtIndexPath:indexPath];
    }
}

- (NSArray *)pointModelList {
    NSArray * pointModelList;
    if (_drawLineDataSource && [_drawLineDataSource respondsToSelector:@selector(collectionViewPointYList:)]) {
        pointModelList = [_drawLineDataSource collectionViewPointYList:self];
    } else {
        NSAssert(NO, @"添加数据源");
    }
    return pointModelList;
}

- (CGSize)sizeForItemAtIndexPath:(NSIndexPath *)indexPath  {
    if (_drawLineDataSource &&
        [_drawLineDataSource respondsToSelector:@selector(collectionView:
                                                          sizeForItemAtIndexPath:)]) {
        return [_drawLineDataSource collectionView:self sizeForItemAtIndexPath:indexPath];
    }
    NSAssert(NO, @"需添加折线图的size");
    return CGSizeZero;
}

- (CGFloat)cellWidth {
    return self.frame.size.width * 0.2 + 0.2;
}

@end
#pragma mark - collectionView 的 flowLayout
/**
 collectionView 的 flowLayout
 */
@interface DrawLineCollectionViewFlowLayout()

@end

@implementation DrawLineCollectionViewFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset
                                 withScrollingVelocity:(CGPoint)velocity {
    //获取期望滑到的位置的点的x值
    CGFloat proposedOffsetX =
        [super targetContentOffsetForProposedContentOffset:proposedContentOffset
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
    NSInteger blockIndex = (proposedOffsetX + centerDiff) /
        (self.collectionView.bounds.size.width * 0.2 + 0.2) + 2.1;

    _indexBlock(blockIndex);
    return CGPointMake(proposedOffsetX + centerDiff, 0);
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

@end

