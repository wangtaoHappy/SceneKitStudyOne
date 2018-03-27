//
//  WTMusicPlayNode.m
//  SceneKitStudyOne
//
//  Created by 王涛 on 2018/3/27.
//  Copyright © 2018年 王涛. All rights reserved.
//

#import "WTMusicPlayNode.h"
#import <AVFoundation/AVFoundation.h>

@interface WTMusicPlayNode()<AVAudioPlayerDelegate>
@property (nonatomic, strong) NSString *musicPathString;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic, strong) SCNAction  *rotateAction;
@end

@implementation WTMusicPlayNode

- (instancetype)initWithMusicPathString:(NSString *)musicPathString
{
    self = [super init];
    if (self) {
        _musicPathString = musicPathString;
        [self initialize];
    }
    return self;
}

- (void)initialize {
    NSError *error;
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:_musicPathString] error:&error];
    _audioPlayer.delegate = self;
    _audioPlayer.numberOfLoops = 0;
    SCNMaterial *material = [SCNMaterial material];
    material.diffuse.contents = _audioPlayer;
    SCNPlane *plan = [SCNPlane planeWithWidth:2 height:2];
    [plan insertMaterial:material atIndex:1];
    plan.firstMaterial.diffuse.contents = [UIImage imageNamed:@"music"];
    self.geometry = plan;
    if (_audioPlayer) {
        [_audioPlayer prepareToPlay];
    }
}

- (void)play {
    [_audioPlayer play];
    [self runAction:[SCNAction repeatActionForever:self.rotateAction] forKey:@"rotateKey"];
}

- (void)pause {
    [_audioPlayer pause];
    [self removeActionForKey:@"rotateKey"];
}

- (void)stop {
    [_audioPlayer stop];
}

- (BOOL)isPlaying {
    return _audioPlayer.isPlaying;
}

- (SCNAction *)rotateAction {
    if (!_rotateAction) {
        _rotateAction = [SCNAction rotateByX:0 y:0 z:1 duration:2];
    }
    return _rotateAction;
}

#pragma mark - AVAudioPlayerDelegate

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    if (flag) {
        [self removeActionForKey:@"rotateKey"];
    }
}

@end
