//
//  CustomLayoutViewController.m
//  Demo
//
//  Created by juxingzhutou on 16/2/27.
//  Copyright © 2016年 bluntsword. All rights reserved.
//

#import "CustomLayoutViewController.h"
#import "BSCircleBanner.h"
#import "Masonry.h"

@interface CustomLayoutViewController ()

@end

@implementation CustomLayoutViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.title = @"Custom Layout";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    self.bannerHeightConstraint.offset = screenWidth * 0.55;
    self.bannerView.bannerSize = CGSizeMake(screenWidth, screenWidth * 0.55);
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.bannerView.customLayout = layout;
}

@end
