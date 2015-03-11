
/*
     File: ViewController.m
 Abstract: 
 
  Version: 1.0
 
 Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple
 Inc. ("Apple") in consideration of your agreement to the following
 terms, and your use, installation, modification or redistribution of
 this Apple software constitutes acceptance of these terms.  If you do
 not agree with these terms, please do not use, install, modify or
 redistribute this Apple software.
 
 In consideration of your agreement to abide by the following terms, and
 subject to these terms, Apple grants you a personal, non-exclusive
 license, under Apple's copyrights in this original Apple software (the
 "Apple Software"), to use, reproduce, modify and redistribute the Apple
 Software, with or without modifications, in source and/or binary forms;
 provided that if you redistribute the Apple Software in its entirety and
 without modifications, you must retain this notice and the following
 text and disclaimers in all such redistributions of the Apple Software.
 Neither the name, trademarks, service marks or logos of Apple Inc. may
 be used to endorse or promote products derived from the Apple Software
 without specific prior written permission from Apple.  Except as
 expressly stated in this notice, no other rights or licenses, express or
 implied, are granted by Apple herein, including but not limited to any
 patent rights that may be infringed by your derivative works or by other
 works in which the Apple Software may be incorporated.
 
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE
 MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
 THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
 FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND
 OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.
 
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL
 OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION,
 MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED
 AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE),
 STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
 
 Copyright (C) 2012 Apple Inc. All Rights Reserved.
 
 
 WWDC 2012 License
 
 NOTE: This Apple Software was supplied by Apple as part of a WWDC 2012
 Session. Please refer to the applicable WWDC 2012 Session for further
 information.
 
 IMPORTANT: This Apple software is supplied to you by Apple
 Inc. ("Apple") in consideration of your agreement to the following
 terms, and your use, installation, modification or redistribution of
 this Apple software constitutes acceptance of these terms.  If you do
 not agree with these terms, please do not use, install, modify or
 redistribute this Apple software.
 
 In consideration of your agreement to abide by the following terms, and
 subject to these terms, Apple grants you a non-exclusive license, under
 Apple's copyrights in this original Apple software (the "Apple
 Software"), to use, reproduce, modify and redistribute the Apple
 Software, with or without modifications, in source and/or binary forms;
 provided that if you redistribute the Apple Software in its entirety and
 without modifications, you must retain this notice and the following
 text and disclaimers in all such redistributions of the Apple Software.
 Neither the name, trademarks, service marks or logos of Apple Inc. may
 be used to endorse or promote products derived from the Apple Software
 without specific prior written permission from Apple.  Except as
 expressly stated in this notice, no other rights or licenses, express or
 implied, are granted by Apple herein, including but not limited to any
 patent rights that may be infringed by your derivative works or by other
 works in which the Apple Software may be incorporated.
 
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE
 MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
 THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
 FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND
 OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.
 
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL
 OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION,
 MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED
 AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE),
 STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
 
 */

#import "ViewController.h"
#import "Cell.h"
#import "WaterfallCollectionViewCell.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "SDWebImage/SDWebImageManager.h"

@implementation ViewController

#if 0
-(void)viewDidLoad
{
    self.cellCount = 20;
    UITapGestureRecognizer* tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    [self.collectionView addGestureRecognizer:tapRecognizer];
    [self.collectionView registerClass:[Cell class] forCellWithReuseIdentifier:@"MY_CELL"];
    [self.collectionView reloadData];
    self.collectionView.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
    return self.cellCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    Cell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"MY_CELL" forIndexPath:indexPath];
    return cell;
}

