//
//  WaterfallLayout.h
//  CircleLayout
//
//  Created by bhb on 15-3-11.
//  Copyright (c) 2015年 Olivier Gutknecht. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UICollectionViewDelegateWaterfallLayout <UICollectionViewDelegate>

@required

//瀑布流某大小
- (CGSize)CollectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)itemIndexPath;

@end

@interface WaterfallLayout : UICollectionViewLayout

//瀑布流列数
@property (nonatomic, assign) NSUInteger collumeCount;

//列间距
@property (nonatomic, assign) CGFloat collumeGap;

//行间距
@property (nonatomic, assign) CGFloat rowGap;

//视图内容缩进
@property (nonatomic) UIEdgeInsets sectionInset;

@end
