//
//  MJTextFrame.m
//  MJChatBarTool
//
//  Created by linhua hu on 16/10/11.
//  Copyright © 2016年 linhua hu. All rights reserved.
//

#import "MJTextFrame.h"
#import <CoreText/CoreText.h>
#import "MJCoreTextLine.h"
#import "MJCoreTextRun.h"

@interface MJTextFrame ()
{
    CTFramesetterRef _frameSetter;
    CTFrameRef       _frame;
    CGRect           _textFrame;
    
    NSArray          *_imageTagArray;
    NSArray          *_keywordTagArray;
    
}

@end

@implementation MJTextFrame

- (id)initWithAttributedString:(NSAttributedString *)attributedString withDrawRect:(CGRect)textRect isNeedSetupLine:(BOOL)isLineNeed
{
    return [self initWithAttributedString:attributedString withDrawRect:textRect withImageTagArray:nil isNeedSetupLine:isLineNeed];
}

- (id)initWithAttributedString:(NSAttributedString *)attributedString withDrawRect:(CGRect)textRect withImageTagArray:(NSArray *)imageTagArray isNeedSetupLine:(BOOL)isLineNeed
{
    if (self = [super init]) {
        
        self.needLineSetup = isLineNeed;
        
        _contentAttributedString = [attributedString copy];
        
        _textFrame = textRect;
        
        _imageTagArray = imageTagArray;
        
        if (_contentAttributedString && !CGRectEqualToRect(_textFrame, CGRectZero)) {
            
            [self setupFrame];
        }
    }
    return self;
}

- (void)setupFrame
{
    if (_frameSetter) {
        CFRelease(_frameSetter);
    }
    _frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)_contentAttributedString);
    
    /* 创建绘制路径 */
    CGMutablePathRef textPath = CGPathCreateMutable();
    CGPathAddRect(textPath, NULL, _textFrame);
    
    if (_frame) {
        CFRelease(_frame);
    }
    _linesArray = nil;
    _frame = CTFramesetterCreateFrame(_frameSetter, CFRangeMake(0,0), textPath, NULL);
    
    //图形路径要用这个释放
    CGPathRelease(textPath);
    
    /* 如果没有图文混排和点击事件检测的需求，是不需要初始化下面每一条Line的信息的 */
    if (!self.needLineSetup) {
        
        [self setupSuggest];
        
        //        NSLog(@"setup ctFrame No need setup Line ++++");
        
        return;
    }
    
    //    NSLog(@"setup ctFrame need setup Line ----");
    
    /* 得到所有行数组 */
    CFArrayRef ctLinesArray = CTFrameGetLines(_frame);
    CFIndex lineTotal = CFArrayGetCount(ctLinesArray);
    
    /* 所有行的起始点 */
    CGPoint lineOriginArray[lineTotal];
    CTFrameGetLineOrigins(_frame, CFRangeMake(0, 0), lineOriginArray);
    
    NSMutableArray *gjLineArray = [NSMutableArray array];
    for (CFIndex lineIndex = 0; lineIndex < lineTotal; lineIndex++) {
        
        CTLineRef line = CFArrayGetValueAtIndex(ctLinesArray, lineIndex);
        
        MJCoreTextLine *gjLine = [[MJCoreTextLine alloc]initWithLine:line withFrame:self withLineOrigin:lineOriginArray[lineIndex]];
        
        [gjLineArray addObject:gjLine];
        
    }
    
    _linesArray = gjLineArray;
    [self setupSuggest];
}

- (void)setupSuggest
{
    CGSize constraitSize = CTFramesetterSuggestFrameSizeWithConstraints(_frameSetter, CFRangeMake(0, _contentAttributedString.length), NULL, _textFrame.size, NULL);
    _suggestHeigh = constraitSize.height;
    _suggestWidth = constraitSize.width;
}

- (void)drawInContext:(CGContextRef)context
{
    if (!context) {
        return;
    }
    if (_frame) {
        CTFrameDraw(_frame, context);
    }
    
    /* 只有有图片的时候才需要这个信息 */
    if (_imageTagArray && _imageTagArray.count > 0) {
        [self drawImagesInContext:context];
    }
}

- (void)drawImagesInContext:(CGContextRef)context
{
    [_linesArray enumerateObjectsUsingBlock:^(MJCoreTextLine *aLine, NSUInteger idx, BOOL *stop) {
        
        [aLine.glyphsArray enumerateObjectsUsingBlock:^(MJCoreTextRun *aRun, NSUInteger idx, BOOL *stop) {
            
            NSDictionary *attributesDict = aRun.attributesDictionary;
            
            /* 绘制图片 */
            for (NSString *imageTag in _imageTagArray) {
                
                NSString *imageName = [attributesDict objectForKey:imageTag];
                
                if (imageName) {
                    
                    UIImage *image = [UIImage imageNamed:imageName];
                    
                    if (image) {
                        CGRect imageDrawRect;
                        imageDrawRect.size = image.size;
                        imageDrawRect.origin.x = aRun.runRect.origin.x;
                        imageDrawRect.origin.y = aRun.runRect.origin.y;
                        CGContextDrawImage(context, imageDrawRect, image.CGImage);
                    }
                    
                }
            }
            
        }];
    }];
}




@end
