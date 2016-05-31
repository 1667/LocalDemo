//
//  Test3DView.m
//  TTTT
//
//  Created by 无线盈 on 15/9/29.
//  Copyright © 2015年 wuxianying. All rights reserved.
//

#import "Test3DView.h"
#import "Utils.h"

#define DEFULT_M34          (- 1.0 / 500.0)

@implementation Test3DView
{
    UIButton        *btn;
    UIButton        *alphaBtn;
    UIButton        *sharBtn;
    UIImageView     *imageView;
    UIImageView     *imageView2;
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
        make.width.equalTo(self.width).multipliedBy(0.5);
        make.height.equalTo(imageView.width);
        make.centerX.equalTo(self.centerX);
        make.bottom.equalTo(self.centerY).offset(-10);
        
    }];
    
    imageView2 = [UIImageView new];
    [imageView2 setBackgroundColor:[Utils randomColor]];
    [imageView2 setImage:[UIImage imageNamed:@"tu8601_7.jpg"]];
    [self addSubview:imageView2];
    [imageView2 makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(imageView.width);
        make.height.equalTo(imageView.width);
        make.centerX.equalTo(self.centerX);
        make.top.equalTo(self.centerY).offset(10);
        
    }];
    
//    CATransform3D transForm = CATransform3DIdentity;
//    transForm.m34 = -1.0/500.0;
//    transForm = CATransform3DRotate(transForm, DEGREES_TO_RADIANS(45), 0, 1, 0);
//    imageView.layer.transform = transForm;
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = DEFULT_M34;
    self.layer.sublayerTransform = perspective; //拥有相当的消亡点，类似于中心点，设置父视图的这是属性，所有的子视图都会受影响
    
}

-(void)BigAnt
{
    
    CATransform3D transForm = CATransform3DMakeRotation(DEGREES_TO_RADIANS(-45), 0, 0, 1);//x是上下转动 y是左右转动 z类似于旋转
    [UIView animateWithDuration:1 animations:^{
        imageView.layer.transform = transForm;
    }];
    
}

-(void)stop:(id)sender
{
    CATransform3D transForm = CATransform3DMakeRotation(DEGREES_TO_RADIANS(180), 1, 0, 0);
    //imageView2.layer.doubleSided = NO;//是否对背面进行绘制
    [UIView animateWithDuration:1 animations:^{
        imageView2.layer.transform = transForm;
    }];
    
}

-(void)shar:(id)sender
{
    
}

@end
