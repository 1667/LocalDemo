//
//  DispatchView.m
//  TTTT
//
//  Created by wxy on 16/2/2.
//  Copyright © 2016年 wuxianying. All rights reserved.
//

#import "DispatchView.h"

#define HeartCount      30

@implementation DispatchView
{

}
-(void)initView
{
    UIButton *controlBtn = [UIButton new];
    [controlBtn setTitle:@"开始" forState:UIControlStateNormal];
    [controlBtn addTarget:self action:@selector(startAn:) forControlEvents:UIControlEventTouchUpInside];
    controlBtn.backgroundColor = [Utils randomColor];
    [self addSubview:controlBtn];
    [controlBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(50);
    }];
    
    
    
}

-(void)addLayerToSelf
{
    
    NSInteger x = [self getRandomX];
    NSInteger y = [self getRandomY];
    CALayer *tmpLayer = [CALayer layer];
    tmpLayer.frame = CGRectMake(0, 0, 30, 30);
    tmpLayer.position = CGPointMake(x, y);
    tmpLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"redheart"].CGImage);
    [self.layer addSublayer:tmpLayer];
    
    CAKeyframeAnimation *airanima = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    airanima.path = [self createLinePathFromPoint:CGPointMake(x, y) Topoint:CGPointMake(x, SCREEN_H)].CGPath;
    airanima.removedOnCompletion = NO;
    airanima.fillMode = kCAFillModeForwards;
    airanima.duration = 1;
    [airanima setValue:tmpLayer forKey:@"animationLayer"];
    airanima.delegate = self;
    [tmpLayer addAnimation:airanima forKey:@"strokeEnd3"];
    
}

-(UIBezierPath *)createLinePathFromPoint:(CGPoint)from Topoint:(CGPoint)topoint
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:from];
    [path addLineToPoint:topoint];
    return path;
}

-(NSInteger)getRandomX
{
    NSInteger w = SCREEN_W;
    return arc4random()%w;
    
}

-(NSInteger)getRandomY
{
    return arc4random()%80;
}

-(void)startAn:(UIButton *)sender
{
    for (NSInteger i = 0; i < HeartCount; i++) {

            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(i*0.03*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self addLayerToSelf];
                });
                
                
            });
        
    }
    

}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    CALayer *layer = (CALayer *)[anim valueForKey:@"animationLayer"];
    [layer removeFromSuperlayer];
    
}

@end
