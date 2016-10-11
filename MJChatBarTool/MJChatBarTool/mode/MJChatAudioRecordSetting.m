//
//  MJChatAudioRecordSetting.m
//  MJChatBarTool
//
//  Created by linhua hu on 16/10/10.
//  Copyright © 2016年 linhua hu. All rights reserved.
//

#import "MJChatAudioRecordSetting.h"
#import <AVFoundation/AVFoundation.h>

@implementation MJChatAudioRecordSetting

- (id)initWithSampleRate:(CGFloat)rate
             withFormate:(NSInteger)formateID
            withBitDepth:(NSInteger)bitDepth
            withChannels:(NSInteger)channels
            withPCMIsBig:(BOOL)isBig
          withPCMIsFloat:(BOOL)isFloat
             withQuality:(NSInteger)quality
{
    if (self = [super init]) {
        
        self.sampleRate = rate;
        self.Formate = formateID;
        self.LinearPCMBitDepth = bitDepth;
        self.numberOfChnnels = channels;
        self.LinearPCMIsBigEndian = isBig;
        self.LinearPCMIsFloat = isFloat;
        self.EncoderAudioQuality = quality;
    }
    return self;
}

+ (instancetype)defaultQualitySetting
{
    MJChatAudioRecordSetting *settings = [[self alloc]initWithSampleRate:8000.0f withFormate:kAudioFormatLinearPCM withBitDepth:16 withChannels:1 withPCMIsBig:NO withPCMIsFloat:NO withQuality:AVAudioQualityMedium];
    
    return settings;
}

+ (instancetype)lowQualitySetting
{
    MJChatAudioRecordSetting *settings = [[self alloc]initWithSampleRate:8000.0f withFormate:kAudioFormatLinearPCM withBitDepth:16 withChannels:1 withPCMIsBig:NO withPCMIsFloat:NO withQuality:AVAudioQualityLow];
    
    return settings;
}

+ (instancetype)highQualitySetting
{
    MJChatAudioRecordSetting *settings = [[self alloc]initWithSampleRate:8000.0f withFormate:kAudioFormatLinearPCM withBitDepth:16 withChannels:1 withPCMIsBig:NO withPCMIsFloat:NO withQuality:AVAudioQualityHigh];
    
    return settings;
}

+ (instancetype)MaxQualitySetting
{
    MJChatAudioRecordSetting *settings = [[self alloc]initWithSampleRate:8000.0f withFormate:kAudioFormatLinearPCM withBitDepth:16 withChannels:1 withPCMIsBig:NO withPCMIsFloat:NO withQuality:AVAudioQualityMax];
    
    return settings;
}

- (NSDictionary *)settingDict
{
    NSDictionary *aSettingDict = @{
                                   AVSampleRateKey: @(self.sampleRate),
                                   AVFormatIDKey:@(self.Formate),
                                   AVLinearPCMBitDepthKey:@(self.LinearPCMBitDepth),
                                   AVNumberOfChannelsKey:@(self.numberOfChnnels),
                                   AVLinearPCMIsBigEndianKey:@(self.LinearPCMIsBigEndian),
                                   AVLinearPCMIsFloatKey:@(self.LinearPCMIsFloat),
                                   AVEncoderAudioQualityKey:@(self.EncoderAudioQuality)
                                   
                                   };
    
    return aSettingDict;
}
@end
