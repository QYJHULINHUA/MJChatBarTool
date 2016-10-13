//
//  MJChatEmojiBar.m
//  MJChatBarTool
//
//  Created by linhua hu on 16/10/13.
//  Copyright © 2016年 linhua hu. All rights reserved.
//

#import "MJChatEmojiBar.h"

@implementation MJEmogjiStyleModel



@end

@implementation MJChatEmojiBar

- (id)init
{
    self = [super init];
    if (self) {
        CGFloat w = 62*self.itemSourceArray.count;
        CGFloat h = 40.5;
        self.frame = CGRectMake(0, 0, w, h);
        _seletedIndex = 0;
        [self setupSubViewsWithSourceArray:self.itemSourceArray];
    }
    return self;
}

- (void)setupSubViewsWithSourceArray:(NSArray *)sourceArray
{
    CGFloat itemWidth = 62;
    CGFloat itemHeight = self.frame.size.height - 10;
    
    for (NSInteger index = 0; index < sourceArray.count; index ++) {
        
        CGFloat marginX = index * itemWidth;
        CGFloat marginY = 5;
        
        MJEmogjiStyleModel *sourceItem = [sourceArray objectAtIndex:index];
        UIButton *item = [[UIButton alloc] initWithFrame:CGRectMake(marginX, marginY, itemWidth, itemHeight)];
        [item setImage:[UIImage imageNamed:sourceItem.emojiIconName] forState:normal];
        item.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:item];
        [item addTarget:self action:@selector(tapOnBarItem:) forControlEvents:UIControlEventTouchUpInside];
    }
}
- (MJEmogjiStyleModel*)emojiModel
{
    if (_seletedIndex > self.itemSourceArray.count - 1) {
        return nil;
    }else
    {
        MJEmogjiStyleModel *model = self.itemSourceArray[_seletedIndex];
        return model;
    }
    
}


- (void)tapOnBarItem:(UIButton *)tapR
{
    
    
}

- (NSArray*)itemSourceArray
{
    if (!_itemSourceArray) {
        MJEmogjiStyleModel *item1 = [self simpleEmojiItem];//一般表情
        MJEmogjiStyleModel *item2 = [self gifEmojiItem];//gjf表情
        _itemSourceArray = @[item1,item2];
    }
    return _itemSourceArray;
}

- (MJEmogjiStyleModel*)simpleEmojiItem
{
    MJEmogjiStyleModel *item = [MJEmogjiStyleModel new];
    item.emojiType = MJCChatInputExpandEmojiTypeSimple;
    item.emojiListFilePath = [MJChatBarToolModel mainBundlePath:@"emoji.plist"];
    item.emojiIconName = @"005[微笑]";
    item.isNeedShowSendButton = YES;
    
    return item;
}

- (MJEmogjiStyleModel*)gifEmojiItem
{
    MJEmogjiStyleModel *item = [[MJEmogjiStyleModel alloc]init];
    
    item.emojiType = MJCChatInputExpandEmojiTypeGIF;
    item.emojiListFilePath = [MJChatBarToolModel mainBundlePath:@"gifEmoji.plist"];
    item.emojiIconName = @"抠鼻";
    item.isNeedShowSendButton = NO;
    
    return item;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
