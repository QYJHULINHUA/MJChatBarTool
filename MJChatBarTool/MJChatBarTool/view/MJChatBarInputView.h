//
//  MJChatBarInputView.h
//  MJChatBarTool
//
//  Created by linhua hu on 16/10/8.
//  Copyright © 2016年 linhua hu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJChatInput_TextView.h"

#define inputBarHeight 50.f //输入框的高度

@protocol MJChatBarInputViewDelegate <NSObject>

- (void)chatBarFrameChage;
- (void)changeActionType:(MJChatBarActionType)type;

@end

@interface MJChatBarInputView : UIView

@property (nonatomic , copy)NSString *indentifiName;//唯一标识

@property (nonatomic , assign)CGFloat barHeight;

@property (nonatomic , assign)MJChatBarActionType actionType;//当前输入框类型

@property (nonatomic , weak)id<MJChatBarInputViewDelegate>delegate;

- (void)cancleInputState;

@end
