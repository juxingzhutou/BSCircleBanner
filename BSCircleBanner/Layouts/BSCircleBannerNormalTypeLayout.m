//
//  BSCircleBannerNormalTypeLayout.m
//  Demo
//
//  Created by juxingzhutou on 16/2/27.
//  Copyright © 2016年 bluntsword. All rights reserved.
//

#import "BSCircleBannerNormalTypeLayout.h"

@implementation BSCircleBannerNormalTypeLayout
{
    CGSize boundsSize;
    CGFloat midX;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.minimumLineSpacing = 0;
    }
    return self;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (void)prepareLayout {
    [super prepareLayout];
    
    boundsSize = self.collectionView.bounds.size;
    midX = boundsSize.width / 2.0f;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset
                                 withScrollingVelocity:(CGPoint)velocity {
    CGFloat offsetAdjustment = CGFLOAT_MAX;
    
    CGRect targetRect = CGRectMake(self.collectionView.contentOffset.x, 0.0, boundsSize.width, boundsSize.height);
    NSArray *array = [super layoutAttributesForElementsInRect:targetRect];
    
    CGFloat proposedCenterX = proposedContentOffset.x + midX;
    
    for (UICollectionViewLayoutAttributes *attribute in array) {
        CGFloat distance = attribute.center.x - proposedCenterX;
        if (ABS(distance) < ABS(offsetAdjustment)) {
            offsetAdjustment = distance;
        }
    }
    
    CGPoint desiredPoint = CGPointMake(MAX(0.0f, proposedContentOffset.x + offsetAdjustment), proposedContentOffset.y);
    
    return desiredPoint;
}

@end
