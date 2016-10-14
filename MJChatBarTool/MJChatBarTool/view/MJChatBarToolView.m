//
//  MJChatBarToolView.m
//  MJChatBarTool
//
//  Created by linhua hu on 16/10/8.
//  Copyright © 2016年 linhua hu. All rights reserved.
//

#import "MJChatBarToolView.h"
#import "MJChatEmojiView.h"
#import "MJChatBarNotificationCenter.h"


@interface MJChatBarToolView ()<MJChatBarInputViewDelegate>

@property (nonatomic ,strong)MJChatBarInputView *inputBar;
@property (nonatomic ,assign)CGFloat keyBoardHeight;
@property (nonatomic ,assign)CGFloat explangHeight;
@property (nonatomic,strong)MJChatEmojiView *emojiView;

@end

@implementation MJChatBarToolView

-(id)init
{
    self = [super init];
    if (self) {
        
        _inputBar = [[MJChatBarInputView alloc]initWithFrame:(CGRect){0,0,GJCFSystemScreenWidth,inputBarHeight}];
        _inputBar.delegate = self;
        [self addSubview:self.inputBar];
        [self regestObserver];//注册相关通知
        _indentifiName = [MJChatBarToolModel currentTimeStamp];
        _inputBar.indentifiName = _indentifiName;
        
        [self addObserverGifNoti];
        [self addObserverRecord];
        [self addObserverTextNoti];
        
    }
    return self;
}

//gif表情通知
- (void)addObserverGifNoti
{
    NSString *gifEmojiNoti = [MJChatBarNotificationCenter getNofitName:MJChatBarEmojiGifNoti formateWihtIndentifier:_indentifiName];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observeGIFEmojiPanelChooseEmojiNoti:) name:gifEmojiNoti object:nil];
}

//语音通知
- (void)addObserverRecord
{
    NSString *recodNoti = [MJChatBarNotificationCenter getNofitName:MJChatBarRecordSoundNoti formateWihtIndentifier:_indentifiName];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observerRecordNotif:) name:recodNoti object:nil];
}

//文本通知
- (void)addObserverTextNoti
{
    NSString *recodNoti = [MJChatBarNotificationCenter getNofitName:MJChatBarEmojiTextfNoti formateWihtIndentifier:_indentifiName];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observerTextNoti:) name:recodNoti object:nil];
}

- (void)observerTextNoti:(NSNotification *)noti
{
    NSString *strtt = noti.object;
    NSLog(@"文本通知->  %@",strtt);
    if ([self.delegate respondsToSelector:@selector(msgType:msgBody:)]) {
        [self.delegate msgType:MJChatBarMsgType_Text msgBody:strtt];
    }
}

- (void)observeGIFEmojiPanelChooseEmojiNoti:(NSNotification *)noti
{
    NSString *strtt = noti.object;
    if ([self.delegate respondsToSelector:@selector(msgType:msgBody:)]) {
        [self.delegate msgType:MJChatBarMsgType_GIFEmoji msgBody:strtt];
    }
}

- (void)observerRecordNotif:(NSNotification *)notif
{
    MJChatAudioRecordModel *model = notif.object;
    if ([self.delegate respondsToSelector:@selector(msgType:msgBody:)]) {
        [self.delegate msgType:MJChatBarMsgType_Audio msgBody:model];
    }
}

- (MJChatEmojiView*)emojiView
{
    if (!_emojiView) {
        _emojiView = [[MJChatEmojiView alloc] initWithFrame:CGRectMake(0, 0, GJCFSystemScreenWidth, 216)];
        _emojiView.hidden = YES;
        _emojiView.indentifiName = _indentifiName;
        [self addSubview:_emojiView];
        
    }
    _emojiView.frame = CGRectMake(0, _inputBar.barHeight, GJCFSystemScreenWidth, 216);
    return _emojiView;
}

- (void)chatBarFrameChage
{
    [UIView animateWithDuration:0.2f animations:^{
        [self layerBarFrame];
    }];
    
}

- (void)changeActionType:(MJChatBarActionType)type
{
    [UIView animateWithDuration:0.2f animations:^{
        [self layerBarFrame];
    }];
    if (type == MJChatInputBarActionType_Emoji) {
        self.emojiView.hidden = NO;
    }else
    {
         self.emojiView.hidden = YES;
    }
    
}

- (void)layerBarFrame
{
    CGFloat ori_x = 0;
    if (_keyBoardHeight > 0 && _explangHeight>0) {
        _keyBoardHeight = 0;
    }
    switch (_inputBar.actionType) {
        case MJChatInputBarActionType_None:
            _keyBoardHeight = 0;
            _explangHeight = 0;
            break;
            
        case MJChatInputBarActionType_Audio:
            _keyBoardHeight = 0;
            _explangHeight = 0;
            break;
            
        case MJChatInputBarActionType_Emoji:
            _keyBoardHeight = 0;
            _explangHeight = 216;
            break;
            
        case MJChatInputBarActionType_Text:
            _explangHeight = 0;
            break;
            
        case MJChatInputBarActionType_Panel:
            _keyBoardHeight = 0;
            _explangHeight = 216;
            break;
            
        default:
            break;
    }
    
    CGFloat ori_y = GJCFSystemScreenHeight - self.barToolHeight + 216 - _keyBoardHeight -_explangHeight;
    CGFloat size_w = GJCFSystemScreenWidth;
    CGFloat size_h = self.barToolHeight;
    CGRect newFrame = (CGRect){ori_x,ori_y,size_w,size_h};
    self.frame = newFrame;
    
    CGRect barFrame = _inputBar.frame;
    barFrame.size.height = _inputBar.barHeight;
    _inputBar.frame = barFrame;
    
    if ([self.delegate respondsToSelector:@selector(chatBarToolViewChangeFrame:)]) {
        [self.delegate chatBarToolViewChangeFrame:newFrame];
    }
}


- (void)UIKeyboardWillShow:(NSNotification *)noti
{
    CGRect keyboardEndFrame = [noti.userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    _keyBoardHeight = keyboardEndFrame.size.height;
    [self layerBarFrame];
}

- (void)UIKeyboardWillHidden:(NSNotification *)noti
{
    _keyBoardHeight = 0;
    [self layerBarFrame];
}

- (void)dealloc
{
    [self removeAllObserver];
}

- (void)regestObserver//注册通知
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UIKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UIKeyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];//监视键盘尺寸
}

- (void)removeAllObserver//移除所有通知
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (CGFloat)barToolHeight
{
    return _inputBar.barHeight + 216.f;
}

- (void)cancleInputState
{
    [_inputBar cancleInputState];
}

@end
