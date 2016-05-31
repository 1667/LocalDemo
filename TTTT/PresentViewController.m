//
//  PresentViewController.m
//  TTTT
//
//  Created by 无线盈 on 15/10/16.
//  Copyright © 2015年 wuxianying. All rights reserved.
//

#import "PresentViewController.h"
#import "Utils.h"

@interface PresentViewController ()

@end

@implementation PresentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[Utils randomColor]];
    UIButton *dismiss = [UIButton new];
    dismiss.backgroundColor = [Utils randomColor];
    [self.view addSubview:dismiss];
    [dismiss addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
    [dismiss makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.centerX);
        make.centerY.equalTo(self.view.centerY);
        make.size.equalTo(CGSizeMake(60, 60));
    }];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dismiss:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