- (void)handleTapGesture:(UITapGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        CGPoint initialPinchPoint = [sender locationInView:self.collectionView];
        NSIndexPath* tappedCellPath = [self.collectionView indexPathForItemAtPoint:initialPinchPoint];
        if (tappedCellPath!=nil)
        {
            self.cellCount = self.cellCount - 1;
            [self.collectionView performBatchUpdates:^{
                [self.collectionView deleteItemsAtIndexPaths:[NSArray arrayWithObject:tappedCellPath]];
                
            } completion:nil];
        }
        else
        {
            self.cellCount = self.cellCount + 1;
            [self.collectionView performBatchUpdates:^{
                [self.collectionView insertItemsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForItem:0 inSection:0]]];
            } completion:nil];
        }
    }
}
#else
-(void)viewDidLoad
{
    NSArray *animals = @[@"http://img12.dayoo.com/travel/120418/120424/120740/img/attachement/jpg/site1/20120820/001372a1e378119c30c64b.jpg", @"http://a4.att.hudong.com/01/71/01300000642076125800717182686.jpg", @"http://img.blog.163.com/photo/2FVkpBECFwo1Fl0zVv81tA==/1130122031494260328.jpg", @"http://images.takungpao.com/2013/0724/20130724090640446.jpg", @"http://news.cjn.cn/shtp/tpttjx/200806/W020080614422367831922.jpg", @"http://gb.cri.cn/mmsource/images/2012/10/19/c0ddb249ebcd46978f6310019fdd0bd2.jpg", @"http://hebei.hebnews.cn/attachement/jpg/site2/20130820/6c626d041f72137d62370e.jpg", @"http://www.jshrmy.com/news/uploadfiles_3450/200905/20090525115638943.jpg", @"http://news.cjn.cn/shtp/tpttjx/200806/W020080614422367855769.jpg", @"http://news.xinhuanet.com/photo/2010-04/09/1224198_21n.jpg", @"http://images.china.cn/attachement/jpg/site1000/20121107/0019b91ecbef12041d2109.jpg", @"http://a0.att.hudong.com/54/71/01300000642076125800715201878.jpg", @"http://images.china.cn/news/attachement/jpg/site3/20110512/6786877484729153613.jpg", @"http://ww1.sinaimg.cn/large/5528fe1bjw1e3tlufgol6j.jpg", @"http://a0.att.hudong.com/86/72/14300000958002128390727535543.jpg"];
    NSMutableArray *tmpArr = [NSMutableArray arrayWithCapacity:22];
    for (int i = 0; i != 22; ++i) {
        NSString *imageUrl = [animals objectAtIndex:(arc4random() % animals.count)];
        NSString *imageName = [NSString stringWithFormat:@"image %d", i];
        [tmpArr addObject:@{@"image":imageUrl, @"name":imageName}];
    }
    self.dataArray = tmpArr;
    [self.collectionView registerNib:[UINib nibWithNibName:@"WaterfallCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"MY_CELL"];
//    [self.collectionView reloadData];
    self.collectionView.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
}

- (CGSize)CollectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    NSDictionary *dic = [_dataArray objectAtIndex:itemIndexPath.item];
    NSURL *imageURL = [NSURL URLWithString:[dic objectForKey:@"image"]];

    if ([SDWebImageManager.sharedManager cachedImageExistsForURL:imageURL]) {
        NSString *key = [SDWebImageManager.sharedManager cacheKeyForURL:imageURL];
        UIImage *image = [SDWebImageManager.sharedManager.imageCache imageFromMemoryCacheForKey:key];
        if (!image) {
            image = [SDWebImageManager.sharedManager.imageCache imageFromDiskCacheForKey:key];
        }
        return image.size;
    } else {
        [SDWebImageManager.sharedManager downloadImageWithURL:imageURL options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            dispatch_main_sync_safe(^{
                [collectionView reloadItemsAtIndexPaths:@[itemIndexPath]];
            });
        }];
        return [UIImage imageNamed:@"default-245978.jpg"].size;
    }
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WaterfallCollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"MY_CELL" forIndexPath:indexPath];
    NSDictionary *dic = [_dataArray objectAtIndex:indexPath.item];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:dic[@"image"]] placeholderImage:[UIImage imageNamed:@"default-245978.jpg"]];
    cell.label.text = dic[@"name"];
    return cell;
}
#endif

@end
