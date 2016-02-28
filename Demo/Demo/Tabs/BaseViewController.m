//
//  BaseViewController.m
//  Demo
//
//  Created by juxingzhutou on 16/2/27.
//  Copyright © 2016年 bluntsword. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBarController.tabBar.translucent = NO;
    self.navigationController.navigationBar.translucent = NO;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    
    BSCircleBanner *bannerView = [[BSCircleBanner alloc] init];
    self.bannerView = bannerView;
    CGFloat bannerWidth = floor([UIScreen mainScreen].bounds.size.width * 0.85);
    bannerView.bannerSize = CGSizeMake(bannerWidth, floor(bannerWidth * 0.55));
    bannerView.dataSource = self;
    bannerView.delegate = self;
    [self.view addSubview:bannerView];
    [bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20);
        make.left.right.equalTo(self.view);
        self.bannerHeightConstraint = make.height.equalTo(@(bannerView.bannerSize.height));
    }];
}

#pragma mark - BSCircleBannerDataSource

- (NSUInteger)numberOfBannersInBSCircleBanner:(BSCircleBanner *)bannerView {
    return 3;
}

- (void)configureCell:(BSSingleBannerCVCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath inBSCircleBanner:(BSCircleBanner *)bannerView {
    switch (indexPath.item) {
        case 0:
            [cell.imageView setImage:[UIImage imageNamed:@"1.jpg"]];
            break;
        case 1:
            [cell.imageView setImage:[UIImage imageNamed:@"2.jpg"]];
            break;
        case 2:
            //You can get image from internet, like below.
            //            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:@"http://XXX"]];
            [cell.imageView setImage:[UIImage imageNamed:@"3.jpg"]];
            break;
            
        default:
            break;
    }
}

#pragma mark - BSCircleBannerDelegate

- (void)BSCircleBanner:(BSCircleBanner *)bannerView didTappedAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Cell has been tapped.");
}

@end
