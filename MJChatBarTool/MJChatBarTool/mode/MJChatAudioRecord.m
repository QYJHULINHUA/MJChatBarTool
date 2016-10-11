//
//  MJChatAudioRecord.m
//  MJChatBarTool
//
//  Created by linhua hu on 16/10/10.
//  Copyright © 2016年 linhua hu. All rights reserved.
//

#import "MJChatAudioRecord.h"
#import "MJChatAudioRecordSetting.h"
#import "MJChatAudioRecordModel.h"
#import <AVFoundation/AVFoundation.h>

@interface MJChatAudioRecord ()<AVAudioRecorderDelegate>
{
    MJChatAudioRecordSetting *audioRecordSetting;
    MJChatAudioRecordModel   *audioRecordModel;
    NSTimer *soundMouterTimer;
    AVAudioRecorder *audioRecord;
}

@end


@implementation MJChatAudioRecord

- (id)init
{
    self = [super init];
    if (self) {
        _minEffectDuration = 1.f;
    }
    return self;
}


- (BOOL)startRecord
{
    _isRecording = [self createRecord];
    if (!_isRecording) {
        return NO;
    }else
    {
        if (_limitRecordDuration > 0) {
            _isRecording = [audioRecord recordForDuration:_limitRecordDuration];
            if (!_isRecording) {
                // 录音失败
                NSLog(@"GJCFAudioRecord Limit start error....");
                return NO;
            }
        }
        _isRecording = [audioRecord record];
        if (!_isRecording) {
            //开启录音失败
            NSLog(@"GJCFAudioRecord start error....");
            return NO;
        }else
        {
            return YES;
        }
    }
    
}
- (BOOL)finshishRecord
{
    if ([audioRecord isRecording]) {
        [audioRecord stop];
        _isRecording = NO;
    }
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    NSError *err = nil;
    [audioSession setCategory:AVAudioSessionCategoryAmbient error:&err];
    [audioSession setActive:NO error:&err];
    [self soundMouterTimeInvalidate];
   return YES;
}
- (void)cancleRecord
{
    if (!audioRecord) {
        return;
    }
    if (!_isRecording) {
        return;
    }
    [audioRecord stop];
    _isRecording = NO;
    [audioRecord deleteRecording];
    [self soundMouterTimeInvalidate];
    
}

- (BOOL)createRecord
{
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    NSError *err = nil;
    [audioSession setCategory:AVAudioSessionCategoryRecord error:&err];
    
    if (err) {
        //创建audioSession 失败
        NSLog(@"GJCFAudioRecord audioSession: %@ %ld %@", [err domain], (long)[err code], [[err userInfo] description]);
        return NO;
    }
    [audioSession setActive:YES error:&err];
    if (err) {
        // 启用失败
        NSLog(@"GJCFAudioRecord audioSession: %@ %ld %@", [err domain], (long)[err code], [[err userInfo] description]);
        return NO;
    }
    if (!audioRecordSetting) {
        audioRecordSetting = [MJChatAudioRecordSetting defaultQualitySetting];
    }
    if (audioRecordModel) {
        audioRecordModel = nil;
    }
    [self soundMouterTimeInvalidate];
    audioRecordModel = [[MJChatAudioRecordModel alloc] init];
    
    if (audioRecord) {
        if (audioRecord.isRecording) {
            [audioRecord stop];
            [audioRecord deleteRecording];
        }
        audioRecord = nil;
    }
    if (!audioRecordModel.localFilePath) {
        // 没有录音文件的路径
        NSLog(@"GJCFAudioRecord Create Error No cache path");
        return NO;
    }
    
    // 创建新的录音实例
    NSError *creatRecordError = nil;
    audioRecord = [[AVAudioRecorder alloc] initWithURL:[NSURL URLWithString:audioRecordModel.localFilePath] settings:audioRecordSetting.settingDict error:&creatRecordError];
    audioRecord.meteringEnabled = YES;
    audioRecord.delegate = self;
    
    if (creatRecordError) {
        // 创建录音实例失败
        NSLog(@"GJCFAudioRecord Create AVAudioRecorder Error:%@",creatRecordError);
        return NO;
    }
    [audioRecord prepareToRecord];
    
    /* 创建输入音量更新 */
    soundMouterTimer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(updateSoundMouter:) userInfo:nil repeats:YES];
    [soundMouterTimer fire];
    
    return YES;
}

- (void)updateSoundMouter:(NSTimer *)timer
{
//    if (!audioRecord) return;
//    [audioRecord updateMeters];
    
    
}

#pragma mark - AVAudioRecorderDelegate
- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
{
    
}

- (void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError *)error
{
    
}

- (void)audioRecorderBeginInterruption:(AVAudioRecorder *)recorder
{
    
}

- (void)audioRecorderEndInterruption:(AVAudioRecorder *)recorder withOptions:(NSUInteger)flags
{
    
}
- (MJChatAudioRecordModel*)getRecordAudioFile
{
    return audioRecordModel;
}

- (void)dealloc
{
    [self soundMouterTimeInvalidate];
}

- (void)soundMouterTimeInvalidate
{
    if (soundMouterTimer) {
        [soundMouterTimer invalidate];
        soundMouterTimer = nil;
    }
}

@end
