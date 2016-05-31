//
//  CuteView.m
//  TTTT
//
//  Created by 无线盈 on 15/9/29.
//  Copyright © 2015年 wuxianying. All rights reserved.
//

#import "CuteView.h"
#import "Utils.h"

#import <GLKit/GLKit.h>

#define LBL_H       200

#define LIGHT_DIRECTION 0, 1, -0.5
#define AMBIENT_LIGHT 0.5

@implementation CuteView
{
    NSMutableArray *lableArray;
    UIView          *collView;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        lableArray = [NSMutableArray new];
        
        [self initView];
    }
    return self;
}

-(void)initView
{
    [self setBackgroundColor:[UIColor lightGrayColor]];
    collView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, LBL_H, LBL_H)];
    collView.center = CGPointMake(self.center.x, 260);
    collView.backgroundColor = [UIColor clearColor];
    [self addSubview:collView];
    for (int i = 0; i < 6; i++) {
        UILabel *lbl = [self createlableWithTag:i];
        [lableArray addObject:lbl];
    }
    
    CATransform3D per = CATransform3DIdentity;
    per.m34 = -1.0/500.0;
    
    per = CATransform3DRotate(per, -M_PI_4, 1, 0, 0);
    per = CATransform3DRotate(per, -M_PI_4, 0, 1, 0);
    
    collView.layer.sublayerTransform = per;
    
    CATransform3D transform = CATransform3DMakeTranslation(0, 0, 100);
    [self addFace:0 withTransform:transform];
    
    transform = CATransform3DMakeTranslation(100, 0, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 0, 1, 0);
    [self addFace:1 withTransform:transform];

    
    
    transform = CATransform3DMakeTranslation(0, 100, 0);
    transform = CATransform3DRotate(transform, -M_PI_2, 1, 0, 0);
    [self addFace:3 withTransform:transform];
    
    transform = CATransform3DMakeTranslation(-100, 0, 0);
    transform = CATransform3DRotate(transform, -M_PI_2, 0, 1, 0);
    [self addFace:4 withTransform:transform];
    
    transform = CATransform3DMakeTranslation(0, 0, -100);
    transform = CATransform3DRotate(transform, M_PI, 0, 1, 0);
    [self addFace:5 withTransform:transform];
    
    transform = CATransform3DMakeTranslation(0, -100, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 1, 0, 0);
    [self addFace:2 withTransform:transform];
    
    UILabel *lbl = lableArray[3];
    [collView bringSubviewToFront:lbl];
    
    
}

- (void)applyLightingToFace:(CALayer *)face//添加阴影
{
    //add lighting layer
    CALayer *layer = [CALayer layer];
    layer.frame = face.bounds;
    [face addSublayer:layer];
    //convert the face transform to matrix
    //(GLKMatrix4 has the same structure as CATransform3D)
    
    CATransform3D transform = face.transform;
    float a[16] = {(float)transform.m11,(float)transform.m12,(float)transform.m13,(float)transform.m14, (float)transform.m21,(float)transform.m22,(float)transform.m23,(float)transform.m24, (float)transform.m31,(float)transform.m32,(float)transform.m33,(float)transform.m34, (float)transform.m41,(float)transform.m42,(float)transform.m43,(float)transform.m44};
    GLKMatrix4 matrix4 = GLKMatrix4MakeWithArray(a);
    GLKMatrix3 matrix3 = GLKMatrix4GetMatrix3(matrix4);
    //get face normal
    GLKVector3 normal = GLKVector3Make(0, 0, 1);
    normal = GLKMatrix3MultiplyVector3(matrix3, normal);
    normal = GLKVector3Normalize(normal);
    //get dot product with light direction
    GLKVector3 light = GLKVector3Normalize(GLKVector3Make(LIGHT_DIRECTION));
    float dotProduct = GLKVector3DotProduct(light, normal);
    //set lighting layer opacity
    CGFloat shadow = 1 + dotProduct - AMBIENT_LIGHT;
    UIColor *color = [UIColor colorWithWhite:0 alpha:shadow];
    layer.backgroundColor = color.CGColor;
}

-(void)addFace:(NSInteger)index withTransform:(CATransform3D)transForm
{
    UILabel *lbl = lableArray[index];
    [collView addSubview:lbl];
    lbl.center = CGPointMake(LBL_H/2, LBL_H/2);
    lbl.layer.transform = transForm;
    
    [self applyLightingToFace:lbl.layer];
}

-(UILabel *)createlableWithTag:(NSInteger)tag
{
    UILabel *ret = [UILabel new];
    
    ret.tag = tag;
    ret.backgroundColor = [UIColor whiteColor];
    [ret setTextAlignment:NSTextAlignmentCenter];
    [ret setFont:[UIFont systemFontOfSize:36]];
    ret.frame = CGRectMake(0, 0, LBL_H, LBL_H);
    [ret setText:[NSString stringWithFormat:@"%ld",tag]];
    [ret setTextColor:[Utils randomColor]];
    
    if (tag == 3) {
        [ret setUserInteractionEnabled:YES];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [ret addGestureRecognizer:tap];
    }
    
    return ret;
}

-(void)tap:(UITapGestureRecognizer *)tap
{
    CATransform3D per = CATransform3DIdentity;
    per.m34 = -1.0/500.0;
    per = CATransform3DRotate(per, -M_PI_4, 0, 1, 0);
    per = CATransform3DRotate(per, -M_PI_4, 0, 0, 1);
    collView.layer.sublayerTransform = per;
}

@end
