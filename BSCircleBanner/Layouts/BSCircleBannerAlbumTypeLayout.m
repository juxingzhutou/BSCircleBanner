//
//  BSCircleBannerFlowLayout.m
//  Demo
//
//  Created by juxingzhutou on 16/2/27.
//  Copyright © 2016年 bluntsword. All rights reserved.
//

#import "BSCircleBannerAlbumTypeLayout.h"

@implementation BSCircleBannerAlbumTypeLayout
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

- (NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *array = [[NSArray alloc] initWithArray:[super layoutAttributesForElementsInRect:rect] copyItems:YES];
    
    for (UICollectionViewLayoutAttributes *attribute in array) {
        attribute.transform3D = CATransform3DIdentity;
        if (!CGRectIntersectsRect(attribute.frame, rect)) {
            continue;
        }
        
        CGPoint contentOffset = self.collectionView.contentOffset;
        CGPoint itemCenter = CGPointMake(attribute.center.x - contentOffset.x, attribute.center.y - contentOffset.y);
        CGFloat distance = ABS(midX - itemCenter.x);
        
        CGFloat normalized = distance / midX;
        CGFloat zoom = cos(normalized * M_PI_4)*0.10 + 0.9;
        
        attribute.transform3D = CATransform3DMakeScale(zoom, zoom * (1-normalized*0.1), 1.0f);
    }
    
    return array;
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
