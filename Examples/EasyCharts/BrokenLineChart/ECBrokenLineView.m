//  ************************************************************************
//
//  ECBrokenLineView.m
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

#import "ECBrokenLineView.h"
#import "ECBrokenLineCenterCollectionView.h"
#import "ECBrokenLineNormalCollectionView.h"
#import "ECBrokenLineCenterBackgroundView.h"
#import "ECBrokenLinePointModel.h"
#import "ECBrokenLineNormalBackgroundView.h"
#import "ECBrokenLineCollectionView.h"
#import "ECBrokenLineConfig.h"

@interface ECBrokenLineView ()<ECBrokenLineCollectionViewDataSource,
                               ECBrokenLineCollectionViewDelegate>

@property (nonatomic, strong) ECBrokenLineCollectionView *lineCollectionView;
@property (nonatomic, copy) NSArray <ECBrokenLinePointModel *>*pointModelList;
@property (nonatomic, assign) CGSize lineViewSize;
@property (nonatomic, strong) ECBrokenLineConfig *brokenLineConfig;
@property (nonatomic, assign) BrokenLineType brokenLineType;

@end

@implementation ECBrokenLineView

- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}

//+ (instancetype)lineViewWithFrame:(CGRect) frame {
//    ECBrokenLineView *lineView = [[self alloc] init];
//    lineView.brokenLineType = BrokenLineTypeMiddlePoint;
//    lineView.brokenLineConfig = nil;
//    lineView.frame = frame;
//    [lineView setupSubviews];
//    return lineView;
//}

+ (instancetype)lineViewWithFrame:(CGRect) frame
              withBrokenLineConfig:(ECBrokenLineConfig *)brokenLineConfig
                    brokenLineType:(BrokenLineType)brokenLineType {
    
    ECBrokenLineView *lineView = [[self alloc] init];
    lineView.brokenLineType = brokenLineType;
    lineView.brokenLineConfig = brokenLineConfig;
    lineView.frame = frame;
    [lineView setupSubviews];
    return lineView;
}

- (void)setupSubviews {
    if (self.brokenLineType == BrokenLineTypeMiddlePoint) {
        [self setupCenterCollectionViewBackgroundView];
        [self setupCenterCollectionView];
    } else {
        [self setupNormalCollectionViewBackgroundView];
        [self setupNormalCollectionView];
    }
}

- (void)setupNormalCollectionViewBackgroundView {
    ECBrokenLineNormalBackgroundView *backgroupView =
    [ECBrokenLineNormalBackgroundView lineBackgroundViewWithFrame:self.bounds
                                             withBrokenLineConfig:self.brokenLineConfig];
    [self addSubview:backgroupView];
}

- (void)setupNormalCollectionView {
    ECBrokenLineNormalCollectionView *lineCollectionView =
    [ECBrokenLineNormalCollectionView collectionViewWithFrame:self.frame
                                        withBrokenLineConfig:self.brokenLineConfig];
    lineCollectionView.drawLineDataSource = self;
    lineCollectionView.drawLineDelegate = self;
    self.lineCollectionView = lineCollectionView;
    [self addSubview:lineCollectionView];
}

- (void)setupCenterCollectionView  {
    ECBrokenLineCenterCollectionView *lineCollectionView =
    [ECBrokenLineCenterCollectionView collectionViewWithFrame:self.frame withBrokenLineConfig:self.brokenLineConfig];
    lineCollectionView.drawLineDataSource = self;
    lineCollectionView.drawLineDelegate = self;
    self.lineCollectionView = lineCollectionView;
    [self addSubview:lineCollectionView];
}

- (void)setupCenterCollectionViewBackgroundView {
    ECBrokenLineCenterBackgroundView *backgroupView =
    [ECBrokenLineCenterBackgroundView backgroundViewWithFrame:self.frame];
    [self addSubview:backgroupView];
}

#pragma ECBrokenLineCollectionViewDelegate
- (void)collectionViewPointYList:(ECBrokenLineCollectionView *)collectionView
        didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_delegate && [_delegate respondsToSelector:@selector(brokenLineView:selectedAtIndexPath:)]) {
        [_delegate brokenLineView:self selectedAtIndexPath:indexPath];
    }
}

