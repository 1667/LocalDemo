//
//  MovieViewController.m
//  TTTT
//
//  Created by 无线盈 on 15/10/9.
//  Copyright © 2015年 wuxianying. All rights reserved.
//

#import "MovieViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface MovieViewController ()

@property (nonatomic,strong)MPMoviePlayerController *movieVc;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;

@end

@implementation MovieViewController
{

    BOOL                        stauts_bar_hiden;
}

-(void)initView
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *play = [UIButton new];
    [self.view addSubview:play];
    [play setTitle:@"播放" forState:UIControlStateNormal];
    [play addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
    [play makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(self.view);
        make.height.equalTo(80);
        
    }];
    [self addMoive];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addMoive
{
    NSDictionary *dic = [Utils getLocalCache:FILE_FLAGES_URL(@"1")];
    NSString *url = @"http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4";
    if (dic != nil) {
        url = [dic objectForKey:@"url"];
    }
    
    NSURL *videoUrl=[NSURL URLWithString:url];
    _movieVc =[[MPMoviePlayerController alloc] initWithContentURL:videoUrl];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dissmiss:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:_movieVc name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loading:) name:MPMoviePlayerLoadStateDidChangeNotification object:nil];
    
    [_movieVc prepareToPlay];
    _movieVc.controlStyle = MPMovieControlStyleEmbedded;
    [_movieVc.view setFrame:CGRectMake(0, NAV_STATUS_H(self), self.view.frame.size.width, 200)];
    [self.view addSubview:_movieVc.view];
    
    [self playerViewDelegateSetStatusBarHiden:NO];
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(100, 100, 60, 60)];
    [self.view addSubview:self.activityIndicator];
    _activityIndicator.center = _movieVc.view.center;
    self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    [self.activityIndicator startAnimating];
    [self.view bringSubviewToFront:_activityIndicator];
    
}

-(void)play
{
    
}

-(void)playerViewDelegateSetStatusBarHiden:(BOOL)is_hiden
{
    [[UIApplication sharedApplication] setStatusBarHidden:is_hiden withAnimation:UIStatusBarAnimationSlide];
    //[[UIApplication sharedApplication] setStatusBarHidden:is_hiden];
    
}

-(void)loading:(NSNotification *)not
{
    
    [_activityIndicator removeFromSuperview];
}

-(void)dissmiss:(NSNotification *)not
{
    NSDictionary *ui = not.userInfo;
    NSLog(@"%@",ui);
    NSInteger i = [[ui objectForKey:@"MPMoviePlayerPlaybackDidFinishReasonUserInfoKey"] integerValue];
    if (i == 2) {
        [self dismissMoviePlayerViewControllerAnimated];
    }
    [self playerViewDelegateSetStatusBarHiden:NO];
}

@end
