//
//  ImageToVIew.m
//  TTTT
//
//  Created by 无线盈 on 15/10/12.
//  Copyright © 2015年 wuxianying. All rights reserved.
//

#import "ImageToVIew.h"

@implementation ImageToVIew
{
    CALayer         *showLayer;
}
-(void)initView
{
    showLayer = [CALayer layer];
    showLayer.frame = CGRectMake(10, 20, 120, 80);
    showLayer.backgroundColor = [Utils randomColor].CGColor;
    showLayer.contents = (__bridge id _Nullable)([self getCurrentImage].CGImage);
    [self.layer addSublayer:showLayer];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self];
    if ([showLayer.presentationLayer hitTest:point]) {
        showLayer.contents = (__bridge id _Nullable)([self getCurrentImage].CGImage);
    }
    else
    {
        [CATransaction begin];
        [CATransaction setAnimationDuration:4.0];
        showLayer.position = point;
        [CATransaction commit];
    }
    
}

@end
