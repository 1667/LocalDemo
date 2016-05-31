//
//  AlphaView.m
//  TTTT
//
//  Created by 无线盈 on 15/9/29.
//  Copyright © 2015年 wuxianying. All rights reserved.
//

#import "AlphaView.h"
#import "Utils.h"

@implementation AlphaView
{
    UIButton        *btn;
    UIButton        *alphaBtn;
    UIButton        *sharBtn;
    UIImageView     *imageView;
    CGFloat         nextR;
    BOOL            start;
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
    [self setBackgroundColor:[UIColor lightGrayColor]];
    nextR = M_PI *2;
    btn = [UIButton new];
    btn.backgroundColor = [UIColor whiteColor];
    [btn setTitle:@"加速" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(BigAnt) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    [btn makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.bottom.equalTo(self);
        make.height.equalTo(self.height).multipliedBy(0.1);
        make.width.equalTo(self.width).dividedBy(3);
    }];
    
    alphaBtn = [UIButton new];
    alphaBtn.backgroundColor = [UIColor whiteColor];
    alphaBtn.alpha = 0.75;
    [alphaBtn setTitle:@"停止" forState:UIControlStateNormal];
    [alphaBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [alphaBtn addTarget:self action:@selector(stop:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:alphaBtn];
    [alphaBtn makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.height.equalTo(self.height).multipliedBy(0.1);
        make.centerX.equalTo(self.centerX);
        make.width.equalTo(self.width).dividedBy(3);
    }];
    
    sharBtn = [UIButton new];
    sharBtn.backgroundColor = [UIColor whiteColor];
    sharBtn.alpha = 0.5;
    [sharBtn setTitle:@"倾斜" forState:UIControlStateNormal];
    [sharBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [sharBtn addTarget:self action:@selector(shar:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:sharBtn];
    [sharBtn makeConstraints:^(MASConstraintMaker *make) {
        make.right.and.bottom.equalTo(self);
        make.height.equalTo(self.height).multipliedBy(0.1);
        make.width.equalTo(self.width).dividedBy(3);
    }];
    
    imageView = [UIImageView new];
    [imageView setBackgroundColor:[Utils randomColor]];
    [imageView setImage:[UIImage imageNamed:@"tu8601_7.jpg"]];
    [self addSubview:imageView];
    [imageView makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.width).multipliedBy(0.7);
        make.height.equalTo(imageView.width);
        make.centerX.equalTo(self.centerX);
        make.centerY.equalTo(self.centerY);
        
    }];
    CGAffineTransform transForm = CGAffineTransformIdentity;
    //transForm = CGAffineTransformScale(transForm, 0.5, 0.5);
    transForm = CGAffineTransformRotate(transForm, M_PI_4);
    //transForm = CGAffineTransformTranslate(transForm, 200, 0);
    
    imageView.layer.affineTransform = transForm;//layer 的affineTransform 和 view的transform一样 但是layer的transform是transform3D的类型
    
    start = YES;
    
}

-(void)BigAnt
{
    if (start == NO) {
        start = YES;
    }
    [UIView animateWithDuration:1 animations:^{
        imageView.transform = CGAffineTransformMakeRotation(nextR);
    } completion:^(BOOL finished) {
        if (nextR == M_PI) {
            nextR = 0;
        }
        else
        {
            nextR = M_PI;
        }
        if (start) {
            
            [self BigAnt];
        }
        else
        {
            
        }
    }];;
}

-(void)stop:(id)sender
{
    start = NO;
}

CGAffineTransform CGAffineTransformMakeShear(CGFloat x, CGFloat y)
{
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform.c = -x;
    transform.b = y;
    return transform;
}

-(void)shar:(id)sender
{
    imageView.layer.affineTransform = CGAffineTransformMakeShear(1, 0);
    
}

@end
