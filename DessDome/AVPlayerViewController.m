//
//  AVPlayerViewController.m
//  DessDome
//
//  Created by Jack on 15/7/1.
//  Copyright (c) 2015年 zhr. All rights reserved.
//

#import "AVPlayerViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>
#import <MediaPlayer/MediaPlayer.h>
#define BottomViewHeight 49


@interface AVPlayerViewController (){
    AVPlayerLayer               *_playerLayer;
    CGFloat                     _movieLength;
    BOOL                        isHiple;
    BOOL                        _isPlaying;
}
@property (weak, nonatomic) IBOutlet UIButton               *fullscreonBut;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint     *playerHiderConst;
@property (weak, nonatomic) IBOutlet UIView                 *playerView;
@property (weak, nonatomic) IBOutlet UIView                 *butView;
@property (strong,nonatomic) AVPlayer                       *player;

//按钮
@property (weak, nonatomic) IBOutlet UIButton               *playBut;
@property (weak, nonatomic) IBOutlet UISlider               *movieProgress;
@property (assign, nonatomic) id                            timeObserver;

@end

@implementation AVPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"视频播放";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"system_back"] style:UIBarButtonItemStyleDone target:self action:@selector(cancelcol)];
    [self stupBut];
    //添加手势
    [self addGesture];
    //初始话播放页
    [self setupAvPlayer];
    //开始播放视频
    [self playMedia];
    [self.playerView bringSubviewToFront:_butView];
    
    //监听视频是否播放完毕
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerItemDidReachEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    
    
    
}
#pragma mark - 初始化按钮
-(void)stupBut{
    //[_movieProgress addTarget:self action:@selector(scrubbingDidBegin) forControlEvents:UIControlEventTouchDown];
    [_movieProgress addTarget:self action:@selector(scrubbingDidEnd) forControlEvents:(UIControlEventTouchUpInside | UIControlEventTouchCancel | UIControlEventTouchUpOutside)];
    //[_movieProgress addTarget:self action:@selector(scrubbingChanged) forControlEvents:UIControlEventValueChanged];
}
-(void)scrubbingDidEnd{
    [self jumpToSelectTime];
    
}
-(void)scrubbingChanged{
    
    
}
-(void)jumpToSelectTime{
    [_player pause];
    double currentTime = floor(_movieLength * _movieProgress.value);
    //转换成CMTime才能给player来控制播放进度
    CMTime dragedCMTime = CMTimeMake(currentTime, 1);
    [_player seekToTime:dragedCMTime completionHandler:
     ^(BOOL finish){
         if (_isPlaying == YES){
             [_player play];
            // [_progressHUD hide:YES];
         }
     }];

}

#pragma mark - 监控视频播放状态，
- (void)playerItemDidReachEnd:(NSNotification *)notification{
    NSLog(@"132播放完毕");
    _isPlaying =YES;
    [_playBut setImage:[UIImage imageNamed:@"pause_nor.png"] forState:UIControlStateNormal];
    
}
#pragma mark - 视频加载状态
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
     AVPlayerItem  * playerItem = (AVPlayerItem *)object;
    if ([keyPath isEqualToString:@"status"]) {
       
        if ([playerItem status]==AVPlayerStatusReadyToPlay) {
            [_playBut setImage:[UIImage imageNamed:@"pause_nor.png"] forState:UIControlStateNormal];
            CMTime duration = playerItem.duration;// 获取视频总长度
           // CGFloat totalSecond = playerItem.duration.value / playerItem.duration.timescale;// 转换成秒
            [self customVideoSlider:duration];
//            float  progress = 0;
//            _movieProgress.value = progress;
        }
    }else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        NSTimeInterval timeInterval = [self availableDuration];// 计算缓冲进度
        NSLog(@"Time Interval:%f",timeInterval);
