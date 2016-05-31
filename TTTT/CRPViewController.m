//
//  CRPViewController.m
//  TTTT
//
//  Created by wxy on 16/2/24.
//  Copyright © 2016年 wuxianying. All rights reserved.
//

#import "CRPViewController.h"
#import "ScrollTitltView.h"
#import "CRPView.h"

@interface CRPViewController ()

@end

@implementation CRPViewController
{
    CGFloat     vH;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    vH = self.view.frame.size.height-NAV_STATUS_H(self)-BTN_H;
    
    NSMutableArray *vA = [NSMutableArray new];
    [vA addObject:[[CRPView alloc] initWithFrame:CGRectMake(0, NAV_STATUS_H(self)+BTN_H, self.view.frame.size.width, self.view.frame.size.height-NAV_STATUS_H(self)-BTN_H)]];
    
    ScrollTitltView *scrollTitle = [[ScrollTitltView alloc] initWithFrame:CGRectMake(0, NAV_STATUS_H(self), self.view.frame.size.width, self.view.frame.size.height-NAV_STATUS_H(self)) titleText:@[@"CRP"] viewArray:vA];
    [self.view addSubview:scrollTitle];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
    
}

@end
