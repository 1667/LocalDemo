//
//  ShaperLayerView.m
//  TTTT
//
//  Created by 无线盈 on 15/9/22.
//  Copyright © 2015年 wuxianying. All rights reserved.
//

#import "ShaperLayerView.h"

@interface ShaperLayerView()

@end

@implementation ShaperLayerView
{
    CAShapeLayer *backSL;
    UIBezierPath *circlePath;
    CGFloat         strokeWidth;
    CAShapeLayer    *frontSL;
    CGFloat         currentP;
    
    
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        strokeWidth = 2;
        CGPoint arcCenter = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
        circlePath = [UIBezierPath bezierPathWithArcCenter:arcCenter radius:CGRectGetMidX(self.bounds) startAngle:M_PI endAngle:-M_PI clockwise:NO];
        backSL = [CAShapeLayer layer];
        backSL.path = circlePath.CGPath;
        backSL.strokeColor = [UIColor redColor].CGColor;
        backSL.fillColor = [UIColor clearColor].CGColor;
        backSL.lineWidth = strokeWidth;
        [self.layer addSublayer:backSL];
        CABasicAnimation *pathA = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathA.duration = 2;
        pathA.fromValue = [NSNumber numberWithFloat:0.0f];
        pathA.toValue = [NSNumber numberWithFloat:1.0f];
        [backSL addAnimation:pathA forKey:nil];
        
        frontSL = [CAShapeLayer layer];
        frontSL.path = circlePath.CGPath;
        frontSL.strokeColor = [UIColor blueColor].CGColor;
        frontSL.fillColor = [UIColor clearColor].CGColor;
        frontSL.lineWidth = CGRectGetMidX(self.bounds);
        frontSL.strokeStart = 0.0f;
        frontSL.strokeEnd = 0.0f;
        [self.layer addSublayer:frontSL];
        //self.layer.mask = backSL;//设置view 形状
        
        
    }
    return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CABasicAnimation *pathA = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathA.duration = 3;
    pathA.fromValue = [NSNumber numberWithFloat:0.0f];
    pathA.toValue = [NSNumber numberWithFloat:1.0f];
    [frontSL addAnimation:pathA forKey:@"strokeEnd1"];
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    currentP = [frontSL.presentationLayer strokeEnd];
    [frontSL removeAllAnimations];

    CABasicAnimation *pathA = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathA.duration = 1;
    pathA.fromValue = [NSNumber numberWithFloat:currentP];
    pathA.toValue = [NSNumber numberWithFloat:0.0f];
    [frontSL addAnimation:pathA forKey:@"strokeEnd2"];
    
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    
    frontSL.strokeEnd = 0.0f;
    [frontSL removeAllAnimations];
    
}


@end
