//
//  MyAVPlayerController.m
//  
//
//  Created by Jack on 15/10/20.
//
//
#define kValidateValue @"?validate-code=cWlkYTIwMTUrKw=="


#import "MyAVPlayerController.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>
#import <MediaPlayer/MediaPlayer.h>
#import "CourseDetail.h"
#import "CourseComment.h"
#import "DownLoadTool.h"


@interface MyAVPlayerController ()
@property (weak, nonatomic) IBOutlet UIView *nameView;
@property (weak, nonatomic) IBOutlet UIView *butView;
@property (weak, nonatomic) IBOutlet UITableView *menuTableView;
@property (weak, nonatomic) IBOutlet UIView *playerView;
//d85567fe0f3281116c04879b0a53d2d5f2e1db19
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *playerViewHeight;
@property (strong, nonatomic) AVPlayer *player;
@property (strong, nonatomic) AVPlayerLayer *playerLayer;

@end

@implementation MyAVPlayerController

-(void)dealloc{
    [_player.currentItem removeObserver:self forKeyPath:@"status"];
    [_player.currentItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = self.courseComment.itemTitle;
    //导航栏
    [self myNavigationItem];
    //播放处理
    [self initAllizationAvPlayer];
    
    
    [self.playerView bringSubviewToFront:_nameView];
    [self.playerView bringSubviewToFront:_butView];
    [self.playerView bringSubviewToFront:_menuTableView];
    [self playMedia];
}
#pragma mark - 初始化播放
-(void)initAllizationAvPlayer{
    AVAudioSession  * audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    CGRect   playerFrame = CGRectMake(0, 0, self.view.layer.bounds.size.width, 190);
    _player = [[AVPlayer alloc] init];
    _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    _playerLayer.frame = playerFrame;
    _playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    [self.playerView.layer addSublayer:_playerLayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(routeChange:) name:AVAudioSessionRouteChangeNotification object:nil];
}
-(void)routeChange:(NSNotification *)notification{
    
}
#pragma mark - 视频播放
-(void)playMedia{
    dispatch_queue_t mediaQueue = dispatch_queue_create("mediaqueue", NULL);
    dispatch_async(mediaQueue, ^{
       dispatch_async(dispatch_get_main_queue(), ^{
          
           NSURL   *mediaUrl;
           if (self.courseComment.downloadStatus ==3) {
               NSString  * playUrl = [[DownLoadTool downloadFolderPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@.mp4",self.courseComment.commentId]]];
               mediaUrl = [NSURL fileURLWithPath:playUrl];
           }else{
               mediaUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",self.courseComment.itemUrl,kValidateValue]];
           }
           
           AVURLAsset  *asset = [AVURLAsset URLAssetWithURL:mediaUrl options:nil];
           AVPlayerItem  * playerItem = [AVPlayerItem playerItemWithAsset:asset];
           [_player.currentItem removeObserver:self forKeyPath:@"status"];
           [_player.currentItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
           [_player replaceCurrentItemWithPlayerItem:playerItem];
           [_player play];
           
           [_player.currentItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
           [_player.currentItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
           
       });
    });
    
    
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"status"]) {
        
    }
    
}

#pragma mark - 导航栏按钮
-(void)myNavigationItem{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"system_back"] style:UIBarButtonItemStyleDone target:self action:@selector(backTrack)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"share"] style:UIBarButtonItemStylePlain target:self action:@selector(backShare)];
    
}

-(void)backTrack{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)backShare{
    
}






#pragma mark - 按钮
//选课
- (IBAction)choiceClass:(UIButton *)sender {
    if (self.menuTableView.hidden) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(actionBarHidden) object:nil];
        CGRect  menuTable = self.menuTableView.frame;
        menuTable.origin.x = self.playerView.frame.size.width;
        self.menuTableView.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            CGRect menuTable = self.menuTableView.frame;
            menuTable.origin.x = self.playerView.frame.size.width - self.menuTableView.frame.size.width;
            self.menuTableView.frame = menuTable;
            
        }];
        
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            CGRect menuTable = self.menuTableView.frame;
            menuTable.origin.x = self.playerView.frame.size.width;
            self.menuTableView.frame = menuTable;
        } completion:^(BOOL finished) {
            self.menuTableView.hidden = YES;
        }];
    }
    
    
    
    
}
//横竖屏切换
- (IBAction)unfoldButClick:(id)sender {
    if (self.interfaceOrientation ==UIInterfaceOrientationPortrait) {
        [self forceRotate:UIInterfaceOrientationLandscapeRight];
    }else{
        [self forceRotate:UIInterfaceOrientationPortrait];
    }
    
}
-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    if (toInterfaceOrientation == UIInterfaceOrientationPortrait) {
        _nameView.hidden = YES;
        _menuTableView.hidden = YES;
        self.playerViewHeight.constant = 190;
        [self controllerHiddenShow:NO];
    }else{
        _nameView.hidden = NO;
        [self controllerHiddenShow:YES];
        self.playerViewHeight.constant = 320;
    }
    
    
}
#pragma mark - 隐藏显示导航栏
-(void)controllerHiddenShow:(BOOL)isBool{
    [[UIApplication sharedApplication] setStatusBarHidden:isBool];
    [self.navigationController setNavigationBarHidden:isBool];
    
}

#pragma mark 强制切换横竖屏
-(void)forceRotate:(UIInterfaceOrientation)orientation{
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        //包装方法
        SEL selector = NSSelectorFromString(@"setOrientation:");
        //直接调用某个对象的消息
        NSInvocation  * invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        //设置被调用的消息
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = orientation;
        [invocation setArgument:&val atIndex:2];
        //消息调用
        [invocation invoke];
    }
}

#pragma makr - touch
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //if (![self.courseComment.contentType isEqualToString:@"exam"]) {
        if (self.nameView.frame.origin.y<0) {
            //显示操作栏
            [self actionBarShow];
        }else{
            //隐藏错作栏
            [self actionBarHidden];
        }
    //}
}
#pragma mark - 显示操作栏
-(void)actionBarShow{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(actionBarHidden) object:nil];
    [UIView animateWithDuration:0.3 animations:^{
        CGRect   butView = _butView.frame;
        CGRect   nameView = _nameView.frame;
        butView.origin.y = _playerView.frame.size.height-70;
        nameView.origin.y = 0;
        _butView.frame = butView;
        _nameView.frame = nameView;
    }];
    [self performSelector:@selector(actionBarHidden) withObject:nil afterDelay:5];
}
#pragma mark - 隐藏操作栏
-(void)actionBarHidden{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect  butView = _butView.frame;
        CGRect  nameView = _nameView.frame;
        butView.origin.y = _playerView.frame.size.height;
        nameView.origin.y = -40;
        _butView.frame = butView;
        _nameView.frame = nameView;
    }];
    
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





















