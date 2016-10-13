//
//  MJChatInput_TextView.h
//  MJChatBarTool
//
//  Created by linhua hu on 16/10/8.
//  Copyright © 2016年 linhua hu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJChatBarToolModel.h"
#import "MJChatAudioRecord.h"


@protocol MJChatInput_TextViewDelegate <NSObject>

- (void)chatInputStyle:(BOOL)isRecordState;
- (void)changeHeight:(CGFloat)changeH;
- (void)sendMsg:(id)msgContent isRecordState:(BOOL)isRecord;
- (void)recordActionCallBack:(MJChatRecordState)recordState;


@end

@interface MJChatInput_TextView : UIView

@property (nonatomic , strong)MJChatAudioRecord *audioRecord;

@property (nonatomic , strong)NSString *preRecordTitle;//准备录音时候的标题

@property (nonatomic , strong)NSString *recordingTitle;//正在录音时候的标题

@property (nonatomic , strong)UIImage *inputBackgroundImage;//输入文本时候的背景

@property (nonatomic , strong)UIImage *recordAudioBackgroundImage;//输入语言时候的背景

@property (nonatomic , assign)CGFloat autoExpandHeight;//自动伸展高度，用于文字输入，textview的高度变化

/**
 *  是否录音输入状态
 */
@property (nonatomic,assign)BOOL recordState;

@property (nonatomic,weak)id<MJChatInput_TextViewDelegate>delegate;

- (void)resignInputTextView;//注销第一响应

- (void)hiddenRecordButton;




@end
