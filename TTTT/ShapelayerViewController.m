//
//  ShapelayerViewController.m
//  TTTT
//
//  Created by 无线盈 on 15/9/22.
//  Copyright © 2015年 wuxianying. All rights reserved.
//

#import "ShapelayerViewController.h"
#import "ShaperLayerView.h"
#import "Utils.h"

@interface ShapelayerViewController ()

@end

@implementation ShapelayerViewController
{
    ShaperLayerView *sV;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    sV = [[ShaperLayerView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:sV];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
