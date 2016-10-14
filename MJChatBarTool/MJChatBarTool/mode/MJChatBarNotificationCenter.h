//
//  MJChatBarNotificationCenter.h
//  MJChatBarTool
//
//  Created by linhua hu on 16/10/14.
//  Copyright © 2016年 linhua hu. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const MJChatBarRecordSoundNoti;
extern NSString *const MJChatBarEmojiSambleNoti;
extern NSString *const MJChatBarEmojiGifNoti;
extern NSString *const MJChatBarEmojiTextfNoti;
extern NSString *const MJChatBarEmojiSendfNoti;

#define MJNotificationPostObj(noti,object,infoDict) [MJChatBarNotificationCenter postNoti:noti withObject:object withUserInfo:infoDict]

@interface MJChatBarNotificationCenter : NSObject

+ (NSString *)getNofitName:(NSString *)nofiTypeString formateWihtIndentifier:(NSString *)indentifi;

+ (void)postNoti:(NSString *)notiName withObject:(id)obj withUserInfo:(NSDictionary *)infoDict;



@end
