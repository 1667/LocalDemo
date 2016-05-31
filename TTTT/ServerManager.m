//
//  ServerManager.m
//  PropertyManager
//
//  Created by 无线盈 on 15/8/10.
//  Copyright (c) 2015年 wuxianying. All rights reserved.
//

#import "ServerManager.h"
#import <AFNetworking.h>
#import "Utils.h"

@implementation ServerManager


+(ServerManager*)instance
{
    static ServerManager  *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ServerManager alloc] init];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if (![fileManager fileExistsAtPath:FILE_CACHE_DIC])
        {
            [fileManager createDirectoryAtPath:FILE_CACHE_PATH_DIC withIntermediateDirectories:YES attributes:nil error:nil];
        }
    });
    
    return manager;
}

-(NSString *)codeTOString:(int)code
{
    switch (code) {
        case 200:
            return @"成功";
        case 201:
            return @"空数据";
        case 401:
            return @"非法用户";
        case 402:
            return @"会话超时重新登录";
        case 403:
            return @"用户名密码错误";
        case 404:
            return @"路径有误";
        case 405:
            return @"用户名已存在";
        case 406:
            return @"参数错误";
        case 407:
            return @"收信人无效";
        case 408:
            return @"用户未拥有该小区住宅";
        case 409:
            return @"欢迎使用掌上物业";
        case 300:
            return @"数据验证错误";
        case 500:
            return @"系统错误";
        default:
            break;
    }
    return @"";
}

-(AFHTTPRequestOperationManager *)getManagerWithHeader
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:APP_JSON forHTTPHeaderField:CONTENT_TYPE];
    [manager.requestSerializer setValue:@"IOS" forHTTPHeaderField:PLATFORM_NAME];
    [manager.requestSerializer setValue:@"2.0" forHTTPHeaderField:CLIENT_VERSION];
    [manager.requestSerializer setValue:@"1" forHTTPHeaderField:CHANNEL_ID];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    [manager.requestSerializer setValue:locationString forHTTPHeaderField:DATE];
    return manager;
}
-(AFHTTPRequestOperationManager *)getManagerWithZipHeader
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:APP_ZIP forHTTPHeaderField:CONTENT_TYPE];
    [manager.requestSerializer setValue:@"IOS" forHTTPHeaderField:PLATFORM_NAME];
    [manager.requestSerializer setValue:@"2.0" forHTTPHeaderField:CLIENT_VERSION];
    [manager.requestSerializer setValue:@"1" forHTTPHeaderField:CHANNEL_ID];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    [manager.requestSerializer setValue:locationString forHTTPHeaderField:DATE];
    return manager;
}
-(void)callAPI:(NSString *)api Param:(NSDictionary *)param withSuccessBlock:(SuccessBlock)successBlock fileBlock:(FaildBlock)fileBlock
{
    
    AFHTTPRequestOperationManager *manager = [self getManagerWithHeader];
    
    if (manager != nil) {
        [manager POST:api parameters:param success:^(AFHTTPRequestOperation *operation,id responseObject) {
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                NSDictionary *dic = (NSDictionary *)responseObject;
                NSLog(@"%@----%@",api,dic);
                int t = [[dic objectForKey:@"code"] intValue];
                if (t == 200) {
                    if (successBlock != nil) {
                        successBlock(dic);
                    }
                    
                }
                else
                {
                    if (fileBlock != nil) {
                        fileBlock([dic objectForKey:@"desc"]);
                    }
                    
                }
                
            }
            
        } failure:^(AFHTTPRequestOperation *operation,NSError *error)
         {
             if (fileBlock != nil) {
                 fileBlock([error localizedDescription]);
             }
             
         }];
    }
    
}

-(void)callAPI:(NSString *)api CallType:(AF_CallType)callType Param:(NSDictionary *)param bShowHUD:(BOOL)bShowHUD inView:(UIView *)inView text:(NSString *)text withSuccessBlock:(SuccessBlock)successBlock fileBlock:(FaildBlock)fileBlock
{
    
    AFHTTPRequestOperationManager *manager = [self getManagerWithHeader];
    
    if (manager != nil) {
        MBProgressHUD *hud;
        if (bShowHUD) {
            if (inView == nil) {
                inView = [UIApplication sharedApplication].keyWindow;
            }
            hud = [[MBProgressHUD alloc] initWithView:inView];
            [inView addSubview:hud];
            hud.labelText = text;
            [hud show:YES];
        }
        switch (callType) {
            case POST:
            {
                
                [self post:manager API:api HUD:hud Param:param withSuccessBlock:successBlock fileBlock:fileBlock];
                
            }
                break;
            case GET:
            {
                [self get:manager API:api HUD:hud Param:param withSuccessBlock:successBlock fileBlock:fileBlock];
                
            }
                break;
            default:
                break;
        }
        
    }
    
}

