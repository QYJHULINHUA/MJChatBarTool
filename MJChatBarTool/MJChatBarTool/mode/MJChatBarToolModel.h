//
//  MJChatBarToolModel.h
//  MJChatBarTool
//
//  Created by linhua hu on 16/10/8.
//  Copyright © 2016年 linhua hu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger ,MJChatRecordState)
{
    MJChatRecordStateStart, /* 开始录音 */
    MJChatRecordStateCancle, /* 取消录音 */
    MJChatRecordStateFinsh, /* 完成录音 */
    MJChatRecordStateTooShort, /* 时间太短了录音 */
};

// 聊天输入栏状态
typedef NS_ENUM(NSUInteger ,MJChatBarActionType)
{
    MJChatInputBarActionType_None,
    MJChatInputBarActionType_Audio,  //语音
    MJChatInputBarActionType_Text,   //文本
    MJChatInputBarActionType_Emoji,  //表情
    MJChatInputBarActionType_Panel,  //扩展
};

typedef NS_ENUM(NSUInteger, MJChatInputExpandEmojiType) {
    
    MJCChatInputExpandEmojiTypeSimple = 0, // 简单表情
    
    MJCChatInputExpandEmojiTypeGIF = 1, // GIF表情
    
    MJCChatInputExpandEmojiTypeMyFavorit = 2,//收藏的表情

    MJCChatInputExpandEmojiTypeFindFunGif = 3,//去网络添加搞笑表情
};


#define GJCFQuickRGBColor(redValue,greenValue,blueValue) [UIColor colorWithRed:redValue/255.f green:greenValue/255.f blue:blueValue/255.f alpha:1]

#define GJCFSystemNavigationBarHeight 44.f //navigationBar 的高度

#define GJCFSystemOriginYDelta 20.f // Y轴增量

#define GJCFSystemScreenWidth [UIScreen mainScreen].bounds.size.width //获取屏幕的宽度
#define GJCFSystemScreenHeight [UIScreen mainScreen].bounds.size.height //获取屏幕的高度


@interface MJChatBarToolModel : NSObject

+ (UIColor *)mainBackgroundColor;
+ (UIColor *)colorFromHexString:(NSString *)hexString;
+ (BOOL)iPhone4Device;
+ (BOOL)iPhone5Device;
+ (BOOL)iPhone6Device;
+ (BOOL)iPhone6PlusDevice;
+ (BOOL)stringIsAllWhiteSpace:(NSString *)string;//检查字符串是否是空格
+ (UIImage *)imageForColor:(UIColor*)aColor withSize:(CGSize)aSize;//根据颜色绘制图片

+ (BOOL)stringIsNull:(NSString *)string;

+ (NSString *)mainBundlePath:(NSString*)fileName;

@end
