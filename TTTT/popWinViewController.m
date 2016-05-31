//
//  popWinViewController.m
//  TTTT
//
//  Created by 无线盈 on 15/9/24.
//  Copyright © 2015年 wuxianying. All rights reserved.
//

#import "popWinViewController.h"
#import "Utils.h"

@interface popWinViewController ()

@property (nonatomic,strong) UIButton *tmpBtn;

@end

@implementation popWinViewController
{
    BOOL bBig;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor redColor]];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    _tmpBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0,40, 40)];
    [_tmpBtn setBackgroundColor:[Utils randomColor]];
    [self.view addSubview:_tmpBtn];
    [_tmpBtn addTarget:self action:@selector(refreshFrame:) forControlEvents:UIControlEventTouchUpInside];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)refreshFrame:(id)sender
{
    if (bBig) {
        bBig = NO;
        
        CGRect frame = _superWind.frame;
        
        NSLog(@"%@",[NSValue valueWithCGRect:frame]);
        
        [UIView animateWithDuration:0.3 animations:^{
            
            
            _superWind.frame = CGRectMake(frame.origin.x, frame.origin.y, 200, 40);
            _tmpBtn.frame = _superWind.bounds;
        }];
    }
    else
    {
        bBig = YES;
        CGRect frame = _superWind.frame;
        
        NSLog(@"%@",[NSValue valueWithCGRect:frame]);
        
        [UIView animateWithDuration:0.3 animations:^{
            
            _superWind.frame = CGRectMake(frame.origin.x, frame.origin.y, 40, 40);
            _tmpBtn.frame = _superWind.bounds;
        }];
    }
    
}

@end
