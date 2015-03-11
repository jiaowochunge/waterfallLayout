//
//  WaterfallLayout.m
//  CircleLayout
//
//  Created by bhb on 15-3-11.
//  Copyright (c) 2015年 Olivier Gutknecht. All rights reserved.
//

#import "WaterfallLayout.h"

@interface WaterfallLayout ()

//瀑布流所有单元的位置信息
@property (nonatomic, strong) NSMutableArray *frameArray;

//瀑布流每列当前高度
@property (nonatomic, strong) NSMutableArray *currentYArray;

@end

@implementation WaterfallLayout

const CGFloat DefaultCollumeGap = 10;
const CGFloat DefaultRowGap = 10;

-(void)prepareLayout
{
    [super prepareLayout];
    //初始化瀑布流列数
    if (_collumeCount == 0) {
        NSLog(@"collume count not set");
        _collumeCount = 2;
    }
    self.currentYArray = [NSMutableArray arrayWithCapacity:_collumeCount];
    for (NSUInteger i = 0; i != _collumeCount; ++i) {
        [self.currentYArray addObject:[NSNumber numberWithFloat:_sectionInset.top]];
    }
    
    if (!_collumeGap) {
        _collumeGap = DefaultCollumeGap;
    }
    if (!_rowGap) {
        _rowGap = DefaultRowGap;
    }
    
    //collectionView 宽度
    CGFloat viewWidth = self.collectionView.frame.size.width;
    //瀑布流单列宽度
    CGFloat waterfallWidth = (viewWidth - _sectionInset.left - _sectionInset.right - (_collumeCount - 1) * _collumeGap) / _collumeCount;
    
    __weak id<UICollectionViewDelegateWaterfallLayout> collectionViewDelegate = (id<UICollectionViewDelegateWaterfallLayout>)self.collectionView.delegate;
    
    NSUInteger itemCount = [self.collectionView.dataSource collectionView:self.collectionView numberOfItemsInSection:0];
    self.frameArray = [NSMutableArray arrayWithCapacity:itemCount];
    //计算瀑布流所有单元格位置
    for (NSUInteger i = 0; i != itemCount; ++i) {
        //计算当前最低瀑布流
        NSUInteger lowIndex = 0;
        CGFloat lowY = [_currentYArray[0] floatValue];
        for (NSUInteger j = 1; j != _collumeCount; ++j) {
            CGFloat y = [_currentYArray[j] floatValue];
            if (y < lowY) {
                lowY = y;
                lowIndex = j;
            }
        }
        CGSize dstSize = [collectionViewDelegate CollectionView:self.collectionView layout:self sizeForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        //换算比例。无论委托给出的size是多大，始终按瀑布流宽度比例换算
        CGFloat ratio = dstSize.width / waterfallWidth;
        CGRect frame = CGRectMake((waterfallWidth + _collumeGap) * lowIndex + _sectionInset.left, lowY + _rowGap, dstSize.width / ratio, dstSize.height / ratio);
        [self.frameArray addObject:[NSValue valueWithCGRect:frame]];
        
        lowY = CGRectGetMaxY(frame);
        [_currentYArray replaceObjectAtIndex:lowIndex withObject:@(lowY)];
    }
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

-(CGSize)collectionViewContentSize
{
    CGSize size = self.collectionView.frame.size;
    CGFloat maxY = CGRectGetMaxY([[_frameArray lastObject] CGRectValue]) + _sectionInset.bottom;
    
    size.height = maxY > size.height ? maxY : size.height;
    return size;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)path
{
    UICollectionViewLayoutAttributes* attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:path];
    attributes.frame = [[_frameArray objectAtIndex:path.item] CGRectValue];
    return attributes;
}

-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray* attributes = [NSMutableArray array];
    for (NSUInteger i = 0; i != _frameArray.count; ++i) {
        CGRect frame = [_frameArray[i] CGRectValue];
        if (CGRectIntersectsRect(rect, frame) || CGRectContainsRect(rect, frame)) {
            [attributes addObject:[self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]]];
        }
    }
    return attributes;
}

@end
