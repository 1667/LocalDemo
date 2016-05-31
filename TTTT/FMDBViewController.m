//
//  FMDBViewController.m
//  TTTT
//
//  Created by 无线盈 on 15/10/19.
//  Copyright © 2015年 wuxianying. All rights reserved.
//

#import "FMDBViewController.h"
#import <FMDatabase.h>

@interface FMDBViewController () <UITableViewDelegate,UITableViewDataSource>

@end

@implementation FMDBViewController
{
    FMDatabase          *db;
    UITableView         *_tableView;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initView
{
    _tableView = [UITableView new];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    
    
}

-(void)createTable
{
    
}

@end
