//
//  WXPlayer.h
//  AFNetworking
//
//  Created by 郑江荣 on 2019/1/12.
//

#import "WXComponent.h"
#import "SPVideoPlayerView.h"
#import <WeexSDK/WXEventModuleProtocol.h>
#import <WeexSDK/WXModuleProtocol.h>


NS_ASSUME_NONNULL_BEGIN

@interface WXZPlayer : WXComponent<WXModuleProtocol>
//@property(strong,nonatomic) MCPlayerKit *playerKit;
@property(strong,nonatomic) NSString *src;
@property(strong,nonatomic) NSString *title;
@property(strong,nonatomic)  SPVideoPlayerView *video;

@property(nonatomic) BOOL autoPlay;

@end

NS_ASSUME_NONNULL_END
