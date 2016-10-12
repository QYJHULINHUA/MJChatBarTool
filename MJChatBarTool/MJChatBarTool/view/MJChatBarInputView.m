//
//  MJChatBarInputView.m
//  MJChatBarTool
//
//  Created by linhua hu on 16/10/8.
//  Copyright © 2016年 linhua hu. All rights reserved.
//

#import "MJChatBarInputView.h"
#import "MJChatInputItem.h"




@interface MJChatBarInputView ()<MJChatInput_TextViewDelegate>

@property (nonatomic,strong)MJChatInputItem *recordAudioBarItem;

@property (nonatomic,strong)MJChatInputItem *emojiBarItem;

@property (nonatomic,strong)MJChatInputItem *openPanelBarItem;

@property (nonatomic,strong)MJChatInput_TextView *inputTextView;

@end

@implementation MJChatBarInputView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _barHeight = inputBarHeight;
        _actionType = MJChatInputBarActionType_None;
        [self initLineWith:frame];//初始化分割线
        [self initSubItemView:frame];//初始化录音按钮、聊天框、表情按钮、扩展按钮
        
    }
    return self;
}





/**
 * 初始化分割线
 */
- (void)initLineWith:(CGRect)frame
{
    UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 0.5)];
    topLine.backgroundColor = [MJChatBarToolModel colorFromHexString:@"d9d9d9"];
    [self addSubview:topLine];
    
    
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - 0.5, frame.size.width, 0.5)];
    bottomLine.backgroundColor = [MJChatBarToolModel colorFromHexString:@"d9d9d9"];
    [self addSubview:bottomLine];
    bottomLine.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    
    self.backgroundColor = [MJChatBarToolModel colorFromHexString:@"f3f3f3"];
}

/**
 * 初始化视图元素
 */
- (void)initSubItemView:(CGRect)frame
{
    CGFloat itemMargin = 5.f;
    CGFloat itemToBarMargin = 10.f;
    _recordAudioBarItem = [[MJChatInputItem alloc] initWithSelectedIcon:[UIImage imageNamed:@"聊天-icon-语音及切换键盘-灰"]];
    if ([MJChatBarToolModel iPhone6PlusDevice]) {
        
        _recordAudioBarItem.frame = CGRectMake(itemToBarMargin, 8,35, 35);
        
    }else{
        
        _recordAudioBarItem.frame = CGRectMake(itemToBarMargin, 0,35, 35);
        _recordAudioBarItem.center = CGPointMake(_recordAudioBarItem.center.x, 0.5*frame.size.height);
    }
    
    [self addSubview:_recordAudioBarItem];
    
    CGFloat ox = _recordAudioBarItem.frame.origin.x + _recordAudioBarItem.frame.size.width;
    _inputTextView = [[MJChatInput_TextView alloc] initWithFrame:CGRectMake(ox + itemMargin, 0, GJCFSystemScreenWidth - 35 * 3 - 2*itemToBarMargin - itemMargin * 3, 32)];
    _inputTextView.center = CGPointMake(_inputTextView.center.x, 0.5*frame.size.height);
    _inputTextView.inputBackgroundImage = [UIImage imageNamed:@"输入框-白色"];
    [_inputTextView setRecordAudioBackgroundImage:[UIImage imageNamed:@"输入框-灰色"]];
    [_inputTextView setPreRecordTitle:@"按住说话"];
    [_inputTextView setRecordingTitle:@"松开结束"];
    _inputTextView.delegate = self;
    [self addSubview:_inputTextView];
    
    
    _emojiBarItem = [[MJChatInputItem alloc] initWithSelectedIcon:[UIImage imageNamed:@"聊天-icon-选择表情"]];
    _openPanelBarItem = [[MJChatInputItem alloc] initWithSelectedIcon:[UIImage imageNamed:@"聊天-icon-选择照片帖子"]];
    CGFloat ori_x = _inputTextView.frame.origin.x + _inputTextView.frame.size.width;
    CGFloat openItm_ox = GJCFSystemScreenWidth - 35 -itemToBarMargin;
    if ([MJChatBarToolModel iPhone6PlusDevice]) {
        _emojiBarItem.frame = CGRectMake(ori_x+ itemMargin, 8,35, 35);
        
        _openPanelBarItem.frame = CGRectMake(openItm_ox, 8,35, 35);
        
    }else{
        _emojiBarItem.frame = CGRectMake(ori_x+ itemMargin, 0,35, 35);
        _emojiBarItem.center = CGPointMake(_emojiBarItem.center.x, 0.5*frame.size.height);
        
        _openPanelBarItem.frame = CGRectMake(openItm_ox, 0,35, 35);
        _openPanelBarItem.center = CGPointMake(_openPanelBarItem.center.x, 0.5*frame.size.height);
    }
    
    [self addSubview:_emojiBarItem];
    [self addSubview:_openPanelBarItem];
    
    [_emojiBarItem addTarget:self action:@selector(itemChangeStatus:) forControlEvents:UIControlEventTouchUpInside];
    [_openPanelBarItem addTarget:self action:@selector(itemChangeStatus:) forControlEvents:UIControlEventTouchUpInside];
    [_recordAudioBarItem addTarget:self action:@selector(itemChangeStatus:) forControlEvents:UIControlEventTouchUpInside];
    
}


