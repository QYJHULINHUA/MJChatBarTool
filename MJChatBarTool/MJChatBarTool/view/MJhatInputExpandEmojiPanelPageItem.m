//
//  GJGCChatInputExpandEmojiPanelPageItem.m
//  ZYChat
//
//  Created by ZYVincent QQ:1003081775 on 14-11-26.
//  Copyright (c) 2014年 ZYProSoft. All rights reserved.
//

#import "MJhatInputExpandEmojiPanelPageItem.h"
#import "MJChatBarNotificationCenter.h"

#define GJCFSystemScreenWidth [UIScreen mainScreen].bounds.size.width //获取屏幕的宽度
#define GJCFSystemScreenHeight [UIScreen mainScreen].bounds.size.height //获取屏幕的高度

#define GJGCChatInputExpandEmojiPanelPageItemSubIconTag 3987652

@interface MJhatInputExpandEmojiPanelPageItem ()

@property (nonatomic,strong)NSMutableArray *emojiNamesArray;

@end

@implementation MJhatInputExpandEmojiPanelPageItem


- (instancetype)init
{
    if (self = [super init]) {
        
        [self initSubViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame withEmojiNameArray:(NSArray *)emojiArray;
{
    if (self = [super initWithFrame:frame]) {
        
        [self initSubViews];
        
        [self loadWithEmojiNames:emojiArray];
    }
    return self;
}

- (void)initSubViews
{
    NSInteger rowCount = 3;
    NSInteger cloumnCount = 7;
    CGFloat emojiWidth = 29;
    
    CGFloat emojiMarginX = (GJCFSystemScreenWidth - cloumnCount * emojiWidth)/(cloumnCount + 1);
    CGFloat emojiMarginY = (self.bounds.size.height - rowCount * emojiWidth)/(rowCount + 1);
    
    for (int i = 0; i < 21; i++) {
        
        NSInteger rowIndex = i/cloumnCount;
        NSInteger cloumnIndex = i%cloumnCount;
        
        UIButton *emojiView = [[UIButton alloc]init];
        emojiView.frame = CGRectMake((cloumnIndex+1)*emojiMarginX + cloumnIndex*emojiWidth, (rowIndex+1)*emojiMarginY + rowIndex*emojiWidth, emojiWidth, emojiWidth);
        emojiView.tag = GJGCChatInputExpandEmojiPanelPageItemSubIconTag + i;
        [emojiView addTarget:self action:@selector(tapOnEmojiButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:emojiView];

    }
    
    self.emojiNamesArray = [NSMutableArray array];
}

- (void)loadWithEmojiNames:(NSArray *)emojiNameArray
{
    [self.emojiNamesArray addObjectsFromArray:emojiNameArray];
    
    for (int i = 0; i < emojiNameArray.count ; i++) {
        
        UIButton *emojiView = (UIButton *)[self viewWithTag:GJGCChatInputExpandEmojiPanelPageItemSubIconTag + i];

        NSDictionary *emojiItem = [emojiNameArray objectAtIndex:i];
        
        NSString *emojiName = [NSString stringWithFormat:@"%@.png",[emojiItem.allValues firstObject]];
        [emojiView setBackgroundImage:[UIImage imageNamed:emojiName]  forState:UIControlStateNormal];
    }
    
    /* 隐藏没有的 */
    for (UIImageView *subItem in self.subviews) {
        
        if ((subItem.tag - GJGCChatInputExpandEmojiPanelPageItemSubIconTag) > (emojiNameArray.count -1)) {
            subItem.hidden = YES;
        }
    }
}

- (void)tapOnEmojiButton:(UIButton *)emojiButton
{
    NSInteger index = emojiButton.tag - GJGCChatInputExpandEmojiPanelPageItemSubIconTag;
    if (index > self.emojiNamesArray.count - 1) {
        return;
    }
    NSDictionary *item = [self.emojiNamesArray objectAtIndex:index];
    NSString *emoji = [[item allKeys]firstObject];
    NSString *notifiString = [MJChatBarNotificationCenter getNofitName:MJChatBarEmojiSambleNoti formateWihtIndentifier:self.indentifiName];
    MJNotificationPostObj(notifiString, emoji, nil);
}

@end
