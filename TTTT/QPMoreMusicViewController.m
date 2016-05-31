//
//  MoreMusicViewController.m
//  QupaiSDKDevApp
//
//  Created by yly on 15/7/1.
//  Copyright (c) 2015年 lyle. All rights reserved.
//

#import "QPMoreMusicViewController.h"
#import <ALBBQuPaiPlugin/ALBBQuPaiPluginPluginServiceProtocol.h>
#import <TAESDK/TaeSDK.h>

@interface QPMoreMusicViewController ()

@end

@implementation QPMoreMusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)closeButtonClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        id<ALBBQuPaiPluginPluginServiceProtocol> sdk = [[TaeSDK sharedInstance] getService:@protocol(ALBBQuPaiPluginPluginServiceProtocol)];
        [sdk updateMoreMusic];
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
