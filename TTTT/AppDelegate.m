//
//  AppDelegate.m
//  TTTT
//
//  Created by innke on 15/9/2.
//  Copyright (c) 2015年 wuxianying. All rights reserved.
//

#import "AppDelegate.h"
#import "FirstViewController.h"

#import "Utils.h"
#import <TAESDK/TaeSDK.h>
#import "SecondViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
{
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    _popWin = [[popWindow alloc] initWithFrame:CGRectMake(0, 100, 40, 40)];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    FirstViewController *fC = [FirstViewController new];
    fC.popWin = _popWin;
    [self.window setRootViewController:[[UINavigationController alloc] initWithRootViewController:fC]];
    [self.window makeKeyAndVisible];
    
    [[TaeSDK sharedInstance] asyncInit:^{
        
    } failedCallback:^(NSError *error) {
        NSLog(@"TaeSDK init failed!!!");
    }];

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if (![fileManager fileExistsAtPath:FILE_CACHE_DIC])
        {
            [fileManager createDirectoryAtPath:FILE_CACHE_PATH_DIC withIntermediateDirectories:YES attributes:nil error:nil];
        }
    });
    
    [self getDeviceToken];
    
    return YES;
}

-(void)getDeviceToken
{
    if([[[UIDevice currentDevice] systemVersion] floatValue] >=8.0)
        
    {
        
        [[UIApplication sharedApplication]registerUserNotificationSettings:[UIUserNotificationSettings
                                                                            
                                                                            settingsForTypes:(UIUserNotificationTypeSound|UIUserNotificationTypeAlert|UIUserNotificationTypeBadge)
                                                                            
                                                                            categories:nil]];
        
        [[UIApplication sharedApplication]registerForRemoteNotifications];
        
    }else{
        
        //这里还是原来的代码
        
        //注册启用push
        
        [[UIApplication sharedApplication]registerForRemoteNotificationTypes:
         
         (UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeBadge)];
        
    }
}

-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
    NSLog(@"%@",app);
    NSString *handleUrl = [url absoluteString];
    if ([handleUrl isEqualToString:@"tttt://"]) {
        NSLog(@"%@",handleUrl);
        UINavigationController *vc = (UINavigationController *)_window.rootViewController;
        if (vc == nil) {
            _popWin = [[popWindow alloc] initWithFrame:CGRectMake(0, 100, 40, 40)];
            
            self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
            FirstViewController *fC = [FirstViewController new];
            fC.popWin = _popWin;
            [self.window setRootViewController:[[UINavigationController alloc] initWithRootViewController:fC]];
            [self.window makeKeyAndVisible];
            
            [[TaeSDK sharedInstance] asyncInit:^{
                
            } failedCallback:^(NSError *error) {
                NSLog(@"TaeSDK init failed!!!");
            }];
            
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                
                NSFileManager *fileManager = [NSFileManager defaultManager];
                if (![fileManager fileExistsAtPath:FILE_CACHE_DIC])
                {
                    [fileManager createDirectoryAtPath:FILE_CACHE_PATH_DIC withIntermediateDirectories:YES attributes:nil error:nil];
                }
            });
            UINavigationController *nv = (UINavigationController *)self.window.rootViewController;
            
            [nv pushViewController:[SecondViewController new] animated:YES];
            return YES;
    }
        else
        {
            UINavigationController *nv = (UINavigationController *)self.window.rootViewController;
            
            [nv pushViewController:[SecondViewController new] animated:YES];
        }
        
    }
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    
    NSString *str = [[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""]
                      stringByReplacingOccurrencesOfString: @">" withString: @""]
                     stringByReplacingOccurrencesOfString: @" " withString: @""];
    NSLog(@"%@",str);
    
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    //如果注册不成功，打印错误信息，可以在网上找到对应的解决方案
    //如果注册成功，可以删掉这个方法
    
    NSLog(@"application:didFailToRegisterForRemoteNotificationsWithError: %@", error);
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    
    
    if (application.applicationState == UIApplicationStateActive) {
        NSLog(@"active");
        //程序当前正处于前台
    }
    else if(application.applicationState == UIApplicationStateInactive)
    {
        NSLog(@"inactive");
        //程序处于后台
        
    }
    

    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//- (BOOL)shouldAutorotate
//{
//    return YES;
//}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskAll;
}

@end
