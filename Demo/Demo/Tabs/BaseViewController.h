//
//  BaseViewController.h
//  Demo
//
//  Created by juxingzhutou on 16/2/27.
//  Copyright © 2016年 bluntsword. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSCircleBanner.h"
#import "Masonry.h"

@interface BaseViewController : UIViewController <BSCircleBannerDataSource, BSCircleBannerDelegate>

@property (nonatomic, weak) BSCircleBanner  *bannerView;
@property (nonatomic, weak) MASConstraint   *bannerHeightConstraint;

@end
