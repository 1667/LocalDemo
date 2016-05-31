//
//  CustomPressentAnimationController.m
//  TTTT
//
//  Created by 无线盈 on 15/10/15.
//  Copyright © 2015年 wuxianying. All rights reserved.
//

#import "CustomPressentAnimationController.h"
#import "Utils.h"
#import <objc/runtime.h>


@implementation CustomPressentAnimationController


-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 1;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    
    UIViewController *fromV = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toV = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    NSString *str = [NSString stringWithUTF8String:object_getClassName(fromV)];
    const char *className = [str cStringUsingEncoding:NSASCIIStringEncoding];
    Class newClass = objc_getClass(className);
    
//    UIView *tmpImage = 
//    
//    UIView *snapTo = [toViewController.view snapshotViewAfterScreenUpdates:NO];
//    [[transitionContext containerView] addSubview:snapTo];
//    //自定义动画
//    
//    snapTo.frame = CGRectZero;
//    snapTo.center = CGPointMake(SCREEN_W/2, SCREEN_H/2);
//    snapTo.alpha = 0.5;
//    
//    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveLinear animations:^{
//        
//        snapTo.alpha = 1.0;
//        snapTo.frame = [transitionContext finalFrameForViewController:toViewController];
//        
//    } completion:^(BOOL finished) {
//        
//        [[transitionContext containerView] addSubview:toViewController.view];
//        // 声明过渡结束时调用 completeTransition: 这个方法
//        [snapTo removeFromSuperview];
//        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
//        
//    }];
    
    
}

@end
