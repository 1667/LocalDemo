//
//  CycleScrollViewController.m
//  TTTT
//
//  Created by 无线盈 on 15/10/14.
//  Copyright © 2015年 wuxianying. All rights reserved.
//

#import "CycleScrollViewController.h"
#import "LandScapeScrollView.h"
#import "LandScroll3View.h"

@interface CycleScrollViewController ()

@end

@implementation CycleScrollViewController
{
    LandScapeScrollView             *landScapeView;
    LandScroll3View                 *landS3View;
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initView
{
    landScapeView = [[LandScapeScrollView alloc] initWithFrame:CGRectMake(0, NAV_STATUS_H(self), self.selfViewWidth, 200)];
    [self.view addSubview:landScapeView];
    
    landS3View = [[LandScroll3View alloc] initWithFrame:CGRectMake(0, NAV_STATUS_H(self)+200, self.selfViewWidth, 200)];
    [self.view addSubview:landS3View];
}

@end
