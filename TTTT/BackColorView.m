//
//  BackColorView.m
//  TTTT
//
//  Created by 无线盈 on 15/10/12.
//  Copyright © 2015年 wuxianying. All rights reserved.
//

#import "BackColorView.h"

@implementation BackColorView
{
    UIView              *colorView;
    CALayer             *layer;
    NSArray             *imageArray;
    NSInteger           imageIndex;
}
-(void)initView
{
    UIButton *btn = [UIButton new];
    btn.backgroundColor = [Utils randomColor];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(self);
        make.height.equalTo(80);
        
    }];
    
    colorView = [[UIView alloc] initWithFrame:CGRectMake(10, 80, (SCREEN_W-20), 200)];
    colorView.backgroundColor = [Utils randomColor];
    [self addSubview:colorView];
    
   
    
    layer = [CALayer layer];
    layer.frame = CGRectMake(110, 20, (SCREEN_W-20)/2, 100);
    layer.backgroundColor = [Utils randomColor].CGColor;
    
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    layer.actions = @{@"contents":transition};
    layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"tu8601_10.jpg"].CGImage);
    
    [colorView.layer addSublayer:layer];
    colorView.layer.masksToBounds = YES;
    imageArray = [[NSArray alloc] initWithObjects:@"tu8601_10.jpg",@"tu8601_5.jpg", nil];
    
}

-(void)btnClicked:(UIButton *)sender
{
    
    NSLog(@"%@",[colorView actionForLayer:colorView.layer forKey:@"backgroundColor"]);
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    //test layer action when inside of animation block
    NSLog(@"Inside: %@", [colorView actionForLayer:colorView.layer forKey:@"backgroundColor"]);
    colorView.backgroundColor = [Utils randomColor];//view的layer要用这种方式（显示动画）才能有效果
    [UIView commitAnimations];
    
    [CATransaction begin];
    [CATransaction setAnimationDuration:1.0f];
    
//    [CATransaction setCompletionBlock:^{
//        CGAffineTransform tranform = layer.affineTransform;
//        tranform = CGAffineTransformRotate(tranform, M_PI_2);
//        layer.affineTransform = tranform;
//        
//    }];
    sender.backgroundColor = [Utils randomColor];
    layer.contents = (__bridge id _Nullable)([UIImage imageNamed:imageArray[imageIndex%2]].CGImage);
    imageIndex ++;
    
    [CATransaction commit];
    
}

@end
