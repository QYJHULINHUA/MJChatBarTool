//
//  MJChatAudioRecord.h
//  MJChatBarTool
//
//  Created by linhua hu on 16/10/10.
//  Copyright © 2016年 linhua hu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class MJChatAudioRecordModel;

@interface MJChatAudioRecord : NSObject

@property (nonatomic, assign, readonly)BOOL isRecording;//是否录音

@property (nonatomic,readonly)CGFloat soundMouter;//音值

@property (nonatomic,assign)NSTimeInterval limitRecordDuration;//设置最长录音时间长度

@property (nonatomic,assign)NSTimeInterval minEffectDuration;//设置最小有效录音时长，默认为1秒



- (BOOL)startRecord;
- (BOOL)finshishRecord;
- (void)cancleRecord;

- (MJChatAudioRecordModel*)getRecordAudioFile;//获得录制的音频文件

@end
