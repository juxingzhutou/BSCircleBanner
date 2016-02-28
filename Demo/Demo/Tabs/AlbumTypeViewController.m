//
//  AlbumTypeViewController.m
//  Demo
//
//  Created by juxingzhutou on 16/2/27.
//  Copyright © 2016年 bluntsword. All rights reserved.
//

#import "AlbumTypeViewController.h"

@interface AlbumTypeViewController ()

@end

@implementation AlbumTypeViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.title = @"Album";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.bannerView.type = BSCircleBannerTypeAlbum;
}

@end
