//
//  PostTestViewController.m
//  TTTT
//
//  Created by wxy on 16/3/16.
//  Copyright © 2016年 wuxianying. All rights reserved.
//

#import "PostTestViewController.h"
#import "PostTestTableViewCell.h"

@implementation DataItem

-(instancetype)init
{
    self = [super init];
    
    if (self) {
        self.key = @"";
        self.value = @"";
    }
    
    return self;
}

@end

@interface PostTestViewController ()<TextFileChangedDelegate>

@property (nonatomic,strong) UIButton               *postBtn;
@property (nonatomic,strong) UITextField            *tfUrl;
@property (nonatomic,strong) UITextField            *tfAPI;
@property (nonatomic,strong) UIView                 *resultView;
@end

@implementation PostTestViewController
{
    NSMutableArray      *data;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitleText:@"Post测试"];
    self.navigationItem.rightBarButtonItem = [[Utils instance] createRightItem:@selector(addObj) target:self Str:@"添加"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initView
{
    data = [NSMutableArray new];
    
    [self.tfUrl makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.top.equalTo(self.view).offset(NAV_STATUS_H(self)+10);
        make.height.equalTo(50);
    }];
    
    [self.tfAPI makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.top.equalTo(self.tfUrl.bottom).offset(10);
        make.height.equalTo(50);
    }];
    
    [self.postBtn makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(60);
        
    }];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[PostTestTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(NAV_STATUS_H(self)+120, 0, 60,0));
        
    }];

    
    
}

#pragma mark initPro

-(UIButton *)postBtn
{
    if (!_postBtn) {
        
        _postBtn = [UIButton new];
        
        [_postBtn setTitle:@"测试" forState:UIControlStateNormal];
        [_postBtn setBackgroundColor:[Utils randomColor]];
        [_postBtn addTarget:self action:@selector(postT) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_postBtn];
        
    }
    return _postBtn;
}

-(UITextField *)tfUrl
{
    if (!_tfUrl) {
        
        _tfUrl = [UITextField new];
        _tfUrl.borderStyle = UITextBorderStyleRoundedRect;
        _tfUrl.placeholder = @"www.baidu.com";
        [self.view addSubview:_tfUrl];
        
    }
    return _tfUrl;
}

-(UITextField *)tfAPI
{
    if (!_tfAPI) {
        
        _tfAPI = [UITextField new];
        _tfAPI.borderStyle = UITextBorderStyleRoundedRect;
        _tfAPI.placeholder = @"/getCode";
        [self.view addSubview:_tfAPI];
        
    }
    return _tfAPI;
}


#pragma mark selector

-(void)addObj
{
    DataItem *tmpD = [DataItem new];
    
    [data addObject:tmpD];
    [self.tableView reloadData];
    
}

-(BOOL)checkValue
{
    if (self.tfUrl.text.length == 0) {
        [Utils showAllTextDialog:[MBProgressHUD new] View:self.view Str:@"请输入URL"];
        return NO;
    }
    
    if (self.tfAPI.text.length == 0) {
        [Utils showAllTextDialog:[MBProgressHUD new] View:self.view Str:@"请输入API"];
        return NO;
    }
    if ([data count] == 0) {
        [Utils showAllTextDialog:[MBProgressHUD new] View:self.view Str:@"请添加参数"];
        return NO;
    }
    return YES;
}

-(NSString *)getAPI
{
    if ([self checkValue]) {
        return [NSString stringWithFormat:@"http://%@%@",self.tfUrl.text,self.tfAPI.text];
    }
    return nil;
}

-(NSMutableDictionary *)getDic
{
    NSMutableDictionary *div = [NSMutableDictionary new];
    
    for (DataItem *item in data) {
        [div setValue:item.value forKey:item.key];
    }
    
    return div;
}

-(void)postT
{
    NSString *url = [self getAPI];

    if (url) {
        NSMutableDictionary *para = [self getDic];
        [[ServerManager instance] callAPIWithNewB:url CallType:POST Param:para bShowHUD:YES inView:self.view text:HUD_LOANDING withSuccessBlock:^(NSDictionary *dictionary) {
            
            NSLog(@"%@",dictionary);
            [Utils showAllTextDialog:[MBProgressHUD new] View:self.view Str:[dictionary description]];
            
        } fileBlock:^(NSString *errDescription) {
            [Utils showAllTextDialog:[MBProgressHUD new] View:self.view Str:errDescription];
            
            
        }];
    }
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [data count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DataItem *item = [data objectAtIndex:indexPath.row];
    PostTestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.delegate = self;
    cell.supTab = self.tableView;
    cell.keyName.text = item.key;
    cell.valueName.text = item.value;
    return cell;
    
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [data removeObjectAtIndex:indexPath.row];
    }
    
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

-(void)textChange:(UITextField *)tf IndexPath:(NSIndexPath *)path
{
    DataItem *item = [data objectAtIndex:path.row];
    if (tf.tag == KEY) {
        item.key = tf.text;
    }
    if (tf.tag == VALUE) {
        item.value = tf.text;
    }
}

-(void)tableView:(UITableView *)tableView didSelefeefctRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end










