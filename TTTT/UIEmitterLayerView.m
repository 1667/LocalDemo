//
//  UIEmitterLayerView.m
//  TTTT
//
//  Created by 无线盈 on 15/10/8.
//  Copyright © 2015年 wuxianying. All rights reserved.
//

#import "UIEmitterLayerView.h"
#import "Utils.h"

@interface UIEmitterLayerView()

    
@property (strong,nonatomic)						CAEmitterLayer	*emitter;


@end

@implementation UIEmitterLayerView
{
    UIView *view;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

-(void)initView
{
    view = [self creatEmitterViewWithFrame:CGRectMake(10, 100, self.frame.size.width*0.2, self.frame.size.width*0.2)];
    [self addSubview:view];
    view.center = CGPointMake(self.frame.size.width/2, 80);
    CABasicAnimation *heartsBurst = [CABasicAnimation animationWithKeyPath:@"emitterCells.cell.birthRate"];
    heartsBurst.fromValue		= [NSNumber numberWithFloat:150.0];
    heartsBurst.toValue			= [NSNumber numberWithFloat:  0.0];
    heartsBurst.duration		= 5.0;
    heartsBurst.timingFunction	= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    [_emitter addAnimation:heartsBurst forKey:@"heartsBurst"];
}

-(UIView *)creatEmitterViewWithFrame:(CGRect)frame
{
    UIView *v = [UIView new];
    
    _emitter = [CAEmitterLayer layer];
    _emitter.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    
    
    _emitter.renderMode = kCAEmitterLayerAdditive;
    _emitter.emitterPosition = CGPointMake(0,0);
    
    CAEmitterCell *cell = [[CAEmitterCell alloc] init];
    cell.contents = (__bridge id _Nullable)([UIImage imageNamed:@"DazHeart"].CGImage);
    cell.birthRate = 0;
    cell.lifetime = 5.0;
    cell.color = [Utils randomColor].CGColor;
    cell.alphaSpeed = -0.05;
    cell.velocity = 50;
    cell.velocityRange = 50;
    cell.emissionRange = M_PI*2.0;
    
    cell.name = @"cell";
    cell.scale = 0.1;
    cell.scaleSpeed = 0.5;
    _emitter.emitterCells = @[cell];
    
    
    
    [v.layer addSublayer:_emitter];
    return v;
}

@end
