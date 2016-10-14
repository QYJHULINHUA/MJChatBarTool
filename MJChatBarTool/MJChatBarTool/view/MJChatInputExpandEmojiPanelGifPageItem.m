//
//  GJGCChatInputExpandEmojiPanelGifPageItem.m
//  ZYChat
//
//  Created by ZYVincent QQ:1003081775 on 15/6/3.
//  Copyright (c) 2015年 ZYProSoft.  QQ群:219357847  All rights reserved.
//

#import "MJChatInputExpandEmojiPanelGifPageItem.h"
#import "MJChatBarNotificationCenter.h"

#define GJCFSystemScreenWidth [UIScreen mainScreen].bounds.size.width //获取屏幕的宽度
#define GJCFSystemScreenHeight [UIScreen mainScreen].bounds.size.height //获取屏幕的高度
#define GJGCChatInputExpandEmojiPanelPageItemSubIconTag 3987652

@interface MJChatInputExpandEmojiPanelGifPageItem ()


@property (nonatomic,strong)NSMutableArray *emojiNamesArray;


//@property (nonatomic,strong)NSTimer *touchTimer;

//@property (nonatomic,assign)BOOL isLongPress;

//@property (nonatomic,assign)CGPoint longPressPoint;

@end

@implementation MJChatInputExpandEmojiPanelGifPageItem

- (instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame withEmojiNameArray:(NSArray *)emojiArray
{
    if (self = [super initWithFrame:frame]) {
        [self initSubViewsWithEmojiNames:emojiArray];
    }
    
    return self;
}

- (void)initSubViewsWithEmojiNames:(NSArray *)emojiArray
{
    NSInteger rowCount = 2;
    NSInteger cloumnCount = 4;
    CGFloat emojiHeight = 69;
    CGFloat emojiWidth = GJCFSystemScreenWidth/4;
    
    CGFloat emojiMarginY = (self.bounds.size.height - rowCount * emojiHeight)/(rowCount + 1);
    
    for (int i = 0; i < emojiArray.count; i++) {
        
        NSInteger rowIndex = i/cloumnCount;
        NSInteger cloumnIndex = i%cloumnCount;
        
        NSString *iconName = [emojiArray objectAtIndex:i];
        UIButton *gifEmojiButton = [[UIButton alloc] initWithFrame:CGRectMake(cloumnIndex*emojiWidth, (rowIndex+1)*emojiMarginY + rowIndex*emojiHeight, emojiWidth, emojiHeight)];
        gifEmojiButton.titleLabel.text = iconName;
        [gifEmojiButton setImage:[UIImage imageNamed:iconName] forState:normal];
        [gifEmojiButton addTarget:self action:@selector(tapOnEmojiButton:) forControlEvents:UIControlEventTouchUpInside];
        gifEmojiButton.tag = GJGCChatInputExpandEmojiPanelPageItemSubIconTag + i;
        
        [self addSubview:gifEmojiButton];
        
    }
}

- (void)tapOnEmojiButton:(UIButton *)tapR
{
    NSString *emoji = tapR.titleLabel.text;
    NSString *notifiString = [MJChatBarNotificationCenter getNofitName:MJChatBarEmojiGifNoti formateWihtIndentifier:_panelIdentifier];
    MJNotificationPostObj(notifiString, emoji, nil);
}



@end
