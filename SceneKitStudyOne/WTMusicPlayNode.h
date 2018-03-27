//
//  WTMusicPlayNode.h
//  SceneKitStudyOne
//
//  Created by 王涛 on 2018/3/27.
//  Copyright © 2018年 王涛. All rights reserved.
//

#import <SceneKit/SceneKit.h>

@interface WTMusicPlayNode : SCNNode

- (instancetype)initWithMusicPathString:(NSString *)musicPathString;

- (void)play;

- (void)pause;

- (void)stop;

- (BOOL)isPlaying;

@end
