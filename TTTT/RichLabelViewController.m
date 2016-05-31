//
//  RichLabelViewController.m
//  TTTT
//
//  Created by wxy on 16/1/27.
//  Copyright © 2016年 wuxianying. All rights reserved.
//

#import "RichLabelViewController.h"
#import "KZLinkLabel.h"

#define RichText        @"http://www.hao123.com[不服][给跪][不服]an example 15701669932哈哈哈哈哈哈哈 点击一下哈哈还好吧用力啊测试的的a"

@interface RichLabelViewController ()

@property (nonatomic,strong) KZLinkLabel *kzLbl;
@property (nonatomic, strong) CAShapeLayer    *allClickedLayer;

@end

@implementation RichLabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(KZLinkLabel *)kzLbl
{
    if (!_kzLbl) {
        
        _kzLbl = [KZLinkLabel new];
        _kzLbl.automaticLinkDetectionEnabled = YES;
        _kzLbl.canAllClicked = YES;
        _kzLbl.preferredMaxLayoutWidth = SCREEN_W-20;
        _kzLbl.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
        _kzLbl.numberOfLines = 0;
        [self.view addSubview:_kzLbl];
    }
    return _kzLbl;
}

-(CAShapeLayer *)allClickedLayer
{
    if (!_allClickedLayer) {
        
        _allClickedLayer = [CAShapeLayer layer];
        _allClickedLayer.fillColor = [UIColor blueColor].CGColor;
        //_allClickedLayer.fillRule = kCAFillRuleNonZero;
        _allClickedLayer.hidden = NO;
        //_allClickedLayer.strokeColor = [Utils randomColor].CGColor;
        
//        _allClickedLayer.lineCap = kCALineCapRound;
//        _allClickedLayer.lineJoin = kCALineCapRound;
//        _allClickedLayer.lineWidth = 5;
        
    }
    NSLog(@"%@",[NSValue valueWithCGRect:_allClickedLayer.frame]);
    return _allClickedLayer;
}

-(void)initView
{
    
    NSMutableAttributedString *maStr = [[NSMutableAttributedString alloc] initWithString:RichText];
    [self.kzLbl setLinkNSRange:[maStr.string rangeOfString:@"点击一下" options:NSCaseInsensitiveSearch] WithTag:2 AndAttributed:@{NSForegroundColorAttributeName:[UIColor redColor]}];
    
    
    self.kzLbl.attributedText = maStr;
    
    [self.kzLbl makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.top.equalTo(self.view.top).offset(NAV_STATUS_H(self)+10);
        
    }];

    UILabel *lbl = [UILabel new];
    lbl.text = RichText;
    lbl.font = SYS_FONT;
    lbl.numberOfLines = 0;
    lbl.preferredMaxLayoutWidth = SCREEN_W-20;
    [self.view addSubview:lbl];
    [lbl makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(self.kzLbl);
        make.top.equalTo(self.kzLbl.bottom).offset(10);
        
    }];
    
    CGSize size = [Utils sizeWithString:RichText font:SYS_FONT Size:CGSizeMake(SCREEN_W-20, CGFLOAT_MAX)];
    
    self.allClickedLayer.path = [self createShaperPath:size].CGPath;
    
    [lbl.layer addSublayer:self.allClickedLayer];
    
    
}

-(UIBezierPath *)createShaperPath:(CGSize)size
{

    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [self AddLinePath:path FromP:CGPointMake(0, 0) ToP:CGPointMake(size.width, 0)];
    [self AddLinePath:path FromP:CGPointMake(size.width, 0) ToP:CGPointMake(size.width, size.height-20)];
    [self AddLinePath:path FromP:CGPointMake(size.width, 20) ToP:CGPointMake(size.width-50, size.height-20)];
    [path addLineToPoint:CGPointMake(size.width-50, size.height)];
    [path addLineToPoint:CGPointMake(0, size.height)];
    [self AddLinePath:path FromP:CGPointMake(0, 20) ToP:CGPointMake(0, 0)];
    
    return path;
}

-(void)AddLinePath:(UIBezierPath *)path FromP:(CGPoint)fp ToP:(CGPoint)top
{
    //[path moveToPoint:fp];path要连续
    [path addLineToPoint:top];
}


@end
