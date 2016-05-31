//
//  CA3ViewController.m
//  TTTT
//
//  Created by 无线盈 on 15/9/30.
//  Copyright © 2015年 wuxianying. All rights reserved.
//

#import "CA3ViewController.h"
#import "Utils.h"
#import "ScrollTitltView.h"
#import "MatchManView.h"
#import "TestTransform3DView.h"
#import "CAGradientLayerView.h"
#import "UIEmitterLayerView.h"

@interface CA3ViewController ()

@end

@implementation CA3ViewController
{
    CGFloat     vH;
    ScrollTitltView         *scrollTitle;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
    vH = self.view.frame.size.height-NAV_STATUS_H(self)-BTN_H;
    
    NSMutableArray *vA = [NSMutableArray new];
    [vA addObject:[[MatchManView alloc] initWithFrame:CGRectMake(0, NAV_STATUS_H(self)+BTN_H, self.view.frame.size.width, self.view.frame.size.height-NAV_STATUS_H(self)-BTN_H)]];
    
    [vA addObject:[[TestTransform3DView alloc] initWithFrame:CGRectMake(0, NAV_STATUS_H(self)+BTN_H, self.view.frame.size.width, self.view.frame.size.height-NAV_STATUS_H(self)-BTN_H)]];
    [vA addObject:[[CAGradientLayerView alloc] initWithFrame:CGRectMake(0, NAV_STATUS_H(self)+BTN_H, self.view.frame.size.width, self.view.frame.size.height-NAV_STATUS_H(self)-BTN_H)]];
    [vA addObject:[[UIEmitterLayerView alloc] initWithFrame:CGRectMake(0, NAV_STATUS_H(self)+BTN_H, self.view.frame.size.width, self.view.frame.size.height-NAV_STATUS_H(self)-BTN_H)]];
    
    scrollTitle = [[ScrollTitltView alloc] initWithFrame:CGRectMake(0, NAV_STATUS_H(self), self.view.frame.size.width, self.view.frame.size.height-NAV_STATUS_H(self)) titleText:@[@"alpha",@"3D",@"Gradient",@"Emitter"] viewArray:vA];
    [self.view addSubview:scrollTitle];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initView
{
    self.view.backgroundColor = [UIColor whiteColor];
}

@end
