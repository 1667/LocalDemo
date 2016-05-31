//
//  CRPView.m
//  TTTT
//
//  Created by wxy on 16/2/24.
//  Copyright © 2016年 wuxianying. All rights reserved.
//

#import "CRPView.h"
#import "SmallDeltaView.h"

@implementation CRPView
{
    UIButton *btn1;
    UIButton *btn2;
    UIButton *btn3;
    UIView *backW;
    UIButton *clickedBtn;
    SmallDeltaView *sV;

}

-(void)initView
{
    btn1 = [self getBtnWithTitle:@"btn1"];
    [self addSubview:btn1];
    
    btn2 = [self getBtnWithTitle:@"btn2"];
    [self addSubview:btn2];
    
    btn3 = [self getBtnWithTitle:@"btn3"];
    [self addSubview:btn3];
    
    
    [btn1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.size.equalTo(CGSizeMake(SCREEN_W/3, 40));
        make.left.equalTo(self);
    }];

    [btn2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.size.equalTo(CGSizeMake(SCREEN_W/3, 40));
        make.left.equalTo(btn1.right);
    }];
    
    [btn3 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.size.equalTo(CGSizeMake(SCREEN_W/3, 40));
        make.left.equalTo(btn2.right);
        make.right.equalTo(self);
    }];
    
    
    
    
    backW = [UIView new];
    backW.backgroundColor = [UIColor groupTableViewBackgroundColor];
    backW.layer.cornerRadius = 5.0;
    backW.layer.shadowOpacity = 0.3;//透明度
    backW.layer.shadowRadius  = 1.0;//半径
//    backW.layer.shadowOffset  = CGSizeMake(1.0, 1.0);//偏移
    backW.layer.shadowColor   = [[UIColor blackColor] CGColor];
    [self addSubview:backW];
    
    
    sV = [SmallDeltaView new];
    sV.layer.shadowOpacity = 0.8;//透明度
    //sV.layer.shadowRadius  = 8.0;//半径
    sV.layer.shadowOffset  = CGSizeMake(0.0, 0.0);//偏移为零时要设置半径
    sV.layer.shadowColor   = [[UIColor whiteColor] CGColor];
    sV.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:sV];
    [sV makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn1.bottom).offset(5);
        make.centerX.equalTo(btn1);
        make.size.equalTo(CGSizeMake(20, 15));
        
    }];
    
    [backW makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(sV.bottom);
        make.size.equalTo(CGSizeMake(SCREEN_W*0.9, SCREEN_H*0.6));
        make.centerX.equalTo(self);
        
    }];
    
    
}

-(UIButton *)getBtnWithTitle:(NSString *)title
{
    UIButton *btn = [UIButton new];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.backgroundColor = [Utils randomColor];
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

-(void)updateConstraints
{
    if (clickedBtn != nil) {

        [sV remakeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(clickedBtn.bottom).offset(5);
            make.centerX.equalTo(clickedBtn);
            make.size.equalTo(CGSizeMake(20, 15));
            
        }];
    }
    [super updateConstraints];
}

-(void)btnClicked:(UIButton *)btn
{
    clickedBtn = btn;
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];

    [UIView animateWithDuration:0.3 animations:^{
        [self layoutIfNeeded];
    }];
    
}

@end













