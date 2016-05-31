//
//  DurationView.m
//  TTTT
//
//  Created by 无线盈 on 15/10/12.
//  Copyright © 2015年 wuxianying. All rights reserved.
//

#import "DurationView.h"

@implementation DurationView
{
    CALayer         *layer;
    BOOL            bStart;
    
    CALayer         *planeLayer;
    CFTimeInterval  currentTimeOffset;
    CALayer         *ballLayer;
    
}

-(void)initView
{
    layer = [CALayer layer];
    
    layer.frame = CGRectMake(0, 0, 80, 80);
    layer.position = CGPointMake(60, 50);
    layer.contents = (__bridge id)[UIImage imageNamed:@"bike"].CGImage;
    [self.layer addSublayer:layer];
    
    planeLayer = [CALayer layer];
    planeLayer.frame = CGRectMake(0, 0, 80, 80);
    planeLayer.position = CGPointMake(SCREEN_W/2+10, 50);
    planeLayer.contents = (__bridge id)[UIImage imageNamed:@"helicopter7"].CGImage;
    planeLayer.anchorPoint = CGPointMake(0, 0.5);
    [self.layer addSublayer:planeLayer];
    
    CATransform3D per = CATransform3DIdentity;
    per.m34 = -1.0/500.0;
    self.layer.sublayerTransform = per;
    
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    ani.toValue = @(-M_PI_2);
    ani.duration = 2.0;
    ani.repeatDuration = INFINITY;
    ani.autoreverses = YES;
    [planeLayer addAnimation:ani forKey:nil];
    
    CABasicAnimation *an = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    an.duration = 2.0;
    an.repeatCount = INFINITY;
    an.byValue = @(M_PI *2);
    an.delegate = self;
    an.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    an.removedOnCompletion = NO;
    an.fillMode = kCAFillModeBackwards;
    [layer addAnimation:an forKey:@"roate"];
    
    ballLayer = [CALayer layer];
    ballLayer.frame = CGRectMake(0, 0, 60, 60);
    ballLayer.position = CGPointMake(SCREEN_W/2, 80);
    ballLayer.contents = (__bridge id)([UIImage imageNamed:@"bike"].CGImage);
    [self.layer addSublayer:ballLayer];
    [self addBoundsAnimationToLayer:ballLayer fromValue:CGPointMake(SCREEN_W/2, 80) toValue:CGPointMake(SCREEN_W/2, 300)];
    
}

float interpolate(float from, float to, float time)
{
    return (to - from) * time + from;
}
- (id)interpolateFromValue:(id)fromValue toValue:(id)toValue time:(float)time
{
    if ([fromValue isKindOfClass:[NSValue class]]) {
        //get type
        const char *type = [fromValue objCType];
        if (strcmp(type, @encode(CGPoint)) == 0) {
            CGPoint from = [fromValue CGPointValue];
            CGPoint to = [toValue CGPointValue];
            CGPoint result = CGPointMake(interpolate(from.x, to.x, time), interpolate(from.y, to.y, time));
            return [NSValue valueWithCGPoint:result];
        }
    }
    //provide safe default implementation
    return (time < 0.5)? fromValue: toValue;
}
float bounceEaseOut(float t)
{
    if (t < 4/11.0) {
        return (121 * t * t)/16.0;
    } else if (t < 8/11.0) {
        return (363/40.0 * t * t) - (99/10.0 * t) + 17/5.0;
    } else if (t < 9/10.0) {
        return (4356/361.0 * t * t) - (35442/1805.0 * t) + 16061/1805.0;
    }
    return (54/5.0 * t * t) - (513/25.0 * t) + 268/25.0;
}
-(void)addBoundsAnimationToLayer:(CALayer *)blayer fromValue:(CGPoint)fromPoint toValue:(CGPoint )toPoint
{
    blayer.position = CGPointMake(SCREEN_W/2, 300);
    //set up animation parameters
    NSValue *fromValue = [NSValue valueWithCGPoint:fromPoint];
    NSValue *toValue = [NSValue valueWithCGPoint:toPoint];
    CFTimeInterval duration = 1.0;
    //generate keyframes
    NSInteger numFrames = duration * 60;
    NSMutableArray *frames = [NSMutableArray array];
    for (int i = 0; i < numFrames; i++) {
        float time = 1/(float)numFrames * i;
        //apply easing
        time = bounceEaseOut(time);
        [frames addObject:[self interpolateFromValue:fromValue toValue:toValue time:time]];
    }
    //create keyframe animation
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.duration = 1.0;
    //animation.delegate = self;
    animation.values = frames;
    NSLog(@"%@",frames);
    //apply animation
    [blayer addAnimation:animation forKey:nil];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self];
    if ([layer hitTest:point]) {
        if (!bStart) {
            bStart = YES;
            CFTimeInterval ctime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
            layer.speed = 0;
            layer.timeOffset = ctime;
        }
        else
        {
            bStart = NO;
            CFTimeInterval pausedTime = [layer timeOffset];
            layer.speed = 1.0;
            layer.timeOffset = 0.0;
            layer.beginTime = 0.0;
            CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
            layer.beginTime = timeSincePause;
            
        }
        
    };
    if ([ballLayer hitTest:point]) {
        //[ballLayer removeAllAnimations];
        [self addBoundsAnimationToLayer:ballLayer fromValue:CGPointMake(SCREEN_W/2, 80) toValue:CGPointMake(SCREEN_W/2, 300)];
    }
}



@end
