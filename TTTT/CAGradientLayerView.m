//
//  CAGradientLayerView.m
//  TTTT
//
//  Created by 无线盈 on 15/9/30.
//  Copyright © 2015年 wuxianying. All rights reserved.
//

#import "CAGradientLayerView.h"
#import "Utils.h"

#define V_W     (SCREEN_W/2-30)

@implementation CAGradientLayerView
{
    CAShapeLayer *maskLayer;
    NSInteger      maskX;
    UIView          *replicatorView;
    CGFloat         h;
    
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
    [self createGradientView];
    [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(tick) userInfo:nil repeats:YES];
    
    CGSize size = [self cacleSizeWithImage:[UIImage imageNamed:@"tu8601_5.jpg"] Width:self.frame.size.width];
    h = size.height;
    replicatorView = [self createReplicatorView];
    [self addSubview:replicatorView];
    
    
    [replicatorView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left).offset(10);
        make.right.equalTo(self.right).offset(-10);
        make.top.equalTo(self.top).offset(40);
        make.height.equalTo(size.height);
    }];
//    
    UIView *v = [UIView new];
    v.backgroundColor = [Utils randomColor];
    [self addSubview:v];
    [v makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(replicatorView);
        make.top.equalTo(replicatorView.bottom).offset(10);
        make.height.equalTo(10);
    }];
    
}

-(CGSize)cacleSizeWithImage:(UIImage *)image Width:(CGFloat)width
{
    CGSize imageSize = image.size;
    CGFloat sclce = imageSize.width/width;
    CGFloat hight = imageSize.height/sclce;
    return CGSizeMake(width, hight);
}

-(void)updateConstraints
{
    if (h != 0) {
        
        [replicatorView updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(h);
        }];
    }
    [super updateConstraints];
}

-(void)changeRepH
{
    h = 200;
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:0.4 animations:^{
        [self layoutIfNeeded];
    }];
}

-(UIView *)createGradientView
{
    UIView *vb = [[UIView alloc] initWithFrame:CGRectMake(10, 10, SCREEN_W-20, 5)];
    vb.layer.masksToBounds = YES;
    vb.layer.cornerRadius = 2.5;
    [vb setBackgroundColor:[UIColor lightGrayColor]];
    [self addSubview:vb];
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(10, 10, SCREEN_W-20, 5)];
    v.layer.masksToBounds = YES;
    v.layer.cornerRadius = 2.5;
    //[v setBackgroundColor:RANDOM_COLOR];
    [self addSubview:v];

    
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = v.bounds;
    [v.layer addSublayer:layer];
    
    layer.colors = @[(__bridge id)[UIColor clearColor].CGColor,(__bridge id)[UIColor redColor].CGColor];
    layer.locations = @[@0.3,@0.7];
    layer.startPoint = CGPointMake(0, 1);
    layer.endPoint = CGPointMake(1, 1);
    
    maskLayer = [CAShapeLayer layer];
    maskLayer.fillColor = RANDOM_COLOR.CGColor;
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 20, 5)];
    maskLayer.path = path.CGPath;
    maskLayer.lineCap = kCALineCapRound;
    v.layer.mask = maskLayer;
    
    return v;
}

-(void)tick
{
    
    maskX++;
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, maskX % (NSInteger)(SCREEN_W-20), 5)];
    maskLayer.path = path.CGPath;
    if (maskX == self.frame.size.width) {
        [self changeRepH];
    }
}

-(UIView *)createReplicatorView
{
    UIView *v = [UIView new];
    //v.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"tu8601_5.jpg"].CGImage);
    
    CAReplicatorLayer *layer = [CAReplicatorLayer layer];
    layer.instanceCount = 3;
    CATransform3D transform = CATransform3DIdentity;
    CGFloat vo = h*2+2;
    transform = CATransform3DTranslate(transform, 0, vo, 0);
    transform = CATransform3DScale(transform, 1, -1, 0);
    layer.instanceTransform = transform;
    
    layer.instanceAlphaOffset = -0.6;
    [v.layer addSublayer:layer];
    
    CALayer *imagelayer = [CALayer layer];
    imagelayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"tu8601_5.jpg"].CGImage);
    imagelayer.frame = CGRectMake(0, 0, self.frame.size.width-20, h);
    [layer addSublayer:imagelayer];
    
    return v;
    
}

















@end
