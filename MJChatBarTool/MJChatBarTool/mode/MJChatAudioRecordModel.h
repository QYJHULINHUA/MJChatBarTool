//
//  MJChatAudioRecordModel.h
//  MJChatBarTool
//
//  Created by linhua hu on 16/10/10.
//  Copyright © 2016年 linhua hu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MJChatAudioRecordModel : NSObject

@property (nonatomic, copy, readonly)NSString *uniqueIdentifier;//录音文件的唯一标识

@property (nonatomic, assign)NSTimeInterval duartion;//录音文件时长

@property (nonatomic,assign)NSTimeInterval limitRecordDuration;/* 限制录音时长 */

@property (nonatomic,assign)NSTimeInterval limitPlayDuration;/* 限制播放时长 */

@property (nonatomic,readonly)CGFloat dataSize;/* wav文件大小 */

@property (nonatomic,strong)NSDictionary *userInfo;/* 用户自定义信息 */

@property (nonatomic,strong)NSString *mimeType;/* 多媒体文件类型 */

/* 文件扩展名 */
@property (nonatomic,strong)NSString *extensionName;

/* 临时转编码文件的扩展名 */
@property (nonatomic,strong)NSString *tempEncodeFileExtensionName;




@property (nonatomic,strong)NSString *fileName;/* 文件名 */

@property (nonatomic, strong)NSString *localFilePath;//本地录音文件夹路径


//@property (nonatomic,copy)NSString *cacheFileName;/* 缓存文件名字 */

//@property (nonatomic, strong)NSString *webRemotePath;//远程服务器录音文件路径 nullable

/* 删除临时编码文件 */
//- (void)deleteTempEncodeFile;

/* 删除本地wav格式文件 */
- (void)deleteWavFile;



@end
