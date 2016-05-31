//
//  SecondViewController.h
//  TTTT
//
//  Created by innke on 15/9/2.
//  Copyright (c) 2015年 wuxianying. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol passValueDelegate <NSObject>//声明协议

-(void)passValue:(NSString *)str;

@end

@interface SecondViewController : UIViewController

-(void)setStr:(NSString *)str;

@property (nonatomic,strong) id<passValueDelegate> delegate;

@end
