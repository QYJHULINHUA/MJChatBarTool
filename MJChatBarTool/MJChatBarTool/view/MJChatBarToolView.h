//
//  MJChatBarToolView.h
//  MJChatBarTool
//
//  Created by linhua hu on 16/10/8.
//  Copyright © 2016年 linhua hu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJChatBarInputView.h"

@protocol MJChatBarToolViewDelegate <NSObject>

- (void)chatBarToolViewChangeFrame:(CGRect)frame;

@end

@interface MJChatBarToolView : UIView

@property (nonatomic , assign ,readonly)CGFloat barToolHeight; //自身高度

@property (nonatomic , weak)id<MJChatBarToolViewDelegate>delegate;

- (void)cancleInputState;//取消任何形式的输入状态



@end
