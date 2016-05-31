//
//  LayerAnimationView.m
//  TTTT
//
//  Created by 无线盈 on 15/10/12.
//  Copyright © 2015年 wuxianying. All rights reserved.
//

#import "LayerAnimationView.h"

@implementation LayerAnimationView
{
    CALayer         *layer1;
    CALayer         *layer2;
    CAShapeLayer    *layer3;
    CALayer             *layer4;
    CAKeyframeAnimation *airanima;
    CALayer             *layer5;
    CABasicAnimation    *an5;
}
-(void)initView
{
    layer1 = [CALayer layer];
    layer1.frame = CGRectMake(10, 20, SCREEN_W-20, 200);
    layer1.contents = (__bridge id _Nullable)([self getCurrentImage].CGImage);
    [self.layer addSublayer:layer1];
    
    layer2 = [CALayer layer];
    layer2.frame = CGRectMake(10, 220, (SCREEN_W-20)/2, 100);
    layer2.backgroundColor = [Utils randomColor].CGColor;
    [self.layer addSublayer:layer2];
    
    
    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
    [bezierPath moveToPoint:CGPointMake(0, 420)];
    //[bezierPath addCurveToPoint:CGPointMake(SCREEN_W, 420) controlPoint1:CGPointMake(SCREEN_W/4, 220) controlPoint2:CGPointMake(SCREEN_W/4*3, 620)];
    [bezierPath addArcWithCenter:CGPointMake(SCREEN_W/2, 420) radius:100 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    
    layer3 = [CAShapeLayer layer];
    layer3.path = bezierPath.CGPath;
    layer3.fillColor = [UIColor clearColor].CGColor;
    layer3.strokeColor = [UIColor redColor].CGColor;
    layer3.lineWidth = 3.0f;
    layer3.lineCap = kCALineCapRound;
    [self.layer addSublayer:layer3];
    
    layer4 = [CALayer layer];
    layer4.frame = CGRectMake(0, 0, 64, 64);
    layer4.position = CGPointMake(0, 420);
    layer4.contents = (__bridge id _Nullable)([UIImage imageNamed:@"bike"].CGImage);
    [self.layer addSublayer:layer4];
    
    airanima = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    airanima.duration = 4.0;
    airanima.path = bezierPath.CGPath;
    airanima.delegate = self;
    //airanima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    airanima.timingFunction = [CAMediaTimingFunction functionWithControlPoints:1 :0 :0.8 :1];
    airanima.rotationMode = kCAAnimationRotateAuto;
    [airanima setValue:layer4 forKey:@"layer4"];//KVC为layer打标签
    [layer4 addAnimation:airanima forKey:nil];
    
    layer5 = [CALayer layer];
    layer5.frame = CGRectMake(SCREEN_W/4*3, 0, 80, 80);
    layer5.position = CGPointMake(SCREEN_W/4*3, 270);
    layer5.contents = (__bridge id _Nullable)([UIImage imageNamed:@"bike"].CGImage);
    [self.layer addSublayer:layer5];
    
    an5 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    an5.duration = 2.0;
    an5.byValue = @(M_PI * 2);
    //an5.delegate = self;
    
    [layer5 addAnimation:an5 forKey:@"layer5"];
    
    //[NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(rpeatbike) userInfo:nil repeats:YES];
    
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self];
    
    if ([layer1 hitTest:point]) {
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"contents"];
        animation.toValue = (__bridge id _Nullable)([self getCurrentImage].CGImage);
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeForwards;
        [layer1 addAnimation:animation forKey:nil];
        
    }
    if ([layer2 hitTest:point]) {
        CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"backgroundColor"];
        anim.duration = 2.0;
        anim.values = @[
                        (__bridge id)[UIColor blueColor].CGColor,
                        (__bridge id)[UIColor redColor].CGColor,
                        (__bridge id)[UIColor greenColor].CGColor,
                         ];
        CAMediaTimingFunction *fn = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn];
        anim.timingFunctions = @[fn, fn, fn];
        
        [layer2 addAnimation:anim forKey:nil];
        
        //[layer4 addAnimation:airanima forKey:nil];
    }
    
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    
    if (anim == [layer5 animationForKey:@"layer5"]) {
        [layer5 removeAllAnimations];
        [layer5 addAnimation:an5 forKey:@"layer5"];
    }
    else
    {
        [layer4 removeAllAnimations];
        [layer4 addAnimation:airanima forKey:nil];
    }
}


@end
