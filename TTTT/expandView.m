//
//  expandView.m
//  TTTT
//
//  Created by 无线盈 on 15/9/29.
//  Copyright © 2015年 wuxianying. All rights reserved.
//

#import "expandView.h"
#import "Utils.h"

#define DEFAULT_PADDING     10

@interface expandView()

@property (nonatomic, strong) CAShapeLayer *borderLayer;//中间的圆透明，圆与边框之间的内容半透明的layer
@property (nonatomic, assign) BOOL isAnimating;
@property (nonatomic, strong) UIImageView   *imageView;


@end

@implementation expandView


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
    _imageView = [UIImageView new];
    [_imageView setImage:[UIImage imageNamed:@"tu8601_5.jpg"]];
    _imageView.layer.masksToBounds = YES;
    [self addSubview:_imageView];
    
    [_imageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left).offset(DEFAULT_PADDING);
        make.right.equalTo(self.right).offset(-DEFAULT_PADDING);
        make.height.equalTo(_imageView.width);
        make.centerY.equalTo(self.centerY);
        
    }];
    
    UIButton *toBig = [UIButton new];
    toBig.backgroundColor = [Utils randomColor];
    [self addSubview:toBig];
    [toBig makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(self);
        make.height.equalTo(self.height).multipliedBy(0.1);
        
    }];
    [toBig addTarget:self action:@selector(ToBig:) forControlEvents:UIControlEventTouchUpInside];
    //_imageView.layer.mask = self.borderLayer;
    [_imageView.layer addSublayer:self.borderLayer];
}

-(CAShapeLayer *)borderLayer
{
    if (!_borderLayer) {
        _borderLayer = [CAShapeLayer layer];
        _borderLayer.fillColor = [UIColor colorWithWhite:1 alpha:1].CGColor;
        _borderLayer.path = [self maskPathWithDiameter:CGRectGetMaxX(self.bounds)-40].CGPath;
        _borderLayer.fillRule = kCAFillRuleEvenOdd;
        
    }
    return _borderLayer;
}

-(void)ToBig:(id)sender
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.toValue = (id)[self maskPathWithDiameter:self.bounds.size.width*2].CGPath;
    animation.duration = 2.0;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    [self.borderLayer addAnimation:animation forKey:@"expandAnimation"];
}

-(UIBezierPath *)maskPathWithDiameter:(CGFloat)diameter
{
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, self.bounds.size.width-20, self.bounds.size.width-20)];//路径很重要和填充颜色
    [path moveToPoint:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds))];
    [path addArcWithCenter:CGPointMake(CGRectGetMidX(self.bounds)-10, CGRectGetMidY(self.bounds)/2+10) radius:diameter/2 startAngle:-M_PI/2 endAngle:M_PI *3.0/2.0 clockwise:YES];
    NSLog(@"%@  %@",[NSValue valueWithCGPoint:CGPointMake(CGRectGetMidX(self.bounds)-10, CGRectGetMidY(self.bounds)/2+10)],[NSValue valueWithCGPoint:self.center]);
    return path;
}

@end
