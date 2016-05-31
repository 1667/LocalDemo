//
//  NextViewController.m
//  TTTT
//
//  Created by 无线盈 on 15/10/15.
//  Copyright © 2015年 wuxianying. All rights reserved.
//

#import "NextViewController.h"
#import "Utils.h"
#import "PresentViewController.h"
#import "CustomPresentAnimation.h"

@interface NextViewController ()<UINavigationControllerDelegate,UIViewControllerTransitioningDelegate>

@end

@implementation NextViewController
{
    CustomPresentAnimation  *presentAnimation;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    UIButton *tmpBtn = [UIButton new];
    [tmpBtn setBackgroundColor:[Utils randomColor]];
    [self.view addSubview:tmpBtn];
    CGSize size1 = [_image localImageSizeWithWidth:self.view.frame.size.width];
    [tmpBtn setBackgroundImage:_image forState:UIControlStateNormal];
    [tmpBtn addTarget:self action:@selector(pop:) forControlEvents:UIControlEventTouchUpInside];
    [tmpBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.centerX);
        make.centerY.equalTo(self.view.centerY);
        make.size.equalTo(size1);
        
    }];
    
    tmpBtn = [UIButton new];
    [tmpBtn setBackgroundColor:[Utils randomColor]];
    [self.view addSubview:tmpBtn];
    [tmpBtn addTarget:self action:@selector(presentView) forControlEvents:UIControlEventTouchUpInside];
    [tmpBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(self.view);
        make.height.equalTo(50);
    }];
    presentAnimation = [CustomPresentAnimation new];
}

-(void)presentView
{
    PresentViewController *present = [PresentViewController new];
    present.transitioningDelegate = self;
    //UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:present];
    //nav.transitioningDelegate = self;
    [self.navigationController presentViewController:present animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)pop:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    presentAnimation.animationType = AnimationTypePresent;
    return presentAnimation;
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    presentAnimation.animationType = AnimationTypeDismiss;
    return presentAnimation;
}

@end
