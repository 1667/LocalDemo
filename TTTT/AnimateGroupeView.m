//
//  AnimateGroupeView.m
//  TTTT
//
//  Created by 无线盈 on 15/10/12.
//  Copyright © 2015年 wuxianying. All rights reserved.
//

#import "AnimateGroupeView.h"

@implementation AnimateGroupeView
{
    UIImageView *imageView;
}
-(void)initView
{
    UIButton *btn = [UIButton new];
    btn.backgroundColor = [Utils randomColor];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [btn makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(self);
        make.height.equalTo(80);
    }];
    
    [self setAnimageGrope];
    
    imageView = [[UIImageView alloc] initWithImage:[self getCurrentImage]];
    [imageView setFrame:CGRectMake(0, 300, SCREEN_W, 200)];
    [self addSubview:imageView];
    
}

-(void)setAnimageGrope
{
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(0, 150)];
    [path addCurveToPoint:CGPointMake(SCREEN_W, 150) controlPoint1:CGPointMake(SCREEN_W/4, 0) controlPoint2:CGPointMake(SCREEN_W/4*3, 300)];
    CAShapeLayer *slayer = [CAShapeLayer layer];
    slayer.path = path.CGPath;
    slayer.fillColor = [UIColor clearColor].CGColor;
    slayer.strokeColor = [UIColor redColor].CGColor;
    slayer.lineWidth = 3.0f;
    [self.layer addSublayer:slayer];
    
    CALayer *colorLayer = [CALayer layer];
    colorLayer.frame = CGRectMake(0, 0, 64, 64);
    colorLayer.position = CGPointMake(0, 150);
    colorLayer.backgroundColor = [Utils randomColor].CGColor;
    [self.layer addSublayer:colorLayer];
    
    CAKeyframeAnimation *anima1 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    anima1.path = path.CGPath;
    anima1.rotationMode = kCAAnimationRotateAuto;
    
    CABasicAnimation *anima2 = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    anima2.toValue = (__bridge id)[UIColor redColor].CGColor;
    
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[anima1,anima2];
    group.duration = 4.0;
    
    [colorLayer addAnimation:group forKey:nil];
    
}

-(void)btnClicked:(UIButton *)sender
{
    UIGraphicsBeginImageContextWithOptions(imageView.frame.size, YES, 0.0);
    [imageView.layer renderInContext:UIGraphicsGetCurrentContext()];//对图层截屏
    UIImage *coverImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *tmpView = [[UIImageView alloc] initWithImage:coverImage];
    tmpView.frame = imageView.frame;
    UIButton *tmpBtn = [UIButton new];
    tmpBtn.backgroundColor = [Utils randomColor];
    [tmpBtn setFrame:CGRectMake(0, 0,SCREEN_W, 30)];
    [tmpView addSubview:tmpBtn];
    [self addSubview:tmpView];
    
    [imageView setImage:[self getCurrentImage]];
    
    [UIView animateWithDuration:1.0 animations:^{
        tmpView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [tmpView removeFromSuperview];
    }];
}

@end
