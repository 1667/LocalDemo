//
//  CA5ViewController.m
//  TTTT
//
//  Created by 无线盈 on 15/10/12.
//  Copyright © 2015年 wuxianying. All rights reserved.
//

#import "CA5ViewController.h"

#import "ScrollTitltView.h"
#import "DurationView.h"
#import "BezierPathDLine.h"
#import "LayerAnimationView.h"
#import "AnimateGroupeView.h"

@interface CA5ViewController ()

@end

@implementation CA5ViewController
{
    CGFloat     vH;
    ScrollTitltView         *scrollTitle;
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
    self.view.backgroundColor = [UIColor whiteColor];
    vH = self.view.frame.size.height-NAV_STATUS_H(self)-BTN_H;
    
    NSMutableArray *vA = [NSMutableArray new];
    [vA addObject:[[DurationView alloc] initWithFrame:CGRectMake(0, NAV_STATUS_H(self)+BTN_H, self.view.frame.size.width, self.view.frame.size.height-NAV_STATUS_H(self)-BTN_H)]];
    
    [vA addObject:[[BezierPathDLine alloc] initWithFrame:CGRectMake(0, NAV_STATUS_H(self)+BTN_H, self.view.frame.size.width, self.view.frame.size.height-NAV_STATUS_H(self)-BTN_H)]];
    [vA addObject:[[LayerAnimationView alloc] initWithFrame:CGRectMake(0, NAV_STATUS_H(self)+BTN_H, self.view.frame.size.width, self.view.frame.size.height-NAV_STATUS_H(self)-BTN_H)]];
    [vA addObject:[[AnimateGroupeView alloc] initWithFrame:CGRectMake(0, NAV_STATUS_H(self)+BTN_H, self.view.frame.size.width, self.view.frame.size.height-NAV_STATUS_H(self)-BTN_H)]];
    
    scrollTitle = [[ScrollTitltView alloc] initWithFrame:CGRectMake(0, NAV_STATUS_H(self), self.view.frame.size.width, self.view.frame.size.height-NAV_STATUS_H(self)) titleText:@[@"alpha",@"3D",@"Gradient",@"Emitter"] viewArray:vA];
    [self.view addSubview:scrollTitle];
}

@end
