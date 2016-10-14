//
//  GJGCChatInputExpandEmojiPanelPageItem.h
//  ZYChat
//
//  Created by ZYVincent QQ:1003081775 on 14-11-26.
//  Copyright (c) 2014年 ZYProSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MJhatInputExpandEmojiPanelPageItem : UIView

@property (nonatomic , copy)NSString *indentifiName;//唯一标识

- (instancetype)initWithFrame:(CGRect)frame withEmojiNameArray:(NSArray *)emojiArray;


@end