//        CMTime duration = playerItem.duration;
//        CGFloat totalDuration = CMTimeGetSeconds(duration);
//        //[self.movieProgress setProgress:timeInterval / totalDuration animated:YES];
//        self.movieProgress.value = timeInterval / totalDuration;
    }

}
#pragma mark - 自定义进度条
-(void)customVideoSlider:(CMTime)duration{
   // _movieProgress.maximumValue = CMTimeGetSeconds(duration);
    
    
}
//计算缓冲总进度
- (NSTimeInterval)availableDuration {
    NSArray *loadedTimeRanges = [[_player currentItem] loadedTimeRanges];
    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
    float startSeconds = CMTimeGetSeconds(timeRange.start);
    float durationSeconds = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval result = startSeconds + durationSeconds;// 计算缓冲总进度
    return result;
}
#pragma mark - 取得播放时间
- (NSTimeInterval)playableDuration{
    AVPlayerItem  *item = self.player.currentItem;
    if (item.status == AVPlayerItemStatusReadyToPlay) {
        return CMTimeGetSeconds(self.player.currentItem.duration);
    }else{
        return (CMTimeGetSeconds(kCMTimeInvalid));
    }
}
//- (NSTimeInterval)playableCurrentTime{
//    AVPlayerItem  *item = self.player.currentItem;
//    if (item.status == AVPlayerItemStatusReadyToPlay) {
//        NSLog(@"%f\n",CMTimeGetSeconds(self.player.currentItem.currentTime));
//    }
//    
//    
//}


#pragma mark - 初始化播放页
-(void)setupAvPlayer{
//    处理音频
    AVAudioSession  * audioSession = [AVAudioSession sharedInstance];
//    AVAudioSessionCategoryPlayback 类别 会试程序在静音等模式下视频继续播放
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
   // CGRect  playerFrame = CGRectMake(0, 0, self.view.layer.bounds.size.width, 193);
    _player = [[AVPlayer alloc] init];
//    把avplayer添加到里边  不然播放不了
    _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    _playerLayer.frame = _playerView.layer.bounds;
//    边界巨型
    _playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    [self.playerView.layer addSublayer:_playerLayer];
//    监听音频输出路线
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(routeChange:)
                                                 name:AVAudioSessionRouteChangeNotification
                                               object:nil];
    
}
-(void)routeChange:(NSNotification  *)notification{
    NSDictionary *interuptionDict = notification.userInfo;
    
    NSInteger routeChangeReason = [[interuptionDict valueForKey:AVAudioSessionRouteChangeReasonKey] integerValue];
    
    switch (routeChangeReason) {
        case AVAudioSessionRouteChangeReasonUnknown:
           // MyLog(@"routeChangeReason : AVAudioSessionRouteChangeReasonUnknown");
            break;
            
        case AVAudioSessionRouteChangeReasonNewDeviceAvailable:
            // a headset was added or removed
         //   MyLog(@"routeChangeReason : AVAudioSessionRouteChangeReasonNewDeviceAvailable");
            break;
            
        case AVAudioSessionRouteChangeReasonOldDeviceUnavailable:
            // a headset was added or removed
//            MyLog(@"routeChangeReason : AVAudioSessionRouteChangeReasonOldDeviceUnavailable");
//            //            暂停播放
//            _isPlaying = NO;
//            [_playBtn setImage:[UIImage imageNamed:@"play_nor"] forState:UIControlStateNormal];
            break;
            
        case AVAudioSessionRouteChangeReasonCategoryChange:
            // called at start - also when other audio wants to play
           // MyLog(@"routeChangeReason : AVAudioSessionRouteChangeReasonCategoryChange");//AVAudioSessionRouteChangeReasonCategoryChange
            break;
            
        case AVAudioSessionRouteChangeReasonOverride:
           // MyLog(@"routeChangeReason : AVAudioSessionRouteChangeReasonOverride");
            break;
            
        case AVAudioSessionRouteChangeReasonWakeFromSleep:
          //  MyLog(@"routeChangeReason : AVAudioSessionRouteChangeReasonWakeFromSleep");
            break;
            
        case AVAudioSessionRouteChangeReasonNoSuitableRouteForCategory:
           // MyLog(@"routeChangeReason : AVAudioSessionRouteChangeReasonNoSuitableRouteForCategory");
            break;
            
        default:
            break;
    }

    
    
}

