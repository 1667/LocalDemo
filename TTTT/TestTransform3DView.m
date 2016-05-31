//
//  TestTransform3DView.m
//  TTTT
//
//  Created by 无线盈 on 15/9/30.
//  Copyright © 2015年 wuxianying. All rights reserved.
//

#import "TestTransform3DView.h"
#import "Utils.h"

@implementation TestTransform3DView
{
    CATransformLayer *cubeL;
    BOOL             bStart;
    NSTimer           *timer;
    NSInteger           rangle;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

-(CALayer *)faceWithTransform:(CATransform3D)transform
{
    CALayer *face = [CALayer layer];
    
    face.frame = CGRectMake(-50, -50, 100, 100);
    face.backgroundColor = RANDOM_COLOR.CGColor;
    
    face.transform = transform;
    return face;
    
}

-(CATransformLayer *)cubeWithTransform:(CATransform3D)tansform
{
    CATransformLayer *cube = [CATransformLayer layer];
    
    CATransform3D ct = CATransform3DMakeTranslation(0, 0, 50);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    ct = CATransform3DMakeTranslation(50, 0, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    //add cube face 3
    ct = CATransform3DMakeTranslation(0, -50, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 1, 0, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    //add cube face 4
    ct = CATransform3DMakeTranslation(0, 50, 0);
    ct = CATransform3DRotate(ct, -M_PI_2, 1, 0, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    //add cube face 5
    ct = CATransform3DMakeTranslation(-50, 0, 0);
    ct = CATransform3DRotate(ct, -M_PI_2, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    //add cube face 6
    ct = CATransform3DMakeTranslation(0, 0, -50);
    ct = CATransform3DRotate(ct, M_PI, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    //center the cube layer within the container
    
    CGSize containerSize = self.bounds.size;
    cube.position = CGPointMake(containerSize.width / 2.0, containerSize.height / 2.0);
    //apply the transform and return
    cube.transform = tansform;
    return cube;
    
    
    
}

-(void)initView
{
    CATransform3D pt = CATransform3DIdentity;
    pt.m34 = -1.0/500.0;
    self.layer.sublayerTransform = pt;
    
    
    CATransform3D c1t = CATransform3DIdentity;
    c1t = CATransform3DTranslate(c1t, 0, 0, 0);
    cubeL = [self cubeWithTransform:c1t];
    [self.layer addSublayer:cubeL];
    
    UIButton *btn = [UIButton new];
    [btn setBackgroundColor:RANDOM_COLOR];
    [btn addTarget:self action:@selector(start:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    [btn makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(0, 10, 0, 10));
        make.height.equalTo(self.height).multipliedBy(0.1);
    }];
    
}

-(void)start:(id)sender
{
    
    if (bStart) {
        [timer invalidate];
        bStart = NO;
    }
    else
    {
        timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(tick) userInfo:nil repeats:YES];
        bStart = YES;
    }
    
}

-(void)tick
{
    CATransform3D ct = cubeL.transform;
    ct = CATransform3DRotate(ct, DEGREES_TO_RADIANS(1), 0, 0, 1);
    ct = CATransform3DRotate(ct, DEGREES_TO_RADIANS(1), 0, 1, 0);
    ct = CATransform3DRotate(ct, DEGREES_TO_RADIANS(1), 1, 0, 0);
    cubeL.transform = ct;
    
    
}

@end
