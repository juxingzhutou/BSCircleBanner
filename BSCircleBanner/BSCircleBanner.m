//
//  BSCircleBanner.m
//  Demo
//
//  Created by juxingzhutou on 16/2/27.
//  Copyright © 2016年 bluntsword. All rights reserved.
//

#import "BSCircleBanner.h"
#import "BSCircleBannerAlbumTypeLayout.h"
#import "BSCircleBannerNormalTypeLayout.h"
#import "Masonry.h"

#define TOP_BANNER_CELL_REUSE_ID @"TOP_BANNER_CELL_REUSE_ID"

#define COLLECTION_SECTION_HORIZONTAL_INSET ((self.bounds.size.width - self.bannerSize.width) / 2)
#define CURRENT_PAGE    floor((self.collectionView.contentOffset.x + self.bounds.size.width/2 - COLLECTION_SECTION_HORIZONTAL_INSET) / self.bannerSize.width)

static BOOL isStopOnFirstPage = NO, isStopOnLastPage = NO;

@interface BSCircleBanner () <UIScrollViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate>

@property (nonatomic, strong) NSTimer               *autoScrollTimer;

@property (nonatomic, assign) NSUInteger            bannerCount;

@end

@implementation BSCircleBanner

- (instancetype)initWithType:(BSCircleBannerType)type {
    _type = type;
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self intializer];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self intializer];
    }
    return self;
}

- (void)intializer {
    _autoScrollInterval = 4.0;
    
    UICollectionViewFlowLayout *layout = [self getLayoutForType:self.type];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    
    [self addSubview:collectionView];
    self.collectionView = collectionView;
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.scrollsToTop = NO;
    collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
    collectionView.backgroundColor = [UIColor whiteColor];
    
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onImageBeTapped:)];
    [collectionView addGestureRecognizer:tapGR];
    
    [collectionView registerClass:BSSingleBannerCVCell.class forCellWithReuseIdentifier:TOP_BANNER_CELL_REUSE_ID];
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    [self addSubview:pageControl];
    self.pageControl = pageControl;
    [pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.mas_bottom).offset(8);
    }];
    pageControl.userInteractionEnabled = NO;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (newSuperview == nil) {
        [self invalidateAutoScrollTimer];
    } else if (self.autoScrollTimer == nil) {
        [self fireAutoScrollTimer];
    }
}

- (void)layoutSubviews {
    [(UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout setItemSize:self.bannerSize];
    [(UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout setSectionInset:UIEdgeInsetsMake(0, COLLECTION_SECTION_HORIZONTAL_INSET, 0, COLLECTION_SECTION_HORIZONTAL_INSET)];
    
    [super layoutSubviews];
    
    [self gotoPageWithIndex:self.bannerCount > 1? self.pageControl.currentPage+1: self.pageControl.currentPage animated:NO];
}

#pragma mark - Actions

- (void)scrollBanner:(NSTimer *)timer {
    NSUInteger page = CURRENT_PAGE;
    [self gotoPageWithIndex:page+1 animated:YES];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self invalidateAutoScrollTimer];
    isStopOnFirstPage = NO;
    isStopOnLastPage = NO;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView
                  willDecelerate:(BOOL)decelerate {
    [self fireAutoScrollTimer];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.bannerCount > 1) {
        NSUInteger page = CURRENT_PAGE;
        [self scrollCircleInScrollView:scrollView withPageIndex:page];
        
        page = CURRENT_PAGE;
        self.pageControl.currentPage = page > 0 ? page - 1 : self.bannerCount - 2;
        if ([self.delegate respondsToSelector:@selector(BSCircleBanner:didScrollToPage:)]) {
            [self.delegate BSCircleBanner:self didScrollToPage:self.pageControl.currentPage];
        }
    }
    
    if (scrollView.decelerating) {
        CGFloat lastPageContentOffsetX = (self.bannerCount-2)*self.bannerSize.width;
        if (isStopOnLastPage && scrollView.contentOffset.x < lastPageContentOffsetX + 10) {
            [scrollView setContentOffset:CGPointMake(lastPageContentOffsetX, 0) animated:YES];
            isStopOnLastPage = NO;
        }
        
        CGFloat firstPageContentOffsetX = self.bannerSize.width;
        if (isStopOnFirstPage && scrollView.contentOffset.x > firstPageContentOffsetX - 10) {
            [scrollView setContentOffset:CGPointMake(firstPageContentOffsetX, 0) animated:YES];
            isStopOnFirstPage = NO;
        }
    }
}

- (void)scrollCircleInScrollView:(UIScrollView *)scrollView withPageIndex:(NSInteger)page {
    if (scrollView.bounds.size.width < 0.0001) {
        return;
    }
    if (page < 1) {
        scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x + (self.bannerCount - 2) * self.bannerSize.width, 0);
        if (scrollView.decelerating) {
            isStopOnLastPage = YES;
        }
    } else if (page >= self.bannerCount - 1) {
        scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x - (self.bannerCount-2)*self.bannerSize.width, 0);
        if (scrollView.decelerating) {
            isStopOnFirstPage = YES;
        }
    }
}

