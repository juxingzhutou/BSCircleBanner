//
//  BSCircleBanner.h
//  Demo
//
//  Created by juxingzhutou on 16/2/27.
//  Copyright © 2016年 bluntsword. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSSingleBannerCVCell.h"

typedef NS_ENUM(NSInteger, BSCircleBannerType) {
    BSCircleBannerTypeAlbum     = 1, //Default
    BSCircleBannerTypeNormal
};

@class BSCircleBanner;

@protocol BSCircleBannerDataSource <NSObject>

@required
- (NSUInteger)numberOfBannersInBSCircleBanner:(BSCircleBanner *)bannerView;
- (void)configureCell:(BSSingleBannerCVCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath inBSCircleBanner:(BSCircleBanner *)bannerView;

@end

@protocol BSCircleBannerDelegate <NSObject>

@optional
- (void)BSCircleBanner:(BSCircleBanner *)bannerView didTappedAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface BSCircleBanner : UIView

@property (nonatomic, assign) BSCircleBannerType            type;
@property (nonatomic, strong) UICollectionViewFlowLayout    *customLayout;
@property (nonatomic, assign) CGSize                        bannerSize;
@property (nonatomic, weak) id<BSCircleBannerDataSource>    dataSource;
@property (nonatomic, weak) id<BSCircleBannerDelegate>      delegate;

@property (nonatomic, weak) UICollectionView        *collectionView;
@property (nonatomic, weak) UIPageControl           *pageControl;

- (void)reloadData;

@end