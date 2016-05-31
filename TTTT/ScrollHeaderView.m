//
//  ScrollHeaderView.m
//  TTTT
//
//  Created by 无线盈 on 15/9/23.
//  Copyright © 2015年 wuxianying. All rights reserved.
//

#import "ScrollHeaderView.h"
#import "ShapelCircleView.h"

@implementation ScrollHeaderView
{
    ShapelCircleView *_circleView;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        _circleView = [[ShapelCircleView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        _circleView.center = CGPointMake(self.frame.size.width/2, 30);
        [self addSubview:_circleView];
        
    }
    return self;
}

@end
