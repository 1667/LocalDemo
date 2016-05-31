//
//  PostTestTableViewCell.m
//  TTTT
//
//  Created by wxy on 16/3/18.
//  Copyright © 2016年 wuxianying. All rights reserved.
//

#import "PostTestTableViewCell.h"
#import "Utils.h"

@implementation PostTestTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

#pragma mark initPro

-(UITextField *)keyName
{
    if (!_keyName) {
        
        _keyName = [UITextField new];
        _keyName.placeholder = @"请输入键名";
        _keyName.tag = KEY;
        _keyName.borderStyle = UITextBorderStyleRoundedRect;
        [_keyName addTarget:self action:@selector(TfChange:) forControlEvents:UIControlEventEditingDidEnd];
        [self.contentView addSubview:_keyName];
        
    }
    return _keyName;
}

-(UITextField *)valueName
{
    if (!_valueName) {
        
        _valueName = [UITextField new];
        _valueName.placeholder = @"请输入值";
        _valueName.tag = VALUE;
        _valueName.borderStyle = UITextBorderStyleRoundedRect;
        [_valueName addTarget:self action:@selector(TfChange:) forControlEvents:UIControlEventEditingDidEnd];
        [self.contentView addSubview:_valueName];
        
    }
    return _valueName;
}

#pragma mark FUN

-(void)initView
{
    
}

-(void)layoutSubviews
{
    
    MASAttachKeys(self.keyName,self.valueName,self.contentView);
    
    [self.keyName makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView.centerX).offset(-5);
        make.height.equalTo(self.contentView).multipliedBy(0.8);
        make.centerY.equalTo(self.contentView);
    }];

    [self.valueName makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.centerX).offset(5);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.equalTo(self.contentView).multipliedBy(0.8);
        make.centerY.equalTo(self.contentView);
    }];
    
    
}

-(void)TfChange:(UITextField *)tf
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(textChange:IndexPath:)]) {
        [self.delegate textChange:tf IndexPath:[self.supTab indexPathForCell:self]];
    }
}

@end
