//
// Created by huamulou on 15/9/5.
// Copyright (c) 2015 Alipay. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TFEFile : NSObject
/**
 * 空间
 */
@property(nonatomic, strong) NSString *space;
/**
 * 文件夹， 以斜杠开头不以斜杠结尾
 */
@property(nonatomic, strong) NSString *dir;
/**
 * 文件名
 */
@property(nonatomic, strong) NSString *name;

- (instancetype)initWithSpace:(NSString *)space dir:(NSString *)dir name:(NSString *)name;

+ (instancetype)fileWithSpace:(NSString *)space dir:(NSString *)dir name:(NSString *)name;

@end

