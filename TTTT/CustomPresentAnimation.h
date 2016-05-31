//
//  CustomPresentAnimation.h
//  TTTT
//
//  Created by 无线盈 on 15/10/16.
//  Copyright © 2015年 wuxianying. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {
    AnimationTypePresent,
    AnimationTypeDismiss
    
} AnimationType;

@interface CustomPresentAnimation : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic,assign)AnimationType animationType;

@end
