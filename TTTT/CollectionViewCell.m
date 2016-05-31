//
//  CollectionViewCell.m
//  TTTT
//
//  Created by 无线盈 on 15/10/15.
//  Copyright © 2015年 wuxianying. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell
{
    UIImageView *_imageView;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tu8601_5.jpg"]];
        [self.contentView addSubview:_imageView];
        _imageView.frame = self.bounds;
        
    }
    return self;
}

-(void)setImage:(UIImage *)image
{
    _imageView.image = image;
}

@end
