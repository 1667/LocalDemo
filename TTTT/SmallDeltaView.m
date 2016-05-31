//
//  SmallDeltaView.m
//  TTTT
//
//  Created by wxy on 16/2/24.
//  Copyright © 2016年 wuxianying. All rights reserved.
//

#import "SmallDeltaView.h"

@interface SmallDeltaView()

@property (strong,nonatomic) CAShapeLayer *sLayer;

@end

@implementation SmallDeltaView


#pragma mark initPro

-(CAShapeLayer *)sLayer
{
    if (!_sLayer) {
        
        _sLayer = [CAShapeLayer layer];
        _sLayer.fillColor = [UIColor whiteColor].CGColor;
        _sLayer.frame = self.frame;
        self.layer.mask = _sLayer;
        
    
    }
    return _sLayer;
}

-(void)initView
{
    self.backgroundColor = [UIColor whiteColor];
    
    
}
//
-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.sLayer setPath:[self getPath].CGPath];
    self.sLayer.frame = self.bounds;
}

-(UIBezierPath *)getPath
{
    CGPoint startP = CGPointMake(0, self.bounds.size.height);
    CGPoint midP = CGPointMake(self.bounds.size.width/2, 0);
    CGPoint endP = CGPointMake(self.bounds.size.width, self.bounds.size.height);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:startP];
    [path addLineToPoint:midP];
    [path addLineToPoint:endP];
    //[path addLineToPoint:startP];
    return path;
}

@end











