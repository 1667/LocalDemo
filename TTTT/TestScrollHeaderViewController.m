//
//  TestScrollHeaderViewController.m
//  TTTT
//
//  Created by 无线盈 on 15/9/23.
//  Copyright © 2015年 wuxianying. All rights reserved.
//

#import "TestScrollHeaderViewController.h"
#import "ShapelCircleView.h"
#import "Utils.h"

#define REFRESHING_H        80

@interface TestScrollHeaderViewController ()<UIScrollViewDelegate>

@end

@implementation TestScrollHeaderViewController
{
    ShapelCircleView *_shView;
    UIScrollView        *_scrollView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAV_STATUS_H(self), VC_W(self), VC_H(self)-NAV_STATUS_H(self))];
    _scrollView.delegate = self;
    
    [self.view addSubview:_scrollView];
    _shView = [[ShapelCircleView alloc] initWithFrame:CGRectMake(CGRectGetMidX(_scrollView.frame)-10, -50, 20, 20)];
    [_scrollView addSubview:_shView];
    UIView *frontView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VC_W(self), 1000)];
    frontView.backgroundColor = [Utils randomColor];
    [_scrollView addSubview:frontView];
    [_scrollView setContentSize:CGSizeMake(VC_W(self), 2000)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //NSLog(@"%@",[NSValue valueWithCGPoint:scrollView.contentOffset]);
    if (scrollView.contentOffset.y == 0 || _shView.bRefreashing) {
        _shView.strokeEnd = 1.0f;
    }
    else
     _shView.strokeEnd = fabs(scrollView.contentOffset.y)/REFRESHING_H;
    
    if (scrollView.contentOffset.y < -REFRESHING_H && !_shView.bRefreashing) {
        _shView.bRefreashing = YES;
    }

}

-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    if (_shView.bRefreashing == YES) {
        
        [scrollView setContentOffset:CGPointMake(0, -70) animated:YES];
        _shView.strokeEnd = 1.0f;
        [UIView animateWithDuration:0.5 delay:2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [scrollView setContentOffset:CGPointMake(0, 0)];
        } completion:^(BOOL finished) {
            if (finished) {
                _shView.bRefreashing = NO;
            }
           
        }];
        
    }
    
}

@end