- (void)chatInputStyle:(BOOL)isRecordState
{
    if (isRecordState) {
        [self setCurrentActionType:MJChatInputBarActionType_Audio];
    }else
    {
        [self setCurrentActionType:MJChatInputBarActionType_Text];
    }
}

- (void)recordActionCallBack:(MJChatRecordState)recordState
{
    
}

- (void)sendMsg:(id)msgContent isRecordState:(BOOL)isRecord
{
    
}

- (void)changeHeight:(CGFloat)changeH
{
    CGFloat temH = inputBarHeight - 32.f;
    _barHeight = changeH + temH;
    if ([self.delegate respondsToSelector:@selector(chatBarFrameChage)]) {
        [self.delegate chatBarFrameChage];
    }
}

-(CGFloat)barHeight
{
    if (_barHeight < inputBarHeight) {
        return inputBarHeight;
    }else
    {
        return _barHeight;
    }
}

- (void)itemChangeStatus:(MJChatInputItem *)item
{
    item.itemIsSelect = !item.itemIsSelect;
    if (item == _recordAudioBarItem) {
        _emojiBarItem.itemIsSelect = NO;
        _openPanelBarItem.itemIsSelect = NO;
        if (item.itemIsSelect) {
            [self setCurrentActionType:MJChatInputBarActionType_Audio];
            _inputTextView.recordState = YES;
            
        }else
        {
            [self setCurrentActionType:MJChatInputBarActionType_Text];
            _inputTextView.recordState = NO;
        }
    }
    else if (item == _emojiBarItem)
    {
        _recordAudioBarItem.itemIsSelect = NO;
        _openPanelBarItem.itemIsSelect = NO;
        if (item.itemIsSelect) {
            [self setCurrentActionType:MJChatInputBarActionType_Emoji];
            [_inputTextView resignInputTextView];
        }else
        {
            [self setCurrentActionType:MJChatInputBarActionType_Text];
            _inputTextView.recordState = NO;
        }
    }
    else if (item == _openPanelBarItem)
    {
        _recordAudioBarItem.itemIsSelect = NO;
        _emojiBarItem.itemIsSelect = NO;
        if (item.itemIsSelect) {
            [self setCurrentActionType:MJChatInputBarActionType_Panel];
            [_inputTextView resignInputTextView];
        }else
        {
            [self setCurrentActionType:MJChatInputBarActionType_Text];
            _inputTextView.recordState = NO;
        }
    }
}

- (void)setCurrentActionType:(MJChatBarActionType)actionType
{
    _actionType = actionType;
    if ([self.delegate respondsToSelector:@selector(changeActionType:)]) {
        [self.delegate changeActionType:_actionType];
    }
}

- (void)cancleInputState
{
    switch (_actionType) {
        case MJChatInputBarActionType_None:
            return ;
            break;
            
        case MJChatInputBarActionType_Audio:
            return ;
            break;
            
        case MJChatInputBarActionType_Text:
            [_inputTextView resignInputTextView];
            break;
            
        case MJChatInputBarActionType_Emoji:
            NSLog(@"a");
            break;
            
        case MJChatInputBarActionType_Panel:
            NSLog(@"a");
            break;
            
        default:
            break;
    }
    [self setCurrentActionType:MJChatInputBarActionType_None];
}


@end