-(void)post:(AFHTTPRequestOperationManager *)manager API:(NSString *)api HUD:(MBProgressHUD *)hud Param:(NSDictionary *)param withSuccessBlock:(SuccessBlock)successBlock fileBlock:(FaildBlock)fileBlock
{
    
    NSLog(@"%@----%@",api,param);
    [manager POST:api parameters:param success:^(AFHTTPRequestOperation *operation,id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = (NSDictionary *)responseObject;
            [hud removeFromSuperview];
            NSLog(@"%@----%@",api,dic);
            int t = [[dic objectForKey:@"code"] intValue];
            if (t == 200) {
                if (successBlock != nil) {
                    successBlock(dic);
                }
                
            }
            else
            {
                if (fileBlock != nil) {
                    fileBlock([dic objectForKey:@"desc"]);
                }
                
            }
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation,NSError *error)
     {
         NSLog(@"%@----%@",api,error);
         [hud removeFromSuperview];
         if (fileBlock != nil) {
             fileBlock([error localizedDescription]);
         }
         
     }];
}

-(void)get:(AFHTTPRequestOperationManager *)manager API:(NSString *)api HUD:(MBProgressHUD *)hud Param:(NSDictionary *)param withSuccessBlock:(SuccessBlock)successBlock fileBlock:(FaildBlock)fileBlock
{
    
    NSLog(@"%@----%@",api,param);
    [manager GET:api parameters:param success:^(AFHTTPRequestOperation *operation,id responseObject) {
    
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = (NSDictionary *)responseObject;
            [hud removeFromSuperview];
            NSLog(@"%@----%@",api,dic);
            int t = [[dic objectForKey:@"code"] intValue];
            if (t == 200) {
                if (successBlock != nil) {
                    successBlock(dic);
                }
                
            }
            else
            {
                if (fileBlock != nil) {
                    fileBlock([dic objectForKey:@"desc"]);
                }
                
            }
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation,NSError *error)
     {
         NSLog(@"%@----%@",api,error);
         [hud removeFromSuperview];
         if (fileBlock != nil) {
             fileBlock([error localizedDescription]);
         }
         
     }];
}

-(void)UploadFile:(NSMutableURLRequest *)request withSuccessBlock:(SuccessBlock)successBlock fileBlock:(FaildBlock)fileBlock ProgressBlock:(ProgressBlock)pBlock
{
    AFHTTPRequestOperationManager *manager = [self getManagerWithHeader];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request
                                                                         success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        NSLog(@"ttt%@",dic);
        int t = [[dic objectForKey:@"code"] intValue];
        if (t == 200) {
        if (successBlock != nil) {
            successBlock(dic);
            }
        }
        else
        {
            if (fileBlock != nil) {
                fileBlock([dic objectForKey:@"desc"]);
                }
                                                                                 
                                                                             }
                                                                         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                                             if (fileBlock != nil) {
                                                                                 fileBlock([error localizedDescription]);
                                                                             }
                                                                         }];
    
    
    [operation setUploadProgressBlock:pBlock];
    [operation start];
}

- (void)downloadFileWithOption:(NSDictionary *)paramDic
                 withInferface:(NSString*)requestURL
                     savedPath:(NSString*)savedPath
               downloadSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
               downloadFailure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
                      progress:(void (^)(float progress))progress

{
    
    //沙盒路径    //NSString *savedPath = [NSHomeDirectory() stringByAppendingString:@"/Documents/xxx.zip"];
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    NSMutableURLRequest *request =[serializer requestWithMethod:@"POST" URLString:requestURL parameters:paramDic error:nil];
    
    //以下是手动创建request方法 AFQueryStringFromParametersWithEncoding有时候会保存
    //    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:requestURL]];
    //   NSMutableURLRequest *request =[[[AFHTTPRequestOperationManager manager]requestSerializer]requestWithMethod:@"POST" URLString:requestURL parameters:paramaterDic error:nil];
    //
    //    NSString *charset = (__bridge NSString *)CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    //
    //    [request setValue:[NSString stringWithFormat:@"application/x-www-form-urlencoded; charset=%@", charset] forHTTPHeaderField:@"Content-Type"];
    //    [request setHTTPMethod:@"POST"];
    //
    //    [request setHTTPBody:[AFQueryStringFromParametersWithEncoding(paramaterDic, NSASCIIStringEncoding) dataUsingEncoding:NSUTF8StringEncoding]];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setOutputStream:[NSOutputStream outputStreamToFileAtPath:savedPath append:NO]];
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        float p = (float)totalBytesRead / totalBytesExpectedToRead;
        progress(p);
        NSLog(@"download：%f", (float)totalBytesRead / totalBytesExpectedToRead);
        
    }];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(operation,responseObject);
        NSLog(@"下载成功");
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        success(operation,error);
        
        NSLog(@"下载失败");
        
    }];
    
    [operation start];
    
}

