//
//  MJChatAudioRecordModel.m
//  MJChatBarTool
//
//  Created by linhua hu on 16/10/10.
//  Copyright © 2016年 linhua hu. All rights reserved.
//

#import "MJChatAudioRecordModel.h"

@implementation MJChatAudioRecordModel

- (id)init
{
    if (self = [super init]) {
    
        _uniqueIdentifier = [self currentTimeStamp];
        /* 设定默认文件后缀 */
        self.extensionName = @"wav";
        self.tempEncodeFileExtensionName = @"amr";
        self.mimeType = @"audio/amr";
    }
    return self;
}


- (NSString *)fileName
{
    if (!_fileName) {
        _fileName = [NSString stringWithFormat:@"%@.wav",[self currentTimeStamp]];
    }
    return _fileName;
}

- (NSString *)localFilePath
{
    if (!_localFilePath) {
        NSArray *pathCommponets = @[[self cacheDirectory],self.fileName];
        _localFilePath = [NSString pathWithComponents:pathCommponets];
    }
    return _localFilePath;
}

- (NSString *)cacheDirectory
{
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSArray *pathCommponets = @[cachePath,@"chat",@"record"];
    NSString *patha = [NSString pathWithComponents:pathCommponets];
    [self CreatFileDirectoryForPath:patha];
    return patha;
    
    
}

- (BOOL)CreatFileDirectoryForPath:(NSString *)dirPath
{
    if(![self isExistsForTargetFile:dirPath]) {
        @autoreleasepool {
            BOOL res=[[NSFileManager defaultManager] createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
            if (res == NO) {
                NSLog(@" 文件创建失败");
            }
            return res;
        }
    }
    else return YES;
}

- (BOOL)isExistsForTargetFile:(NSString*)fileName
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isFilePath = [fileManager fileExistsAtPath:fileName];
    if (!isFilePath) {
        //        NSLog(@"文件不存在");
        return NO;
    }
    else
    {
        return YES;
    }
}

- (NSString *)currentTimeStamp
{
    NSDate *now = [NSDate date];
    NSTimeInterval timeInterval = [now timeIntervalSinceReferenceDate];
    
    NSString *timeString = [NSString stringWithFormat:@"%1.f",timeInterval];
    
    return timeString;
}

/* 删除本地wav格式文件 */
- (void)deleteWavFile
{
    [self deleteTempEncodeFileWithPath:_localFilePath];
}

- (BOOL)deleteTempEncodeFileWithPath:(NSString *)tempEncodeFilePath
{
    if (!tempEncodeFilePath || [tempEncodeFilePath isEqualToString:@""]) {
        return YES;
    }
    
    if (![[NSFileManager defaultManager]fileExistsAtPath:tempEncodeFilePath]) {
        return YES;
    }
    
    NSError *deleteError = nil;
    [[NSFileManager defaultManager] removeItemAtPath:tempEncodeFilePath error:&deleteError];
    
    if (deleteError) {
        
        NSLog(@"GJCFFileUitil 删除文件失败:%@",deleteError);
        
        return NO;
        
    }else{
        
        NSLog(@"GJCFFileUitil 删除文件成功:%@",tempEncodeFilePath);
        return YES;
    }
}

@end
