//
//  BezierDLViewController.m
//  TTTT
//
//  Created by 无线盈 on 15/10/13.
//  Copyright © 2015年 wuxianying. All rights reserved.
//

#import "BezierDLViewController.h"
#import "BezierPathDLine.h"

@interface BezierDLViewController ()

@end

@implementation BezierDLViewController
{
    UIBezierPath        *path;
}

-(void)initView
{
    BezierPathDLine *view = [[BezierPathDLine alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:view];
    
}


@end