#pragma ECBrokenLineCollectionViewDataSource
- (NSArray *)collectionViewPointYList:(ECBrokenLineCenterCollectionView *)collectionView {
    return self.pointModelList;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat itemW = self.frame.size.width * 0.2 + 0.2;
    return CGSizeMake(itemW, self.frame.size.height);
}

- (void)reloadLineViewDataWithPointValveList:(NSArray *)pointValueList
                                   titleText:(NSArray *)titleTextList{
    [self computerAndCombinationModelListWithPointValveList:pointValueList
                                                  titleText:titleTextList];
    [self.lineCollectionView reloadCollectionData];
}

#pragma mark - computer pointY
- (void)computerAndCombinationModelListWithPointValveList:(NSArray *)pointValueList
                                                titleText:(NSArray *)titleTextList {
    NSMutableArray *modelMutableArray = [NSMutableArray array];
    for (int i = 0; i < [pointValueList count]; i++) {
        NSString *numString = pointValueList[i];
        NSString *lastNumString = [self numStringWithIndex:i - 1 pointValveList:pointValueList];
        NSString *nextNumString = [self numStringWithIndex:i + 1 pointValveList:pointValueList];;
        
        ECBrokenLinePointModel *pointModel = [[ECBrokenLinePointModel alloc] init];
        pointModel.leftLineType = [self lineTypeWithNumString:numString nearNumString:lastNumString];
        pointModel.rightLineType = [self lineTypeWithNumString:numString nearNumString:nextNumString];
        
        if ([numString floatValue] > self.brokenLineConfig.maxValue) {
            pointModel.pointY = [NSString stringWithFormat:@"%f",self.brokenLineConfig.maxValue];
        } else if ([numString floatValue] < self.brokenLineConfig.minValue) {
            pointModel.pointY = [NSString stringWithFormat:@"%f",self.brokenLineConfig.minValue];
        } else {
            pointModel.pointY = [NSString stringWithFormat:@"%f",[numString floatValue]];
        }
        
        pointModel.titleText = titleTextList[i];
        pointModel.pointY = [NSString stringWithFormat:@"%f",15 + (1 - (([pointModel.pointY floatValue] - self.brokenLineConfig.minValue)/(self.brokenLineConfig.maxValue - self.brokenLineConfig.minValue))) * (self.frame.size.height - 40)];
        [modelMutableArray addObject:pointModel];
    }
    self.pointModelList = [modelMutableArray copy];
}

- (LineType)lineTypeWithNumString:(NSString *) numString nearNumString:(NSString *) nearNumString{
    if (nearNumString == nil) {
        return  LineTypeNoline;
    } else if ([self isDottedLineWithNumString:numString nearNumString:nearNumString]) {
        return LineTypeDotted;
    } else {
        return LineTypeNormal;
    }
    
}

- (BOOL)isDottedLineWithNumString:(NSString *) numString nearNumString:(NSString *) nearNumString {
    return [nearNumString floatValue] > self.brokenLineConfig.maxValue ||
            [nearNumString floatValue] < self.brokenLineConfig.minValue ||
            [numString floatValue] > self.brokenLineConfig.maxValue ||
            [numString floatValue] < self.brokenLineConfig.minValue;
}

- (NSString *)numStringWithIndex:(NSInteger)index
                  pointValveList:(NSArray *)pointValueList{
    if (index < 0 || index >= [pointValueList count]) {
        return nil;
    } else {
        return pointValueList[index];
    }
}

- (NSArray<ECBrokenLinePointModel *> *)pointModelList {
    if (_pointModelList == nil) {
        _pointModelList = [NSArray array];
    }
    return _pointModelList;
}

- (ECBrokenLineConfig *)brokenLineConfig {
    if (_brokenLineConfig == nil) {
        _brokenLineConfig = [ECBrokenLineConfig configWithBrokenLineType:self.brokenLineType];
    }
    return _brokenLineConfig;
}

@end
