//
//  IHFChatInputItem.m
//  IHFChat_PadDemo
//
//  Created by linhua hu on 16/9/29.
//  Copyright © 2016年 linhua hu. All rights reserved.
//

#import "MJChatInputItem.h"

@implementation MJChatInputItem



- (id)initWithSelectedIcon:(UIImage*)aUnSelectImg
{
    self = [super init];
    if (self) {
        _selectImage = [UIImage imageNamed:@"聊天-icon-文字键盘"];
        _unSelectImage = aUnSelectImg;
        [self setItemIsSelect:NO];
        self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    }
    return self;
}


- (void)setItemIsSelect:(BOOL)itemIsSelect
{
    _itemIsSelect = itemIsSelect;
    if (itemIsSelect) {
        [self setImage:_selectImage forState:normal];
    }else
    {
        [self setImage:_unSelectImage forState:normal];
    }
}


@end
