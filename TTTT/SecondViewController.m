//
//  SecondViewController.m
//  TTTT
//
//  Created by innke on 15/9/2.
//  Copyright (c) 2015年 wuxianying. All rights reserved.
//

#import "SecondViewController.h"
#import "ScrollTitltView.h"

@interface SecondViewController ()

@end

@implementation SecondViewController
{
    NSString *_str;
    ScrollTitltView *scrollTitle;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"seconde";
    UIButton *back = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
    [back setTitle:@"返回" forState:UIControlStateNormal];
    [back setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:back]];
    
    NSMutableArray *vA = [NSMutableArray new];
    for (int i= 0; i < 2; i++) {
        UIView *v = [UIView new];
        switch (i) {
            case 0:
                v.backgroundColor = [UIColor redColor];
                break;
                
            default:
                v.backgroundColor = [UIColor blueColor];
                break;
        }
        [vA addObject:v];
    }
    
    scrollTitle = [[ScrollTitltView alloc] initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, self.view.frame.size.height-80) titleText:@[@"TTT1",@"TTT2"] viewArray:vA];
    [self.view addSubview:scrollTitle];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setStr:(NSString *)str
{
    _str = str;
}

-(void)back:(id)sender
{
    if ([_delegate respondsToSelector:@selector(passValue:)]) {
        [_delegate passValue:@"From Second"];//传到第一个界面
    }
    [self.navigationController popViewControllerAnimated:YES];//界面跳转
}

@end