-(void)FleaNewEX:(NSString *)userID Pictures:(NSString *)path
withSuccessBlock:(SuccessBlock)successBlock fileBlock:(FaildBlock)fileBlock ProgressBlock:(void (^)(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite))pBlock
{
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:@"http://192.168.1.15:8080/uploads" parameters:@{@"UserID":userID} constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
         //   NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path]];
        //[formData appendPartWithFileData:data name:@"pictures" fileName:@"1.jpg" mimeType:@"multipart/form-data"];
        [formData appendPartWithFileURL:[NSURL fileURLWithPath:path] name:@"uploadfile" fileName:@"1.jpg" mimeType:@"multipart/form-data" error:nil];
    } error:nil];
   
    [self UploadFile:request withSuccessBlock:successBlock fileBlock:fileBlock ProgressBlock:pBlock];
    
}

-(void)callAPIWithNewB:(NSString *)api CallType:(AF_CallType)callType Param:(NSDictionary *)param bShowHUD:(BOOL)bShowHUD inView:(UIView *)inView text:(NSString *)text withSuccessBlock:(SuccessBlock)successBlock fileBlock:(FaildBlock)fileBlock
{
    
    AFHTTPRequestOperationManager *manager = [self getManagerWithHeader];
    
    if (manager != nil) {
        MBProgressHUD *hud;
        if (bShowHUD) {
            if (inView == nil) {
                inView = [UIApplication sharedApplication].keyWindow;
            }
            hud = [[MBProgressHUD alloc] initWithView:inView];
            [inView addSubview:hud];
            hud.labelText = text;
            [hud show:YES];
        }
        switch (callType) {
            case POST:
            {
                
                [self postWithNewB:manager API:api HUD:hud Param:param withSuccessBlock:successBlock fileBlock:fileBlock];
                
            }
                break;
            case GET:
            {
                [self getWithNewB:manager API:api HUD:hud Param:param withSuccessBlock:successBlock fileBlock:fileBlock];
                
            }
                break;
            default:
                break;
        }
        
    }
    
}

-(void)postWithNewB:(AFHTTPRequestOperationManager *)manager API:(NSString *)api HUD:(MBProgressHUD *)hud Param:(NSDictionary *)param withSuccessBlock:(SuccessBlock)successBlock fileBlock:(FaildBlock)fileBlock
{
    
    NSLog(@"%@----%@",api,param);
    [manager POST:api parameters:param success:^(AFHTTPRequestOperation *operation,id responseObject) {
        
        NSLog(@"%@----%@",api,responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = (NSDictionary *)responseObject;
            [hud removeFromSuperview];
            NSLog(@"%@----%@",api,dic);
            
            if (successBlock != nil) {
                successBlock(dic);
            }
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation,NSError *error)
     {
         NSLog(@"%@----%@",api,error);
         [hud removeFromSuperview];
         if (fileBlock != nil) {
             fileBlock([error localizedDescription]);
         }
         
     }];
}



-(void)getWithNewB:(AFHTTPRequestOperationManager *)manager API:(NSString *)api HUD:(MBProgressHUD *)hud Param:(NSDictionary *)param withSuccessBlock:(SuccessBlock)successBlock fileBlock:(FaildBlock)fileBlock
{
    
    NSLog(@"%@----%@",api,param);
    [manager GET:api parameters:param success:^(AFHTTPRequestOperation *operation,id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = (NSDictionary *)responseObject;
            [hud removeFromSuperview];
            NSLog(@"%@----%@",api,dic);
            if (successBlock != nil) {
                successBlock(dic);
            }
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation,NSError *error)
     {
         NSLog(@"%@----%@",api,error);
         [hud removeFromSuperview];
         if (fileBlock != nil) {
             fileBlock([error localizedDescription]);
         }
         
     }];
}


-(BOOL)setLocalCacheWithObjct:(NSObject *)obj Flage:(NSString *)flage
{
    NSDictionary * tmpDic = [Utils getObjectData:obj];
    return [tmpDic writeToFile:flage atomically:YES];
}

-(BOOL)setLocalCache:(NSDictionary *)dic Flage:(NSString *)flage
{
    return [dic writeToFile:flage atomically:YES];
}

-(NSDictionary *)getLocalCache:(NSString *)flage
{
    return [NSDictionary dictionaryWithContentsOfFile:flage];
}



@end
