//
//  GJGCChatInputRecordAudioTipView.m
//  ZYChat
//
//  Created by ZYVincent QQ:1003081775 on 14-10-29.
//  Copyright (c) 2014年 ZYProSoft. All rights reserved.
//

#import "MJChatInputRecordAudioTipView.h"
#import "MJCoreTextAttributeStringStyle.h"
#import "MJCoreTextParagraphStyle.h"
#import "MJTextFrame.h"
#define GJCFSystemScreenWidth [UIScreen mainScreen].bounds.size.width //获取屏幕的宽度
#define GJCFSystemScreenHeight [UIScreen mainScreen].bounds.size.height //获取屏幕的高度


@interface MJChatInputRecordAudioTipView ()

@property (nonatomic ,strong)MJCoreTextAttributeStringStyle *stringStyle;
@property (nonatomic ,strong)MJTextFrame *textFrame;

@end

@implementation MJChatInputRecordAudioTipView

- (instancetype)init
{
    if (self = [super init]) {
        
        [self setupStyle];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setupStyle];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (void)setupStyle
{
    
    self.voiceCancelImage = [UIImage imageNamed:@"聊天语音-icon-取消.png"];
    
    self.voiceMicImage = [UIImage imageNamed:@"聊天语音-icon-话筒.png"];
    self.voiceSoundMeterImage = [UIImage imageNamed:@"聊天语音-icon-音量.png"];
    
    self.minRecordTimeErrorTitle = @"说话时间太短";
    self.maxRecordTimeErrorTitle = @"说话时间超长";
    self.upToCancelRecordTitle = @"手指上滑,取消发送";
    self.releaseToCancelRecordTitle = @"手指松开,取消发送";
    
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f];
    self.frame = CGRectMake(0, 0, 178, 178);
    self.center = (CGPoint){GJCFSystemScreenWidth/2,GJCFSystemScreenHeight/2};
    self.layer.cornerRadius = 8.0;
    self.layer.masksToBounds = YES;
    
    self.leftMargin = (self.frame.size.width - self.voiceMicImage.size.width - self.voiceMicImage.size.width)/3;
    
    self.stringStyle = [[MJCoreTextAttributeStringStyle alloc]init];
    self.stringStyle.foregroundColor = [UIColor whiteColor];
    self.stringStyle.strokeColor = [UIColor whiteColor];
    self.stringStyle.font = [UIFont boldSystemFontOfSize:14];
    
    /* 观察程序进入后台了 */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observeAppResignActive:) name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observeAppResignActive:) name:UIApplicationDidEnterBackgroundNotification object:nil];
}

