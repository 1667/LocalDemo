//
//  DrawLineViewController.m
//  TTTT
//
//  Created by 无线盈 on 15/9/22.
//  Copyright © 2015年 wuxianying. All rights reserved.
//

#import "DrawLineViewController.h"
#import "DrawLineView.h"
#import "Utils.h"

@interface DrawLineViewController ()

@end

@implementation DrawLineViewController
{
    DrawLineView *dV;
    NSInteger   current;
    UIButton *tmpButton;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    dV = [[DrawLineView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:dV];
    
    //[self.navigationController setNavigationBarHidden:YES animated:YES];
    current = 0;
    tmpButton = [UIButton new];
    tmpButton.layer.masksToBounds = YES;
    tmpButton.layer.cornerRadius = 5.0;
    [tmpButton setBackgroundColor:[Utils randomColor]];
    [self.view addSubview:tmpButton];
    [tmpButton setTitle:@"橡皮" forState:UIControlStateNormal];
    [tmpButton addTarget:self action:@selector(drawWithC:) forControlEvents:UIControlEventTouchUpInside];
    CGFloat topPadding = self.view.frame.size.height*0.9;
    
    [tmpButton makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(topPadding, 10, 10, 10));
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)drawWithC:(id)sender
{
    if (current == 0) {
        [tmpButton setTitle:@"继续" forState:UIControlStateNormal];
        [dV setLineCorlor:1];
        current = 1;
    }
    else
    {
        [tmpButton setTitle:@"橡皮" forState:UIControlStateNormal];
        [dV setLineCorlor:0];
        current = 0;
    }
}

@end
