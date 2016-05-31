//
//  DrawHeartView.m
//  TTTT
//
//  Created by wxy on 16/2/3.
//  Copyright © 2016年 wuxianying. All rights reserved.
//

#import "DrawHeartView.h"

@implementation DrawHeartView
{
    CAShapeLayer *sLayer;
}
-(void)initView
{
    sLayer = [CAShapeLayer layer];
    sLayer.fillColor = [UIColor clearColor].CGColor;
    sLayer.strokeColor = [UIColor redColor].CGColor;
    sLayer.lineCap = kCALineCapRound;
    sLayer.lineJoin = kCALineCapRound;
    sLayer.lineWidth = 1;
    sLayer.path = [self getPath].CGPath;
    sLayer.strokeEnd = 0.0f;
    [self.layer addSublayer:sLayer];
    
    UIButton *controlBtn = [UIButton new];
    [controlBtn setTitle:@"开始" forState:UIControlStateNormal];
    [controlBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    controlBtn.backgroundColor = [Utils randomColor];
    [self addSubview:controlBtn];
    [controlBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(50);
    }];
    
}

-(UIBezierPath *)getPath
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(SCREEN_W/2, 210)];
    [path addCurveToPoint:CGPointMake(SCREEN_W/2, 320) controlPoint1:CGPointMake(SCREEN_W/6, 140) controlPoint2:CGPointMake(SCREEN_W/3, 320)];
    [path addCurveToPoint:CGPointMake(SCREEN_W/2, 210) controlPoint1:CGPointMake(SCREEN_W/3*2, 320) controlPoint2:CGPointMake(SCREEN_W/6*5, 140)];

    
    return path;
}

-(void)btnClicked:(UIButton *)sender
{
    CABasicAnimation *pathA = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathA.duration = 2;
    pathA.fromValue = [NSNumber numberWithFloat:0.0f];
    pathA.toValue = [NSNumber numberWithFloat:1.0f];
    pathA.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    pathA.delegate = self;
    [sLayer addAnimation:pathA forKey:@"heartD"];
    
    
}

-(void)animationDidStart:(CAAnimation *)anim
{
    sLayer.fillColor = [UIColor clearColor].CGColor;
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    sLayer.fillColor = [UIColor redColor].CGColor;
}


@end
