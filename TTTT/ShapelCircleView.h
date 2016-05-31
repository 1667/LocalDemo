//
//  ShapelCircleView.h
//  TTTT
//
//  Created by 无线盈 on 15/9/23.
//  Copyright © 2015年 wuxianying. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShapelCircleView : UIView

@property (nonatomic,strong) CAShapeLayer       *sLayer;
@property (nonatomic,assign) CGFloat            lineWidth;
@property (nonatomic,assign) CGFloat            strokeEnd;
@property (nonatomic,assign) BOOL               bRefreashing;

@end
