//
//  XiuXiuViewController.m
//  TTTT
//
//  Created by wxy on 16/3/17.
//  Copyright © 2016年 wuxianying. All rights reserved.
//

#import "XiuXiuViewController.h"
#import "UIImage+Image.h"

@interface XiuXiuViewController ()

@property (nonatomic,strong) UIButton *centerBtn;
@property (nonatomic,strong) UIView *subBtn;

@end

@implementation XiuXiuViewController
{
    CGFloat _buttonScale;
    CGFloat _defaultScale;
    CAAnimationGroup *_animaTionGroup;
    BOOL bStart;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0.224 green:0.373 blue:0.529 alpha:1.000];
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithWhite:1 alpha:0]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.224 green:0.373 blue:0.529 alpha:1.000]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    _buttonScale = 0.9;
    _defaultScale = 0.9;
    [self setTitleText:@"咻一咻"];
    self.view.layer.masksToBounds = YES;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidDisappear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    
}

#pragma mark initPro

-(UIButton *)centerBtn
{
    if (!_centerBtn) {
        
        _centerBtn = [UIButton new];
        [_centerBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:0.065 green:0.584 blue:0.906 alpha:1.000]] forState:UIControlStateNormal];
        [_centerBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:0.065 green:0.584 blue:0.906 alpha:0.354]] forState:UIControlStateHighlighted];
        
        [_centerBtn addTarget:self action:@selector(toucheDownd:) forControlEvents:UIControlEventTouchDown];
        [_centerBtn addTarget:self action:@selector(toucheUpOut:) forControlEvents:UIControlEventTouchUpOutside | UIControlEventTouchUpInside ];
        
        _centerBtn.layer.masksToBounds = YES;
        _centerBtn.layer.cornerRadius = SCREEN_W*0.15;
        [self.view addSubview:_centerBtn];
        
        
    }
    return _centerBtn;
}
-(UIView *)subBtn
{
    if (!_subBtn) {
        
        _subBtn = [UIView new];
        _subBtn.layer.cornerRadius = SCREEN_W*0.15;
        [self.view addSubview:_subBtn];
        
        
    }
    return _subBtn;
}



#pragma mark FUN

-(void)initView
{
  
    
    [self.subBtn makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(self.view);
        make.size.equalTo(self.view);
        
    }];
    [self.centerBtn makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(self.view);
        make.size.equalTo(CGSizeMake(SCREEN_W*0.3, SCREEN_W*0.3));
        
    }];
    
    //self.timer = [NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(addAnmation) userInfo:nil repeats:YES];
    //[self.timer setFireDate:[NSDate distantFuture]];
}

-(CAShapeLayer *)makeShape
{
    CAShapeLayer *layer = [CAShapeLayer layer];
    
    layer.fillColor = [UIColor colorWithRed:0.255 green:0.584 blue:0.906 alpha:1.000].CGColor;
    layer.path = [self maskPathWithDiameter:SCREEN_W*0.27].CGPath;
    layer.fillRule = kCAFillRuleEvenOdd;
    
    return layer;
}

-(UIBezierPath *)maskPathWithDiameter:(CGFloat)diameter
{
    CGPoint center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
    //UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, SCREEN_W, SCREEN_W)];//路径很重要和填充颜色
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:center];
    [path addArcWithCenter:center radius:diameter/2 startAngle:-M_PI/2 endAngle:M_PI *3.0/2.0 clockwise:YES];
    return path;
}

-(void)addAnmationWithRepeat:(NSNumber *)bRepeat
{
    
    CAShapeLayer *layer = [self makeShape];
   
    
    CAMediaTimingFunction *defaultCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];

    _animaTionGroup = [CAAnimationGroup animation];
    _animaTionGroup.delegate = self;
    _animaTionGroup.duration = 3;
    _animaTionGroup.fillMode = kCAFillModeForwards;
    _animaTionGroup.removedOnCompletion = NO;
    _animaTionGroup.timingFunction = defaultCurve;
    if ([bRepeat boolValue]) {
        _animaTionGroup.repeatCount = INFINITY;
    }
    

    
    [_animaTionGroup setValue:layer forKey:@"animationLayer"];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.toValue = (id)[self maskPathWithDiameter:SCREEN_H*0.8].CGPath;
    animation.duration = 3;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation2.fromValue = @0.3;
    animation2.toValue = @0.0;
    animation2.duration = 3;
    animation2.fillMode = kCAFillModeForwards;
    animation2.removedOnCompletion = NO;
    
//    CAKeyframeAnimation *opencityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
//    opencityAnimation.duration = 2;
//    opencityAnimation.values = @[@0.6,@0.2,@0.0];
//    opencityAnimation.keyTimes = @[@0,@1,@2];
//    opencityAnimation.removedOnCompletion = YES;
//    
    NSArray *animations = @[animation,animation2];
    
    _animaTionGroup.animations = animations;
    
    [layer addAnimation:_animaTionGroup forKey:@"expandAnimation"];
    [self.subBtn.layer addSublayer:layer];
    
}



-(void)addTwoAnmation
{
    [self addAnmationWithRepeat:[NSNumber numberWithBool:YES]];
   // [self performSelector:@selector(addAnmation) withObject:nil afterDelay:0.5];
    [self performSelector:@selector(addAnmationWithRepeat:) withObject:[NSNumber numberWithBool:YES] afterDelay:0.7];
    [self performSelector:@selector(addAnmationWithRepeat:) withObject:[NSNumber numberWithBool:YES] afterDelay:1.6];
    [self performSelector:@selector(addAnmationWithRepeat:) withObject:[NSNumber numberWithBool:YES] afterDelay:2.2];
}

#pragma mark selector

-(void)toucheDownd:(UIButton *)sender
{

    if (!bStart) {
        [self addTwoAnmation];
        bStart = YES;
    }
    [self addAnmationWithRepeat:[NSNumber numberWithBool:NO]];
    
    CGFloat scale = (_buttonScale && _buttonScale <= 1.0) ? _buttonScale :_defaultScale;
    [UIView animateWithDuration:0.3 animations:^{
       
        self.centerBtn.transform = CGAffineTransformMakeScale(scale, scale);
        
    } completion:^(BOOL finished) {

    }];
    
}

-(void)toucheUpOut:(UIButton *)sender
{

    [UIView animateWithDuration:0.3 animations:^{
       
        self.centerBtn.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {

    }];
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    CALayer *layer = (CALayer *)[anim valueForKey:@"animationLayer"];
    [layer removeFromSuperlayer];
    
}

-(void)dealloc
{
    for (CALayer *layer in [self.subBtn.layer sublayers]) {
        [layer removeAllAnimations];
        [layer removeFromSuperlayer];
    }
}

@end
