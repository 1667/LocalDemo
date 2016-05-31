//
//  AVPlayerView.m
//  TTTT
//
//  Created by 无线盈 on 15/10/9.
//  Copyright © 2015年 wuxianying. All rights reserved.
//

#import "AVPlayerView.h"
#import <AVFoundation/AVFoundation.h>
@implementation AVPlayerView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

-(void)initView
{
    
    NSURL *URL = [[NSURL alloc] initWithString:@"http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4"];
    //create player and player layer
    AVPlayer *player = [AVPlayer playerWithURL:URL];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    //set player layer frame and attach it to our view
    playerLayer.frame = self.bounds;
    [self.layer addSublayer:playerLayer];
    //play the video
    [player play];
}

@end
