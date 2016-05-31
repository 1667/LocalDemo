//
//  CA2ViewController.m
//  TTTT
//
//  Created by 无线盈 on 15/9/29.
//  Copyright © 2015年 wuxianying. All rights reserved.
//

#import "CA2ViewController.h"
#import "Utils.h"
#import "ScrollTitltView.h"
#import "AlphaView.h"
#import "Test3DView.h"
#import "CuteView.h"
#import "AVPlayerView.h"
@interface CA2ViewController ()

@end

@implementation CA2ViewController
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
    [vA addObject:[[AlphaView alloc] initWithFrame:CGRectMake(0, NAV_STATUS_H(self)+BTN_H, self.view.frame.size.width, self.view.frame.size.height-NAV_STATUS_H(self)-BTN_H)]];
    
    [vA addObject:[[Test3DView alloc] initWithFrame:CGRectMake(0, NAV_STATUS_H(self)+BTN_H, self.view.frame.size.width, self.view.frame.size.height-NAV_STATUS_H(self)-BTN_H)]];
    [vA addObject:[[CuteView alloc] initWithFrame:CGRectMake(0, NAV_STATUS_H(self)+BTN_H, self.view.frame.size.width, self.view.frame.size.height-NAV_STATUS_H(self)-BTN_H)]];
    [vA addObject:[[AVPlayerView alloc] initWithFrame:CGRectMake(0, NAV_STATUS_H(self)+BTN_H, self.view.frame.size.width, self.view.frame.size.height-NAV_STATUS_H(self)-BTN_H)]];
    
    scrollTitle = [[ScrollTitltView alloc] initWithFrame:CGRectMake(0, NAV_STATUS_H(self), self.view.frame.size.width, self.view.frame.size.height-NAV_STATUS_H(self)) titleText:@[@"alpha",@"3D",@"cube",@"视频播放"] viewArray:vA];
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
