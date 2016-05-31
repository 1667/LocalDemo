//
//  NavViewController.m
//  TTTT
//
//  Created by 无线盈 on 15/10/15.
//  Copyright © 2015年 wuxianying. All rights reserved.
//

#import "NavViewController.h"
#import "UIImage+LocalSize.h"
#import "Utils.h"
#import "NextViewController.h"
#import "CustomPopAnimation.h"

#import "CustomPressentAnimationController.h"

@interface NavViewController ()

@end

@implementation NavViewController
{
    CustomPressentAnimationController *customAnim;
    CustomPopAnimation                *customPop;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initView
{
    self.view.backgroundColor = [Utils randomColor];
    
    _iamgeV = [UIButton new];
    [_iamgeV setBackgroundImage:[UIImage imageNamed:@"tu8601_10.jpg"] forState:UIControlStateNormal];
    CGSize size = [_iamgeV.currentBackgroundImage localImageSizeWithWidth:(self.view.frame.size.width-20)/2];
    [self.view addSubview:_iamgeV];
    [_iamgeV addTarget:self action:@selector(toNext) forControlEvents:UIControlEventTouchUpInside];
    [_iamgeV makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.centerX);
        make.centerY.equalTo(self.view.centerY);
        make.size.equalTo(size);
    }];
    self.navigationController.delegate = self;
    customAnim = [[CustomPressentAnimationController alloc] init];
    customPop = [[CustomPopAnimation alloc] init];
    
}

-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPush) {
        return customAnim;
    }
    else if(operation == UINavigationControllerOperationPop)
    {
        return customPop;
    }
    else
        return nil;
}

-(void)toNext
{
    NextViewController *nVc = [NextViewController new];
    nVc.image = [UIImage imageNamed:@"tu8601_10.jpg"];
    
    [self.navigationController pushViewController:nVc animated:YES];
    
}

@end
