//  Constants.h
//  Created by huamulou on 14-11-17.
//  Copyright (c) 2014年 alibaba. All rights reserved.
//

#import <UIKit/UIKit.h>


#ifndef TFEDEBUG
#import <ALBBMediaService/ALBBMediaService.h>
#else
#import "ALBBMediaService.h"

#endif

#define TFE_DEMO_SHARE_INSTANCE \
+(instancetype)sharedInstance \
{\
    static dispatch_once_t once;\
    static id instance;\
    dispatch_once(&once, ^{instance = [self new];});\
    return instance;\
}
