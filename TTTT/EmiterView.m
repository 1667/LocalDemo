//
//  EmiterView.m
//  TTTT
//
//  Created by wxy on 16/2/2.
//  Copyright © 2016年 wuxianying. All rights reserved.
//

#import "EmiterView.h"

@implementation EmiterView
{
    CAEmitterLayer *snowEmitter;
}
-(void)initView
{
    snowEmitter = [CAEmitterLayer layer];
    snowEmitter.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H);
    snowEmitter.emitterPosition = CGPointMake(SCREEN_W/2, -SCREEN_H);
    snowEmitter.emitterSize		= CGSizeMake(SCREEN_W, 1);;
    snowEmitter.contentsGravity = kCAGravityResizeAspect;
    // Spawn points for the flakes are within on the outline of the line
    snowEmitter.emitterMode		= kCAEmitterLayerOutline;
    snowEmitter.emitterShape	= kCAEmitterLayerLine;
    snowEmitter.speed           = 4;
    //snowEmitter.renderMode      = kCAEmitterLayerAdditive;
    // Configure the snowflake emitter cell
    CAEmitterCell *snowflake = [CAEmitterCell emitterCell];
    
    snowflake.birthRate		= 0;
    snowflake.lifetime		= 50.0;
    
    snowflake.velocity		= 50;				// falling down slowly
    snowflake.velocityRange = 0;
    snowflake.yAcceleration = 5;
    //snowflake.emissionRange = 0.5 * M_PI;		// some variation in angle
    //snowflake.spinRange		= 0.25 * M_PI;		// slow spin
    snowflake.name = @"cell";
    snowflake.contents		= (id) [[UIImage imageNamed:@"redheart"] CGImage];
    
    //snowflake.color			= [[UIColor colorWithRed:0.600 green:0.658 blue:0.743 alpha:1.000] CGColor];
    
    // Make the flakes seem inset in the background
    //    snowEmitter.shadowOpacity = 1.0;
    //    snowEmitter.shadowRadius  = 0.0;
    //    snowEmitter.shadowOffset  = CGSizeMake(0.0, 1.0);
    //    snowEmitter.shadowColor   = [[UIColor whiteColor] CGColor];
    
    // Add everything to our backing layer below the UIContol defined in the storyboard
    snowEmitter.emitterCells = @[snowflake];
    //    [self.view.layer insertSublayer:snowEmitter atIndex:0];
    [self.layer addSublayer:snowEmitter];
    UIButton *controlBtn = [UIButton new];
    [controlBtn setTitle:@"开始" forState:UIControlStateNormal];
    [controlBtn addTarget:self action:@selector(controlBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    controlBtn.backgroundColor = [Utils randomColor];
    [self addSubview:controlBtn];
    [controlBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(50);
    }];

}

-(void)controlBtnClicked:(UIButton *)sender
{
    //[self.view.layer insertSublayer:snowEmitter atIndex:0];
    CABasicAnimation *heartsBurst = [CABasicAnimation animationWithKeyPath:@"emitterCells.cell.birthRate"];
    heartsBurst.fromValue		= [NSNumber numberWithFloat:1.0];
    heartsBurst.toValue			= [NSNumber numberWithFloat:  0.0];
    heartsBurst.duration		= 0.01;
    heartsBurst.timingFunction	= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    [snowEmitter addAnimation:heartsBurst forKey:@"heartsBurst"];
    
    
}

@end
