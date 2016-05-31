//
// Created by huamulou on 15/5/31.
// Copyright (c) 2015 alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ALBBMediaService/ALBBMediaService.h>

@class TFEUploadNotification;
@protocol ALBBMediaServiceProtocol;

#define DEMO_ALBBM [ALBBMedia sharedInstance]
#define DEMO_ENGINE [DEMO_ALBBM taeFileEngine]
#define DEMO_UUID [DEMO_ALBBM uniqueString]
#define DEMO_NAMESPACE @"1667"                  //请及时替换成你自己的安全图片和namespace，测试地址会定时清理文件的
#define DEMO_DIR @"/test/视频/20151109"
#define DEMO_TYPE_FILE 1
#define DEMO_TYPE_DATA 2
#define DEMO_TYPE_ASSET 3


#define demoUpload(_type, _param, _notification) \
[DEMO_ALBBM upload:_type param:_param notification:_notification];


@interface ALBBMedia : NSObject

+ (instancetype)sharedInstance;

/**
* taefileengine的实例
*/
@property(nonatomic, strong) id <ALBBMediaServiceProtocol> taeFileEngine;

- (NSString *)upload:(int)type param:(id)param notification:(TFEUploadNotification *)notification;

/**
* @brief 使用本地文件地址上传
*/
- (NSString *)uploadByFile:(NSString *)filePath notification:(TFEUploadNotification *)notification;

/**
* @brief 使用data方式上传
*/
- (NSString *)uploadByData:(NSData *)data notification:(TFEUploadNotification *)notification;


/**
* @brief 使用图库链接上传
*/
- (NSString *)uploadByAsset:(NSURL *)assetUrl notification:(TFEUploadNotification *)notification;

- (NSString *)uniqueString;

@end