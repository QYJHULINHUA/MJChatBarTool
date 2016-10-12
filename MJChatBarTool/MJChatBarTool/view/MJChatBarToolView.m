//
//  MJChatBarToolView.m
//  MJChatBarTool
//
//  Created by linhua hu on 16/10/8.
//  Copyright © 2016年 linhua hu. All rights reserved.
//

#import "MJChatBarToolView.h"


@interface MJChatBarToolView ()<MJChatBarInputViewDelegate>

@property (nonatomic ,strong)MJChatBarInputView *inputBar;
@property (nonatomic ,assign)CGFloat keyBoardHeight;
@property (nonatomic ,assign)CGFloat explangHeight;

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
        
    }
    return self;
}

- (void)chatBarFrameChage
{
    [self layerBarFrame];
}

- (void)changeActionType:(MJChatBarActionType)type
{
    [self layerBarFrame];
    
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
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
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
