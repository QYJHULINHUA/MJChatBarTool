//
//  MJChatEmojiBar.h
//  MJChatBarTool
//
//  Created by linhua hu on 16/10/13.
//  Copyright © 2016年 linhua hu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MJChatBarToolModel.h"

@protocol  MJChatEmojiBardelegate <NSObject>

- (void)loadEmojisWithSourceItem;

@end

@interface MJEmogjiStyleModel : NSObject

@property (nonatomic , strong)NSString *emojiIconName;//表情图标

@property (nonatomic , assign)MJChatInputExpandEmojiType emojiType;

@property (nonatomic , assign)BOOL isNeedShowSendButton;//是否显示发送按钮

@property (nonatomic, strong)NSString *emojiListFilePath;

@property (nonatomic, strong)NSArray *emojiArr;



@end

@interface MJChatEmojiBar : UIView

@property (nonatomic, assign)NSInteger seletedIndex;

@property (nonatomic,strong)NSArray *itemSourceArray;

@property (nonatomic ,strong , readonly)MJEmogjiStyleModel *emojiModel;

@property (nonatomic , weak)id<MJChatEmojiBardelegate>delegate;

@end
