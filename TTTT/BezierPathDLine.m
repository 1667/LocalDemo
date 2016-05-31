//
//  BezierPathDLine.m
//  TTTT
//
//  Created by 无线盈 on 15/10/13.
//  Copyright © 2015年 wuxianying. All rights reserved.
//

#import "BezierPathDLine.h"

@implementation BezierPathDLine
{
    UIBezierPath        *path;
}

+(Class)layerClass
{
    return [CAShapeLayer class];
}

-(void)initView
{
    [self setBackgroundColor:[UIColor whiteColor]];
    path = [UIBezierPath new];
    
    
    CAShapeLayer *shapelayer = (CAShapeLayer *)self.layer;
    shapelayer.strokeColor = [UIColor redColor].CGColor;
    shapelayer.fillColor = [UIColor clearColor].CGColor;
    shapelayer.lineJoin = kCALineJoinRound;
    shapelayer.lineCap = kCALineCapRound;
    shapelayer.lineWidth = 5;
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self];
    [path moveToPoint:point];
    
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self];
    
    [path addLineToPoint:point];
    ((CAShapeLayer *)self.layer).path = path.CGPath;
}


@end
