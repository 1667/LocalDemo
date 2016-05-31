//
//  KeyChainViewController.m
//  TTTT
//
//  Created by 无线盈 on 15/10/19.
//  Copyright © 2015年 wuxianying. All rights reserved.
//

#import "KeyChainViewController.h"
#import "KeychainItemWrapper.h"

@interface KeyChainViewController ()

@end

@implementation KeyChainViewController
{
    UITextField             *_tfPassword;
    KeychainItemWrapper     *wrapper;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initView
{
    
    wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"password" accessGroup:nil];
    _tfPassword = [UITextField new];
    [_tfPassword setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_tfPassword];
    
    
    [_tfPassword makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(NAV_STATUS_H(self));
        make.height.equalTo(60);
    }];
    
    UIButton *tmpBtn = [UIButton new];
    [tmpBtn setBackgroundColor:[Utils randomColor]];
    [self.view addSubview:tmpBtn];
    [tmpBtn addTarget:self action:@selector(setPassword) forControlEvents:UIControlEventTouchUpInside];
    [tmpBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(self.view);
        make.height.equalTo(60);
    }];
    
    [_tfPassword setText:[self getPassWord]];
    
}

-(NSString *)getPassWord
{
    return [wrapper objectForKey:(id)kSecValueData];
}

-(void)setPassword
{
    
    if ([_tfPassword.text length] != 0) {
        [wrapper setObject:[_tfPassword text] forKey:(id)kSecValueData];
        [self showAlterViewWithText:@"修改成功"];
    }
    else
    {
        [self showAlterViewWithText:@"输入密码"];
    }
    
}

@end
