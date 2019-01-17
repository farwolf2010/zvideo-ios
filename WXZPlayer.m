//
//  WXPlayer.m
//  AFNetworking
//
//  Created by 郑江荣 on 2019/1/12.
//

#import "WXZPlayer.h"
#import <WeexPluginLoader/WeexPluginLoader.h>
#import <Masonry/Masonry.h>
#import "SPVideoPlayerView.h"
#import "SPVideoPlayerControlView.h"


@implementation WXZPlayer
@synthesize weexInstance;
WX_PlUGIN_EXPORT_COMPONENT(player, WXZPlayer)
WX_EXPORT_METHOD(@selector(play))
WX_EXPORT_METHOD(@selector(pause))
WX_EXPORT_METHOD(@selector(toggleFullScreen))

- (instancetype)initWithRef:(NSString *)ref type:(NSString *)type styles:(NSDictionary *)styles attributes:(NSDictionary *)attributes events:(NSArray *)events weexInstance:(WXSDKInstance *)weexInstance
{
  
    self = [super initWithRef:ref type:type styles:styles attributes:attributes events:events weexInstance:weexInstance];
    _src = attributes[@"src"];
    _title = attributes[@"title"];
    _autoPlay = [attributes[@"autoPlay"] boolValue];
    
    return self;
}
-(UIView*)loadView{
    UIView *v=[UIView new];
    v.backgroundColor=[UIColor blackColor];
  
//    [v addSubview:video];
//    [video mas_makeConstraints:^(MASConstraintMaker *make) {
//         make.left.mas_equalTo(v);
//         make.right.mas_equalTo(v);
//         make.bottom.mas_equalTo(v);
//         make.top.mas_equalTo(v);
//    }];
    return v;
}
- (SPVideoItem *)videoItem {
    SPVideoItem *_videoItem=[SPVideoItem new];
   
        _videoItem                  = [[SPVideoItem alloc] init];
          _videoItem.title            = self.title;
        _videoItem.videoURL         = [NSURL URLWithString:self.src];
        _videoItem.placeholderImage = [UIImage imageNamed:@"qyplayer_aura2_background_normal_iphone_375x211_"];
        // playerView的父视图
        _videoItem.fatherView       = self.view;
    
    return _videoItem;
}


- (void)updateAttributes:(NSDictionary *)attributes{
    _src = attributes[@"src"];
    _title = attributes[@"title"];
    _autoPlay = [attributes[@"autoPlay"] boolValue];
    if(_src!=nil||_title!=nil){
        [_video removeFromSuperview];
        SPVideoPlayerView *video=[[SPVideoPlayerView alloc]init];
        _video=video;
        _video.requirePreviewView = NO;
        video.backgroundColor=[UIColor blackColor];
        [video configureControlView:nil videoItem:self.videoItem];
        if(_autoPlay){
            [video startPlay];
        }
    }
    
}

-(void)dealloc{

}

-(void)viewDidLoad{
    [super viewDidLoad];
    SPVideoPlayerView *video=[[SPVideoPlayerView alloc]init];
    _video=video;
     _video.requirePreviewView = NO;
    video.backgroundColor=[UIColor blackColor];
    [video configureControlView:nil videoItem:self.videoItem];
   
    if(_autoPlay){
          [video startPlay];
    }
   

    
}

 


-(void)play{
    if(_video.playState==SPVideoPlayerPlayStatePlaying){
        return;
    }
    if(_video.playState==SPVideoPlayerPlayStateEndedPlay){
        [_video sp_controlViewRefreshButtonClicked:nil];
        SPVideoPlayerControlView *control= _video.controlView;
        [control repeatButtonnAction:nil];
    
//        [self sp_playerResetControlView];
//        [self sp_playerShowControlView];
    }
    else if(_video.playState==SPVideoPlayerPlayStatePause){
        [_video play];
    }else{
        [_video startPlay];
    }
    
    
   
}
-(void)pause{
   [_video pause];
}
-(void)toggleFullScreen{
    [_video toggleFullScreen];
}



@end
