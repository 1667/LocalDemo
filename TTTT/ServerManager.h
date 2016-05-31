//
//  ServerManager.h
//  PropertyManager
//
//  Created by 无线盈 on 15/8/10.
//  Copyright (c) 2015年 wuxianying. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define HUD_LOANDING                @"正在加载"

#ifdef DEBUG
#define API_BASE_URL                @"http://192.168.0.4:8080"

#else
#define API_BASE_URL                @"http://123.56.96.68:8080/sendCode"
#endif

#define API_ORDER_CREATE            [NSString stringWithFormat:@"%@%@",API_BASE_URL,@"/Json/OrderCreate.aspx"]
#define API_GET_CASHCOUPONS            [NSString stringWithFormat:@"%@%@",API_BASE_URL,@"/Json/UserCashCouponsGet.aspx"]

#define API_SEND_SMS            [NSString stringWithFormat:@"%@%@",API_BASE_URL,@"/sendSMS/"]


#define CONTENT_TYPE                    @"Content-Type"
#define APP_JSON                        @"application/json"
#define APP_ZIP                         @"application/zip"
#define PLATFORM_NAME                   @"platformName"
#define CLIENT_VERSION                  @"clientVersion"
#define CHANNEL_ID                      @"channelId"
#define DATE                            @"date"


typedef NS_ENUM(NSInteger,AF_CallType) {
    GET,
    POST
};

typedef void(^SuccessBlock)(NSDictionary *dictionary);
typedef void(^FaildBlock)(NSString *errDescription);

typedef void (^ProgressBlock)(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite);

@interface ServerManager : NSObject

+(ServerManager*)instance;

-(void)callAPI:(NSString *)api
      CallType:(AF_CallType)callType
         Param:(NSDictionary *)param
      bShowHUD:(BOOL)bShowHUD
        inView:(UIView *)inView
          text:(NSString *)text
withSuccessBlock:(SuccessBlock)successBlock
     fileBlock:(FaildBlock)fileBlock;

-(void)callAPIWithNewB:(NSString *)api CallType:(AF_CallType)callType Param:(NSDictionary *)param bShowHUD:(BOOL)bShowHUD inView:(UIView *)inView text:(NSString *)text withSuccessBlock:(SuccessBlock)successBlock fileBlock:(FaildBlock)fileBlock;

-(void)FleaNewEX:(NSString *)userID
        Pictures:(NSString *)path
withSuccessBlock:(SuccessBlock)successBlock
       fileBlock:(FaildBlock)fileBlock
   ProgressBlock:(ProgressBlock)pBlock;

-(BOOL)setLocalCacheWithObjct:(NSObject *)obj Flage:(NSString *)flage;
-(BOOL)setLocalCache:(NSDictionary *)dic Flage:(NSString *)flage;
-(NSDictionary *)getLocalCache:(NSString *)flage;

@end
