//
//  ShapelCircleView.m
//  TTTT
//
//  Created by 无线盈 on 15/9/23.
//  Copyright © 2015年 wuxianying. All rights reserved.
//

#import "ShapelCircleView.h"

@implementation ShapelCircleView
{

}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _lineWidth = 3;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = frame.size.width/2;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        _sLayer = [CAShapeLayer layer];
        UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(frame.size.width/2, frame.size.height/2) radius:CGRectGetMidX(self.bounds)-_lineWidth startAngle:-M_PI endAngle:M_PI clockwise:YES];
        _sLayer.path = circlePath.CGPath;
        _sLayer.lineWidth = _lineWidth;
        _sLayer.strokeColor = [UIColor whiteColor].CGColor;
        _sLayer.fillColor = [UIColor clearColor].CGColor;
        //_sLayer.fillRule = kCAFillRuleEvenOdd;
        _sLayer.lineCap = kCALineCapRound;
        _sLayer.strokeStart = 0.0f;
        _sLayer.strokeEnd = 0.0f;
        
        [self.layer addSublayer:_sLayer];
        
    }
    return self;
    
}

-(void)setStrokeEnd:(CGFloat)strokeEnd
{
    _sLayer.strokeEnd = strokeEnd;
}

@end