#pragma mark - Accessors

- (void)setAutoScrollInterval:(CGFloat)autoScrollInterval {
    _autoScrollInterval = autoScrollInterval;
    [self invalidateAutoScrollTimer];
    [self fireAutoScrollTimer];
}

- (void)setType:(BSCircleBannerType)type {
    _type = type;
    
    self.collectionView.collectionViewLayout = [self getLayoutForType:type];
}

- (void)setCustomLayout:(UICollectionViewFlowLayout *)customLayout {
    _customLayout = customLayout;
    self.collectionView.collectionViewLayout = customLayout;
}

- (void)setBannerSize:(CGSize)bannerSize {
    _bannerSize = bannerSize;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setDataSource:(id<BSCircleBannerDataSource>)dataSource {
    _dataSource = dataSource;
    [self reloadData];
}

#pragma mark - Actions

- (void)reloadData {
    NSUInteger bannerCount = [self.dataSource numberOfBannersInBSCircleBanner:self];
    
    self.pageControl.numberOfPages = bannerCount;
    
    if (bannerCount > 1) {
        self.bannerCount = bannerCount + 2;
    } else {
        self.bannerCount = bannerCount;
    }
    
    [self.collectionView reloadData];
    
    if (self.bannerCount <= 1) {
        [self invalidateAutoScrollTimer];
    } else if (self.superview) {
        [self fireAutoScrollTimer];
    }
}

- (void)fireAutoScrollTimer {
    if (self.bannerCount <= 1 || self.autoScrollTimer) {
        return;
    }
    
    self.autoScrollTimer = [NSTimer scheduledTimerWithTimeInterval:self.autoScrollInterval target:self selector:@selector(scrollBanner:) userInfo:nil repeats:YES];
}

- (void)invalidateAutoScrollTimer {
    if (self.bannerCount <= 1 || self.autoScrollTimer == nil) {
        return;
    }
    
    [self.autoScrollTimer invalidate];
    self.autoScrollTimer = nil;
}

#pragma mark - UICollectionViewDataSouce

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return self.bannerCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BSSingleBannerCVCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:TOP_BANNER_CELL_REUSE_ID forIndexPath:indexPath];
    
    [self.dataSource configureCell:cell forItemAtIndexPath:[self translateToExternalForIndexPath:indexPath] inBSCircleBanner:self];
    
    return cell;
}

#pragma mark - Private Methods

- (void)onImageBeTapped:(UITapGestureRecognizer *)gr {
    if ([self.delegate respondsToSelector:@selector(BSCircleBanner:didTappedAtIndexPath:)]
        && self.bannerCount != 0) {
        NSUInteger index = 0;
        if (self.bannerCount > 1) {
            index = self.pageControl.currentPage + 1;
        }
        
        [self.delegate BSCircleBanner:self
                 didTappedAtIndexPath:[self translateToExternalForIndexPath:[NSIndexPath indexPathForItem:index inSection:0]]];
    }
}

- (NSIndexPath *)translateToExternalForIndexPath:(NSIndexPath *)indexPath {
    if (self.bannerCount > 1) {
        if (indexPath.item == 0) {
            indexPath = [NSIndexPath indexPathForItem:self.bannerCount - 3 inSection:indexPath.section];
        } else if (indexPath.item == self.bannerCount - 1) {
            indexPath = [NSIndexPath indexPathForItem:0 inSection:indexPath.section];
        } else {
            indexPath = [NSIndexPath indexPathForItem:indexPath.item - 1 inSection:indexPath.section];
        }
    }
    
    return indexPath;
}

- (void)gotoPageWithIndex:(NSInteger)index animated:(BOOL)animated {
    if (self.bannerCount == 0) {
        return;
    }
    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]
                                atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
                                        animated:animated];
}

- (UICollectionViewFlowLayout *)getLayoutForType:(BSCircleBannerType)type {
    UICollectionViewFlowLayout *layout = nil;
    switch (self.type) {
        case BSCircleBannerTypeAlbum:
            layout = [[BSCircleBannerAlbumTypeLayout alloc] init];
            break;
        case BSCircleBannerTypeNormal:
            layout = [[BSCircleBannerNormalTypeLayout alloc] init];
            break;
            
        default:
            _type = BSCircleBannerTypeAlbum;
            layout = [[BSCircleBannerAlbumTypeLayout alloc] init];
            break;
    }
    
    return layout;
}

@end
