//
//  ContectViewController.m
//  TTTT
//
//  Created by 无线盈 on 15/10/13.
//  Copyright © 2015年 wuxianying. All rights reserved.
//

#import "ContectViewController.h"

@interface ContectViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ContectViewController
{
    UITableView *_tableView;
    NSMutableArray  *items;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView = [UITableView new];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
    
    [_tableView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 1000; i++) {
        
        [array addObject:@{@"name": [self randomName], @"image": [self randomAvatar]}];
    }
    items = array;
    
    
    
}

- (NSString *)randomName
{
    NSArray *first = @[@"Alice", @"Bob", @"Bill", @"Charles", @"Dan", @"Dave", @"Ethan", @"Frank"];
    NSArray *last = @[@"Appleseed", @"Bandicoot", @"Caravan", @"Dabble", @"Ernest", @"Fortune"];
    NSUInteger index1 = (rand()/(double)INT_MAX) * [first count];
    NSUInteger index2 = (rand()/(double)INT_MAX) * [last count];
    return [NSString stringWithFormat:@"%@ %@", first[index1], last[index2]];
}
- (NSString *)randomAvatar
{
    NSArray *images = @[@"bike", @"airplane50", @"heiicopter7", @"DazRing", @"DazHeart", @"DazFlake"];
    NSUInteger index = (rand()/(double)INT_MAX) * [images count];
    return images[index];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //dequeue cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    //load image
    NSDictionary *item = items[indexPath.row];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:item[@"image"] ofType:@"png"];
    //set image and text
    cell.imageView.image = [UIImage imageWithContentsOfFile:filePath];
    cell.textLabel.text = item[@"name"];
    //set image shadow
    cell.imageView.layer.shadowOffset = CGSizeMake(0, 5);
    cell.imageView.layer.shadowOpacity = 0.75;
    cell.clipsToBounds = YES;
    //set text shadow
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.layer.shadowOffset = CGSizeMake(0, 2);
    cell.textLabel.layer.shadowOpacity = 0.5;
    cell.layer.shouldRasterize = YES;//开启图层缓存
    cell.layer.rasterizationScale = [UIScreen mainScreen].scale;//抗锯齿
    
    return cell;
}

@end
