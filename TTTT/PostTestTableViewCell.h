//
//  PostTestTableViewCell.h
//  TTTT
//
//  Created by wxy on 16/3/18.
//  Copyright © 2016年 wuxianying. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger,TF_TAG) {
    KEY = 199,
    VALUE = 166
};

@protocol TextFileChangedDelegate <NSObject>

-(void)textChange:(UITextField *)tf IndexPath:(NSIndexPath *)path;

@end

@interface PostTestTableViewCell : UITableViewCell

@property (nonatomic,strong) UITextField        *keyName;
@property (nonatomic,strong) UITextField        *valueName;
@property (nonatomic,strong) UITableView        *supTab;
@property (nonatomic,strong) id<TextFileChangedDelegate>        delegate;


@end
