//
//  MatchManView.m
//  TTTT
//
//  Created by 无线盈 on 15/9/30.
//  Copyright © 2015年 wuxianying. All rights reserved.
//

#import "MatchManView.h"
#import "Utils.h"
#import "LayerLabel.h"

@implementation MatchManView
{
    UILabel             *lbl;
    CAShapeLayer        *leftleg;
    CAShapeLayer        *rightleg;
    
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
    UIBezierPath *path = [UIBezierPath new];
    [path addArcWithCenter:CGPointMake(SCREEN_W/2, 100) radius:25 startAngle:0 endAngle:2*M_PI clockwise:YES];
    [path moveToPoint:CGPointMake(SCREEN_W/2, 125)];
    [path addLineToPoint:CGPointMake(SCREEN_W/2, 175)];
    [path moveToPoint:CGPointMake(SCREEN_W/2-25, 150)];
    [path addLineToPoint:CGPointMake(SCREEN_W/2+25, 150)];
   // [self AddLinePath:path FromP:CGPointMake(SCREEN_W/2, 175) ToP:CGPointMake(SCREEN_W/2-10, 200)];
   // [self AddLinePath:path FromP:CGPointMake(SCREEN_W/2, 175) ToP:CGPointMake(SCREEN_W/2+10, 200)];
    
    leftleg = [self getLeg];
    leftleg.path = [self getLegPath].CGPath;
    leftleg.position = CGPointMake(SCREEN_W/2, 175);
    leftleg.anchorPoint = CGPointMake(0, 0.5);
    [self.layer addSublayer:leftleg];
    
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    ani.toValue = @(M_PI/8);
    ani.fromValue = @(-M_PI/8);
    ani.duration = 1.0;
    ani.repeatDuration = INFINITY;
    ani.autoreverses = YES;
    [leftleg addAnimation:ani forKey:nil];
    
    rightleg = [self getLeg];
    rightleg.path = [self getLegPath].CGPath;
    rightleg.position = CGPointMake(SCREEN_W/2, 175);
    rightleg.anchorPoint = CGPointMake(0, 0.5);
    [self.layer addSublayer:rightleg];
    
    CABasicAnimation *ani2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    ani2.fromValue = @(M_PI/8);
    ani2.toValue = @(-M_PI/8);
    ani2.duration = 1.0;
    ani2.repeatDuration = INFINITY;
    ani2.autoreverses = YES;
    [rightleg addAnimation:ani2 forKey:nil];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.strokeColor = [Utils randomColor].CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.lineCap = kCALineCapRound;
    layer.lineJoin = kCALineCapRound;
    layer.lineWidth = 5;
    layer.path = path.CGPath;
    
    [self.layer addSublayer:layer];
    
    [self addSubview:[self createThreeCornerView]];
    UIView *testLbl = [self TestLable];
    [self addSubview:testLbl];
    
    lbl = [UILabel new];// initWithFrame:CGRectMake(10, 220+HALF_SCREEN_W+10, SCREEN_W-40, 50)];
    [lbl setBackgroundColor:RANDOM_COLOR];
    lbl.numberOfLines = 0;
    //[lbl setTruncationMode];
    [lbl setFont:[UIFont systemFontOfSize:13]];
    [lbl setText:@"测试叔叔说 艰苦奋斗就是开了房间都上来看房间都上来看房间都上来看测试叔叔说 艰苦奋斗就是开了房间都上来看房间都上来看房间都上来看"];
    [lbl setTextColor:RANDOM_COLOR];
    [self addSubview:lbl];
    [lbl makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left).offset(30);
        make.width.equalTo(self.width).multipliedBy(0.4);
        make.top.equalTo(testLbl.bottom).offset(30);
       // make.bottom.lessThanOrEqualTo(self.bottom);
    }];
    
    LayerLabel *Llbl = [LayerLabel new];// initWithFrame:CGRectMake(10, 220+HALF_SCREEN_W+10, SCREEN_W-40, 50)];
    [Llbl setBackgroundColor:RANDOM_COLOR];
    Llbl.numberOfLines = 0;
    [Llbl setTruncationMode];
    [Llbl setFont:[UIFont systemFontOfSize:13]];
    [Llbl setText:@"测试叔叔说 艰苦奋斗就是开了房间都上来看房间都上来看房间都上来看测试叔叔说 艰苦奋斗就是开了房间都上来看房间都上来看房间都上来看"];
    [Llbl setTextColor:RANDOM_COLOR];
    [self addSubview:Llbl];
    [Llbl makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.right).offset(-30);
        make.width.equalTo(self.width).multipliedBy(0.4);
        make.top.equalTo(testLbl.bottom).offset(30);
        // make.bottom.lessThanOrEqualTo(self.bottom);
    }];
}