#pragma mark - 横竖屏切换按钮
- (IBAction)fullScreenAction:(UIButton *)sender {
    if (self.interfaceOrientation==UIInterfaceOrientationPortrait) {
         [self forceRotate:UIInterfaceOrientationLandscapeRight];
        self.navigationController.navigationBarHidden = YES;
    }else{
        [self forceRotate:UIInterfaceOrientationPortrait];
        self.navigationController.navigationBarHidden = NO;
    }
    
}
-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    if (toInterfaceOrientation==UIDeviceOrientationPortrait) {
        self.playerHiderConst.constant = 193;
        _playerLayer.frame = CGRectMake(0, -5, 320, 193);
        [self toolbarHidden:NO];
    }else{
        [self toolbarHidden:YES];
        self.playerHiderConst.constant = 320;
        _playerLayer.frame = CGRectMake(0, -25, 480, 320);
    }
}
#pragma mark - 强制切换横竖屏
- (void)forceRotate:(UIInterfaceOrientation)orientation
{
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = orientation;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}
#pragma mark - 视频播放
-(void)playMedia{
    NSURL  * mediaUrl = [NSURL URLWithString:@"http://nclm.qida.com/courses/manageplatform/C0165/b7e11076-1aad-4227-98a4-c549b028226e/video/study01.mp4"];
   //http://nclm.qida.com/courses/manageplatform/C0165/b7e11076-1aad-4227-98a4-c549b028226e/video/study01.mp4
    //http://krtv.qiniudn.com/150522nextapp
    AVURLAsset  * asset = [AVURLAsset URLAssetWithURL:mediaUrl options:nil];
    AVPlayerItem  * playerItem = [AVPlayerItem playerItemWithAsset:asset];
    CMTime totalTime = CMTimeMake(0, 0);
    totalTime.value += playerItem.asset.duration.value;
    totalTime.timescale = playerItem.asset.duration.timescale;
    _movieLength = (CGFloat)totalTime.value/totalTime.timescale;
   // [_player.currentItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
   // [_player.currentItem  addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    [_player replaceCurrentItemWithPlayerItem:playerItem];
   // if (_isPlaying) {
        [_player play];
   // }
//    用于监听播放状态
    __weak typeof(_player) player_ = _player;
    __weak typeof(_movieProgress) movieProgress_ = _movieProgress;
    typeof(_movieLength) *moviewLength_ = &_movieLength;
    _timeObserver = [_player addPeriodicTimeObserverForInterval:CMTimeMake(3, 30) queue:NULL usingBlock:^(CMTime time) {
        //获取当前时间
        CMTime currentTime = player_.currentItem.currentTime;
        double currentPlayTime = (double)currentTime.value/currentTime.timescale;
        // 转换成秒
       // CGFloat remainingTime = (*moviewLength_)-currentPlayTime;
        movieProgress_.value = currentPlayTime /(*moviewLength_);
        
    }];
    
}


-(void)cancelcol{
    
    
    [_player removeTimeObserver:_timeObserver];
    //[_player.currentItem removeObserver:self forKeyPath:@"status"];
    //[_player.currentItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    [_player replaceCurrentItemWithPlayerItem:nil];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    [[self class]cancelPreviousPerformRequestsWithTarget:self];
    
    [self dismissViewControllerAnimated:YES completion:^{
        self.timeObserver = nil;
        self.player = nil;
        
    }];
}
- (void)toolbarHidden:(BOOL)Bool{
    self.navigationController.navigationBar.hidden = Bool;
    self.tabBarController.tabBar.hidden = Bool;
    [[UIApplication sharedApplication] setStatusBarHidden:Bool withAnimation:UIStatusBarAnimationFade];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if (isHiple==YES) {
        [self showControlBar];
    }else{
        [self hideControlBar];
    }
}
-(void)showControlBar{
    isHiple = NO;
    [UIView animateWithDuration:0.3 animations:^{
        
      //  CGRect topFrame = _butView.frame;
        CGRect bottomFrame = _butView.frame;
        //topFrame.origin.y = 0;
        bottomFrame.origin.y = self.playerView.frame.size.height-BottomViewHeight;
       // _butView.frame = topFrame;
        _butView.frame = bottomFrame;
    }];

}
-(void)hideControlBar{
    isHiple =YES;
    [UIView animateWithDuration:0.3 animations:^{
     //   CGRect topFrame = _topView.frame;
        CGRect bottomFrame = _butView.frame;
        bottomFrame.origin.y = self.playerView.frame.size.height;
        _butView.frame = bottomFrame;
    }];

}
#pragma mark - gesture手势
-(void)addGesture{
    //添加一个单击手势
    UITapGestureRecognizer  *tapGesture = [[UITapGestureRecognizer alloc] init];
    tapGesture.numberOfTapsRequired = 1;
    
}
#pragma mark - 按钮的初始化
//暂停按钮
- (IBAction)playBut:(UIButton *)sender {
    _isPlaying =!_isPlaying;
    if (_isPlaying) {
        [_player pause];
        [_playBut setImage:[UIImage imageNamed:@"play_nor.png"] forState:UIControlStateNormal];
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideControlBar) object:nil];
    }else{
        [_player play];
        [_playBut setImage:[UIImage imageNamed:@"pause_nor.png"] forState:UIControlStateNormal];
        [self performSelector:@selector(hideControlBar) withObject:nil afterDelay:3];

    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
