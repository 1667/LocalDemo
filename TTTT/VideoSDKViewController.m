//
//  VideoSDKViewController.m
//  TTTT
//
//  Created by 无线盈 on 15/10/8.
//  Copyright © 2015年 wuxianying. All rights reserved.
//

#import "VideoSDKViewController.h"
#import "Utils.h"

#import <ALBBQuPaiPlugin/ALBBQuPaiPluginPluginServiceProtocol.h>
#import <ALBBQuPaiPlugin/QPEffectMusic.h>
#import <TAESDK/TaeSDK.h>
#import "ALBBMedia.h"
#import "QPMoreMusicViewController.h"

@interface VideoSDKViewController ()

@end

@implementation VideoSDKViewController
{
    id<ALBBQuPaiPluginPluginServiceProtocol> sdk;
    BOOL                                    _down;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *tmpBtn = [UIButton new];
    tmpBtn.backgroundColor = [Utils randomColor];
    [self.view addSubview:tmpBtn];
    [tmpBtn addTarget:self action:@selector(testButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [tmpBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.bottom.equalTo(self.view);
        make.height.equalTo(80);
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)testButtonClick:(id)sender {
    
    sdk = [[TaeSDK sharedInstance] getService:@protocol(ALBBQuPaiPluginPluginServiceProtocol)];
    [sdk setDelegte:(id<QupaiSDKDelegate>)self];
    
    
    //    UIViewController *recordController = [sdk createRecordViewControllerWithMaxDuration:[_durationTextField.text integerValue]
    //                                                                                              bitRate:[_bitRateTextField.text integerValue]
    //                                                                          thumbnailCompressionQuality:[_qualityThumbnail.text floatValue]
    //                                                                                       watermarkImage:_enableWaterMask.on ? [UIImage imageNamed:@"watermask"] : nil watermarkPosition:QupaiSDKWatermarkPositionTopRight
    //                                                                                      enableMoreMusic:_enableMoreMusic.on
    //                                                                                         enableImport:_enableImportSwitch.on];
    
    
    
    UIViewController *recordController = [sdk createRecordViewControllerWithMaxDuration:8
                                                                                bitRate:2000000
                                                            thumbnailCompressionQuality:0.3
                                                                         watermarkImage: nil
                                                                      watermarkPosition:QupaiSDKWatermarkPositionTopRight
                                                                        enableMoreMusic:NO
                                                                           enableImport:NO
                                                                      enableVideoEffect:NO];
    
    
    
    //    UIViewController *recordController = [sdk createRecordViewControllerWithMaxDuration:[_durationTextField.text integerValue]
    //                                                                                bitRate:[_bitRateTextField.text integerValue]
    //                                                            thumbnailCompressionQuality:[_qualityThumbnail.text floatValue]
    //                                                                         watermarkImage:_enableWaterMask.on ? [UIImage imageNamed:@"watermask"] : nil watermarkPosition:QupaiSDKWatermarkPositionTopRight
    //                                                                              tintColor:[UIColor colorWithRed:_colorR.value/255.0 green:_colorG.value/255.0 blue:_colorB.value/255.0 alpha:1]
    //                                                                        enableMoreMusic:_enableMoreMusic.on
    //                                                                           enableImport:_enableImportSwitch.on
    //                                                                      enableVideoEffect:_enableVideoEffect.on];
    
    
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:recordController];
    navigation.navigationBarHidden = YES;
    [self presentViewController:navigation animated:YES completion:nil];
}

- (void)qupaiSDK:(id<ALBBQuPaiPluginPluginServiceProtocol>)sdk compeleteVideoPath:(NSString *)videoPath thumbnailPath:(NSString *)thumbnailPath
{
    NSLog(@"Qupai SDK compelete %@",videoPath);
    __block unsigned long p = 0;
    [self dismissViewControllerAnimated:YES completion:nil];
    if (videoPath) {
        UISaveVideoAtPathToSavedPhotosAlbum(videoPath, nil, nil, nil);
        TFEUploadNotification *notification = [TFEUploadNotification
                                               notificationWithProgress:^(TFEUploadSession *session, NSUInteger progress) {
                                                   NSLog(@"%lu", (unsigned long) progress);
                                                   p = progress;
                                                   
                                               }
                                               success:^(TFEUploadSession *session, NSString *url) {
                                                   
                                                   NSLog(@"%@", session);
                                                   p = 100;
                                                   [Utils setLocalCache:@{@"url":url} Flage:FILE_FLAGES_URL(@"1") ];
                                                  
                                               }
                                               failed:^(TFEUploadSession *session, NSError *error) {
                                                   
                                                   
                                               }];
        
        demoUpload(DEMO_TYPE_FILE, videoPath, notification);
        
        MBProgressHUD *proHud = [Utils createProHUDWithView:self.view Text:@"正在上传"];
        [proHud showAnimated:YES whileExecutingBlock:^{
            CGFloat progress = ((CGFloat)p)/100;
            while (progress < 1.0f) {
                progress = ((CGFloat)p)/100;
                proHud.progress = progress;
                usleep(100000);
            }
        } completionBlock:^{
            [proHud removeFromSuperview];
        }];
        
    }
    if (thumbnailPath) {
        UIImageWriteToSavedPhotosAlbum([UIImage imageWithContentsOfFile:thumbnailPath], nil, nil, nil);
    }
    

    
}

- (NSArray *)qupaiSDKMusics:(id<ALBBQuPaiPluginPluginServiceProtocol>)sdk
{
    NSString *baseDir = [[NSBundle mainBundle] bundlePath];
    NSString *configPath = [[NSBundle mainBundle] pathForResource:_down ? @"music2" : @"music1" ofType:@"json"];
    NSData *configData = [NSData dataWithContentsOfFile:configPath];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:configData options:NSJSONReadingAllowFragments error:nil];
    NSArray *items = dic[@"music"];
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *item in items) {
        NSString *path = [baseDir stringByAppendingPathComponent:item[@"resourceUrl"]];
        QPEffectMusic *effect = [[QPEffectMusic alloc] init];
        effect.name = item[@"name"];
        effect.eid = [item[@"id"] intValue];
        effect.musicName = [path stringByAppendingPathComponent:@"audio.mp3"];
        effect.icon = [path stringByAppendingPathComponent:@"icon.png"];
        [array addObject:effect];
    }
    return array;
}

- (void)qupaiSDKShowMoreMusicView:(id<ALBBQuPaiPluginPluginServiceProtocol>)sdk viewController:(UIViewController *)viewController
{
    QPMoreMusicViewController *music = [[QPMoreMusicViewController alloc] initWithNibName:@"QPMoreMusicViewController" bundle:nil];
    [viewController presentViewController:music animated:YES completion:nil];
    _down = YES;
}

@end
