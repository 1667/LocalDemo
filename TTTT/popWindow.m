//
//  popWindow.m
//  TTTT
//
//  Created by 无线盈 on 15/9/24.
//  Copyright © 2015年 wuxianying. All rights reserved.
//

#import "popWindow.h"
#import "popWinViewController.h"

@implementation popWindow

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blueColor];
        popWinViewController *pC = [popWinViewController new];
        pC.superWind = self;
        [self setRootViewController:[[UINavigationController alloc] initWithRootViewController:pC]];
        self.windowLevel = UIWindowLevelAlert;
        self.hidden = NO;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5.0;
        UIPanGestureRecognizer *panG = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panG:)];
        panG.delaysTouchesBegan = YES;
        [self addGestureRecognizer:panG];
        
    }
    return self;
}

-(void)panG:(UIPanGestureRecognizer *)pan
{
    CGPoint p = [pan locationInView:[[UIApplication sharedApplication] keyWindow]];
    NSLog(@"%@",[NSValue valueWithCGPoint:p]);
    
    self.center = CGPointMake(p.x, p.y);
    
    
}

@end
