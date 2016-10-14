//
//  MJChatBarNotificationCenter.m
//  MJChatBarTool
//
//  Created by linhua hu on 16/10/14.
//  Copyright © 2016年 linhua hu. All rights reserved.
//

#import "MJChatBarNotificationCenter.h"
#import "MJChatBarToolModel.h"

NSString *const MJChatBarRecordSoundNoti = @"MJChatBarRecordSoundNoti"; //发送语音通知
NSString *const MJChatBarEmojiSambleNoti = @"MJChatBarEmojiSambleNoti"; //发送简单表情通知
NSString *const MJChatBarEmojiGifNoti    = @"MJChatBarEmojiGifNoti";    //发送gif表情通知
NSString *const MJChatBarEmojiTextfNoti    = @"MJChatBarEmojiTextfNoti";    //发送text表情通知
NSString *const MJChatBarEmojiSendfNoti    = @"MJChatBarEmojiSendfNoti";    //点击发送按钮通知

@implementation MJChatBarNotificationCenter

+ (NSString *)getNofitName:(NSString *)nofiTypeString formateWihtIndentifier:(NSString *)indentifi
{
    if ([MJChatBarToolModel stringIsNull:nofiTypeString]) {
        return nil;
    }
    if ([MJChatBarToolModel stringIsNull:indentifi]) {
        return nil;
    }
    return [NSString stringWithFormat:@"%@__%@",nofiTypeString,indentifi];
    
}

+ (void)postNoti:(NSString *)notiName withObject:(id)obj withUserInfo:(NSDictionary *)infoDict
{
    if ([MJChatBarToolModel stringIsNull:notiName]) {
        return;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:notiName object:obj userInfo:infoDict];
}

@end
