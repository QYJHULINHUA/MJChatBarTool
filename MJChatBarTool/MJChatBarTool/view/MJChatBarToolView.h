//
//  MJChatBarToolView.h
//  MJChatBarTool
//
//  Created by linhua hu on 16/10/8.
//  Copyright © 2016年 linhua hu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJChatBarInputView.h"
#import "MJChatAudioRecordModel.h"

typedef NS_ENUM(NSUInteger ,MJChatBarMsgType)
{
    MJChatBarMsgType_None,
    MJChatBarMsgType_Audio,  //语音
    MJChatBarMsgType_Text,   //文本
    MJChatBarMsgType_GIFEmoji,  //gif表情
    MJChatBarMsgType_Panel,  //扩展
};

@protocol MJChatBarToolViewDelegate <NSObject>

- (void)chatBarToolViewChangeFrame:(CGRect)frame;

/**
 * msgStyle <== MJChatBarMsgType_GIFEmoji,   context <== NSString;
 * msgStyle <== MJChatBarMsgType_Audio,   context    <== MJChatAudioRecordModel;
 * msgStyle <== MJChatBarMsgType_Text,    context    <== NSString;
 */
- (void)msgType:(MJChatBarMsgType)msgStyle msgBody:(id)context;

@end

@interface MJChatBarToolView : UIView

@property (nonatomic , assign ,readonly)CGFloat barToolHeight; //自身高度

@property (nonatomic , weak)id<MJChatBarToolViewDelegate>delegate;

- (void)cancleInputState;//取消任何形式的输入状态

@property (nonatomic , copy)NSString *indentifiName;//唯一标识



@end
