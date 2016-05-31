//
//  CollectionViewController.m
//  TTTT
//
//  Created by 无线盈 on 15/10/15.
//  Copyright © 2015年 wuxianying. All rights reserved.
//

#import "CollectionViewController.h"
#import "CollectionViewCell.h"

#define kCellWidth          (SCREEN_W/2-40)

@interface CollectionViewController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation CollectionViewController
{
    UICollectionView            *_collectionView;
    UICollectionViewFlowLayout  *_layout;
    NSMutableArray              *_array;
    NSMutableArray              *_arrayH;
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
    _array = [[NSMutableArray alloc] initWithObjects:[UIImage imageNamed:@"tu8601_7.jpg"],[UIImage imageNamed:@"tu8601_5.jpg"],[UIImage imageNamed:@"tu8601_10.jpg"],[UIImage imageNamed:@"aaa.jpg"],[UIImage imageNamed:@"tu8601_7.jpg"],[UIImage imageNamed:@"tu8601_5.jpg"],[UIImage imageNamed:@"ttt.jpg"],[UIImage imageNamed:@"bbb.jpg"], nil];
    
    _layout = [[UICollectionViewFlowLayout alloc] init];
    [_layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NAV_STATUS_H(self), self.selfViewWidth, self.selfViewHieght-NAV_STATUS_H(self)) collectionViewLayout:_layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    _collectionView.layer.contents = (__bridge id)([UIImage imageNamed:@"ttt.jpg"].CGImage);
    [self.view addSubview:_collectionView];
    _arrayH = [NSMutableArray new];
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_array count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [Utils randomColor];
    cell.alpha = 0.8;
    UIImage *image = [_array objectAtIndex:indexPath.row];
    [cell setImage:image];
    CGFloat scale = kCellWidth/image.size.width;
    CGFloat h = image.size.height*scale;
    
    NSInteger currentRow = indexPath.row/2;
    NSInteger currentLine = indexPath.row % 2;//判断是左边还是右边
    CGFloat y = 0;
    for (int i = 0; i < currentRow; i++) {
        NSInteger p = currentLine + i*2;
        y += [_arrayH[p] floatValue]+10;
    }
    
    [cell setFrame:CGRectMake(kCellWidth*currentLine+20+currentLine*20, y, kCellWidth, h)];
    
    return cell;
}

//-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 10;
//}
//
//-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 100;
//}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIImage *image = [_array objectAtIndex:indexPath.row];
    CGFloat scale = kCellWidth/image.size.width;
    CGFloat h = image.size.height*scale;
    [_arrayH addObject:[NSString stringWithFormat:@"%f",h]];
    return CGSizeMake(kCellWidth, h);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 20, 0, 20);
}


@end