- (void)drawRect:(CGRect)rect
{
    
    /* 录音时间太短 */
    if (self.isTooShortRecordDuration || self.isTooLongRecordDuration) {
        
        NSString *errorText = @" ！";
        
        
        /* 获取图形上下文 */
        CGContextRef context = UIGraphicsGetCurrentContext();
        /* 变换矩阵 */
        CGContextTranslateCTM(context, 0, self.bounds.size.height);
        CGContextScaleCTM(context, 1, -1.0);

        /* 设置文字绘制矩阵 */
        CGContextSetTextMatrix(context, CGAffineTransformIdentity);
        
        CGFloat errorWidth = 50;
        CGFloat tipHeight  = 30;
        CGFloat tipWidth   = 100;
        
        CGRect errorTextRect = CGRectMake((self.frame.size.width - errorWidth)/2,(self.frame.size.height - errorWidth )/2 - tipHeight, errorWidth, errorWidth);
        
        self.stringStyle.font = [UIFont boldSystemFontOfSize:35];
        
        [self drawTitle:errorText inRect:errorTextRect inContext:context];
        
        CGRect tipRect = CGRectMake((self.frame.size.width - tipWidth)/2, errorTextRect.origin.y+errorTextRect.size.height, tipWidth, tipHeight);
        
        self.stringStyle.font = [UIFont boldSystemFontOfSize:16];

        if (self.isTooShortRecordDuration) {
            
            [self drawTitle:self.minRecordTimeErrorTitle  inRect:tipRect inContext:context];
        }
        
        if (self.isTooLongRecordDuration){
            
            [self drawTitle:self.maxRecordTimeErrorTitle inRect:tipRect inContext:context];
        }

        return;
    }
    
    /* 录音状态 */
    CGRect micRect = CGRectZero;
    if (!self.willCancel) {
        
        if (self.voiceMicImage) {
            
            CGSize micSize = self.voiceMicImage.size;
            
            CGFloat topMargin = (self.bounds.size.height-micSize.height)/2;
            
            micRect = (CGRect){self.leftMargin,topMargin,micSize.width,micSize.height};
            
            [self.voiceMicImage drawInRect:micRect];
            
        }
        
        if (self.voiceSoundMeterImage) {
            
            if (self.soundMeter > 0) {
                
                CGRect rect = CGRectMake(0, self.voiceSoundMeterImage.size.height * self.voiceSoundMeterImage.scale * (1 - self.soundMeter), self.voiceSoundMeterImage.size.width * self.voiceSoundMeterImage.scale,  self.voiceSoundMeterImage.size.height * self.voiceSoundMeterImage.scale * self.soundMeter );
                
                
                CGImageRef imager = CGImageCreateWithImageInRect([self.voiceSoundMeterImage CGImage], rect);
                
                UIImage *image = [UIImage imageWithCGImage:imager scale:self.voiceSoundMeterImage.scale orientation:UIImageOrientationUp];
                
                CGImageRelease(imager);
                
                CGRect imageRect = (CGRect){self.leftMargin + self.voiceMicImage.size.width + self.leftMargin,micRect.origin.y+micRect.size.height-image.size.height,image.size.width,image.size.height};
                
                [image drawInRect:imageRect];
            }
            
        }
        
    }
    
    /* 准备取消录音 */
    CGRect cancleRect = CGRectZero;
    if (self.willCancel) {
        
        CGSize cancelSize = self.voiceCancelImage.size;
        
        CGFloat originX = (self.bounds.size.width - cancelSize.width)/2;
        
        CGFloat originY = (self.bounds.size.height - cancelSize.height)/2;
        
        cancleRect = (CGRect){originX,originY,cancelSize.width,cancelSize.height};
        
        [self.voiceCancelImage drawInRect:cancleRect];
        
    }
    
    
    /* 获取图形上下文 */
    CGContextRef context = UIGraphicsGetCurrentContext();
    /* 变换矩阵 */
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1, -1.0);
    
    /* 设置文字绘制矩阵 */
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    
    
    if (self.willCancel) {
        
        CGRect textRect = CGRectMake(self.leftMargin, 5, self.bounds.size.width - 2*self.leftMargin, 30);
        
        [self drawTitle:self.releaseToCancelRecordTitle inRect:textRect inContext:context];
        
    }else{
        
        CGRect textRect = CGRectMake(self.leftMargin, 5, self.bounds.size.width - 2*self.leftMargin, 30);
        
        [self drawTitle:self.upToCancelRecordTitle inRect:textRect inContext:context];
    }
}

- (void)drawTitle:(NSString *)title inRect:(CGRect)rect inContext:(CGContextRef)context
{
    NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc]initWithString:title attributes:[self.stringStyle attributedDictionary]];
    
    MJCoreTextParagraphStyle *paragraphStyle = [[MJCoreTextParagraphStyle alloc]init];
    paragraphStyle.alignment = kCTTextAlignmentCenter;
    [attriString addAttributes:[paragraphStyle paragraphAttributedDictionary] range:[self stringRange:title]];
    
    self.textFrame = [[MJTextFrame alloc]initWithAttributedString:attriString withDrawRect:rect isNeedSetupLine:NO];
//
    [self.textFrame drawInContext:context];
//
    self.textFrame = nil;
}

- (NSRange)stringRange:(NSString *)string
{
    if (!string) {
        return NSMakeRange(NSNotFound, 0);
    }
    return NSMakeRange(0, string.length);
}

#pragma mark - 设置属性影响
- (void)setSoundMeter:(CGFloat)soundMeter
{
    if (_soundMeter == soundMeter) {
        return;
    }
    _soundMeter = soundMeter;
    [self setNeedsDisplay];
}

- (void)setWillCancel:(BOOL)willCancel
{
    if (_willCancel == willCancel) {
        return;
    }
    _willCancel = willCancel;
    [self setNeedsDisplay];
}

- (void)setIsTooLongRecordDuration:(BOOL)isTooLongRecordDuration
{
    if (_isTooLongRecordDuration == isTooLongRecordDuration) {
        return;
    }
    _isTooLongRecordDuration = isTooLongRecordDuration;
    [self setNeedsDisplay];
}

- (void)setIsTooShortRecordDuration:(BOOL)isTooShortRecordDuration
{
    if (_isTooShortRecordDuration == isTooShortRecordDuration) {
        return;
    }
    _isTooShortRecordDuration = isTooShortRecordDuration;
    [self setNeedsDisplay];
}

#pragma mark - 观察程序进入后台

- (void)observeAppResignActive:(NSNotification *)noti
{
    [self removeFromSuperview];
}


@end
