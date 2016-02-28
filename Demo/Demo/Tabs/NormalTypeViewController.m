//
//  NormalTypeViewController.m
//  Demo
//
//  Created by juxingzhutou on 16/2/27.
//  Copyright © 2016年 bluntsword. All rights reserved.
//

#import "NormalTypeViewController.h"
#import "BSCircleBanner.h"
#import "Masonry.h"

@interface NormalTypeViewController ()

@end

@implementation NormalTypeViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.title = @"Normal";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    self.bannerHeightConstraint.offset = screenWidth * 0.55;
    self.bannerView.bannerSize = CGSizeMake(screenWidth, screenWidth * 0.55);
    self.bannerView.type = BSCircleBannerTypeNormal;
}

@end
