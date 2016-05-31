//
//  LandScapeScrollView.m
//  TTTT
//
//  Created by 无线盈 on 15/10/14.
//  Copyright © 2015年 wuxianying. All rights reserved.
//

#import "LandScapeScrollView.h"
#import "Utils.h"

@interface LandScapeScrollView() <UIScrollViewDelegate>

@end

@implementation LandScapeScrollView
{
    UIScrollView            *_scrollView;
    NSMutableArray          *_array;
    UIPageControl           *_pageControl;
    NSInteger               _currentIndex;
    NSTimer                 *_timer;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

-(NSMutableArray *)createViewArr
{
    NSMutableArray *tmpArray = [NSMutableArray new];
    for (int i = 0; i < 4; i++) {
        UIButton *view = [[UIButton alloc] initWithFrame:self.bounds];
        view.backgroundColor = [Utils randomColor];
        
        [view setTitle:[NSString stringWithFormat:@"%d",i] forState:UIControlStateNormal];
        
        [tmpArray addObject:view];
    }
    return tmpArray;
    
}

-(void)initView
{
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_scrollView];
    
    _array = [NSMutableArray new];
    NSMutableArray *arr = [self createViewArr];
    UIView *v = [[UIView alloc] initWithFrame:_scrollView.bounds];
    //[v addSubview:[arr objectAtIndex:[arr count]-1]];
    v = [self duplicate:[arr objectAtIndex:[arr count]-1]];
    [_array addObject:v];
    for (UIView *v in arr) {
        [_array addObject:v];
    }

    UIView *v2 = [[UIView alloc] initWithFrame:_scrollView.bounds];
    v2 = [self duplicate:[arr objectAtIndex:0]];
    [_array addObject:v2];
    CGFloat x = 0;
    for (UIView *v in _array) {
       v.frame = CGRectMake(x, 0, self.bounds.size.width, self.bounds.size.height);
        [_scrollView addSubview:v];
        x += CGRectGetWidth(_scrollView.bounds);
    };
    
    
    _scrollView.contentSize = CGSizeMake(x, CGRectGetHeight(_scrollView.bounds));
    
    [_scrollView setContentOffset:CGPointMake(CGRectGetWidth(_scrollView.bounds), 0) animated:NO];
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), 20)];
    
    _pageControl.numberOfPages = [_array count]-2;
    _pageControl.currentPage = 0;
    _pageControl.hidesForSinglePage = YES;
    [self addSubview:_pageControl];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(NextPage) userInfo:nil repeats:YES];
    [_pageControl makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_scrollView.centerX);
        make.bottom.equalTo(_scrollView.bottom).offset(-20);
    }];
    
}
- (UIView*)duplicate:(UIView*)view
{
    NSData * tempArchive = [NSKeyedArchiver archivedDataWithRootObject:view];
    return [NSKeyedUnarchiver unarchiveObjectWithData:tempArchive];
}
-(CGPoint)contentOffsetForIndex:(NSInteger)Index
{
    CGFloat x = CGRectGetWidth(self.bounds)*(Index);
    return CGPointMake(x, 0);
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _currentIndex = (scrollView.contentOffset.x) /CGRectGetWidth(self.bounds);
    if(_currentIndex == 0)
    {
        if(scrollView.contentOffset.x == 0)
        {
            _currentIndex = 0;
        }
        else
        {
            _currentIndex = 1;
        }
    }
   // NSLog(@" current %ld ",(long)_currentIndex);
    if(_currentIndex == [_array count]-1)
    {
        _currentIndex = 1;
        [scrollView setContentOffset:[self contentOffsetForIndex:_currentIndex] animated:NO];
    }
    if(_currentIndex == 0)
    {
        _currentIndex = [_array count]-2;
        [scrollView setContentOffset:[self contentOffsetForIndex:_currentIndex] animated:NO];
    }
    _pageControl.currentPage = _currentIndex-1;
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    [_timer invalidate];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
//    if(_currentIndex == [_array count]-1)
//    {
//        _currentIndex = 0;
//        [scrollView setContentOffset:[self contentOffsetForIndex:_currentIndex] animated:NO];
//    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(NextPage) userInfo:nil repeats:YES];
}

-(void)NextPage
{
    _currentIndex++;
    
    [self scrollToPage:_currentIndex animated:YES];
}

-(void)scrollToPage:(NSInteger)index animated:(BOOL)animated
{
    [_scrollView setContentOffset:[self contentOffsetForIndex:index] animated:animated];
}

@end