-(CAShapeLayer *)getLeg
{
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.strokeColor = [Utils randomColor].CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.lineCap = kCALineCapRound;
    layer.lineJoin = kCALineCapRound;
    layer.lineWidth = 5;
    
    return layer;
    
}

-(UIView *)createThreeCornerView
{
    CGRect frame = CGRectMake(30, 220, HALF_SCREEN_W-50, HALF_SCREEN_W);
    UIView *view = [[UIView alloc] initWithFrame:frame];
    [view setBackgroundColor:[Utils randomColor]];
    UIRectCorner corners = UIRectCornerTopRight|UIRectCornerTopLeft;
    CGSize radii = CGSizeMake(20, 20);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, HALF_SCREEN_W-50, HALF_SCREEN_W) byRoundingCorners:corners cornerRadii:radii];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.lineWidth = 1;
    layer.strokeColor = CLEAR_COLOR.CGColor;
    layer.fillColor = RANDOM_COLOR.CGColor;
    layer.lineCap = kCALineCapRound;
    layer.path = path.CGPath;
    view.layer.mask = layer;
    
    return view;
}

-(UIView *)TestLable
{
    CGRect frame = CGRectMake(30+HALF_SCREEN_W, 220, HALF_SCREEN_W-50, HALF_SCREEN_W);
    UIView *view = [[UIView alloc] initWithFrame:frame];
    [view setBackgroundColor:WHITE_COLOR];
    
    CATextLayer *tL = [CATextLayer layer];
    tL.frame = view.bounds;
    [view.layer addSublayer:tL];
    tL.foregroundColor = [UIColor blackColor].CGColor;
    tL.alignmentMode = kCAAlignmentJustified;
    tL.truncationMode = kCATruncationEnd;
    tL.wrapped = YES;
    
    UIFont *font = [UIFont systemFontOfSize:15];
    
    CFStringRef fontName = (__bridge CFStringRef)(font.fontName);
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    
    tL.font = fontRef;
    tL.fontSize = font.pointSize;
    CGFontRelease(fontRef);
    
    NSString *str = @"则是侧hi是从升温版则是侧hi真方便是从升温版则是侧hi是从升温版则是侧hi是从升温版则是侧hi是从升温版则是侧hi是从升温版则是侧hi是从升温版则是侧hi是从升温版";
    
    tL.string = str;
    tL.contentsScale = [UIScreen mainScreen].scale;
    return view;
}

-(UIBezierPath *)getLegPath
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [self AddLinePath:path FromP:CGPointMake(0, 0) ToP:CGPointMake(0, 30)];
//    [self AddLinePath:path FromP:CGPointMake(SCREEN_W/2, 175) ToP:CGPointMake(SCREEN_W/2-10, 200)];
    return path;
}


-(CGPoint)makePointX:(CGFloat)x Y:(CGFloat)y
{
    return CGPointMake(x, y);
    
}

-(void)AddLinePath:(UIBezierPath *)path FromP:(CGPoint)fp ToP:(CGPoint)top
{
    [path moveToPoint:fp];
    [path addLineToPoint:top];
}

@end
