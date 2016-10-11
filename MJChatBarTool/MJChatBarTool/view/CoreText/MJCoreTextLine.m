//
//  GJCFCoreTextLine.m
//  GJCommonFoundation
//
//  Created by ZYVincent QQ:1003081775 on 14-9-21.
//  Copyright (c) 2014年 ZYProSoft. All rights reserved.
//

#import "MJCoreTextLine.h"
#import "MJCoreTextRun.h"

@interface MJCoreTextLine ()
{
    CTLineRef _line;
    
    __weak MJTextFrame *_frame;
}

@end

@implementation MJCoreTextLine

- (instancetype)initWithLine:(CTLineRef)ctLine withFrame:(MJTextFrame *)frame withLineOrigin:(CGPoint)lineOrigin
{
    if (self = [super init]) {
        
        _line = CFRetain(ctLine);
        
        _frame = frame;
        
        _origin = lineOrigin;
                
        [self setupLine];
    }
    return self;
}

- (void)dealloc
{
    CFRelease(_line);
}

- (CTLineRef)getLineRef
{
    return _line;
}

- (void)setupLine
{
    /* 获取行的 上行，下行，行距大小 */
    CTLineGetTypographicBounds(_line, &_ascent, &_descent, &_leading);
    
    /* 获取字形数量 */
    CFArrayRef glyphArray = CTLineGetGlyphRuns(_line);
    CFIndex glyphTotal = CFArrayGetCount(glyphArray);
    
    /* 创建字形数组 */
    NSMutableArray *gjGlyphArray= [NSMutableArray array];
    
    /* 创建所有的字形 */
    for (CFIndex glyphIndex = 0; glyphIndex < glyphTotal; glyphIndex++) {
        
        CTRunRef glyphRun = CFArrayGetValueAtIndex(glyphArray, glyphIndex);
        
        MJCoreTextRun *gjRun = [[MJCoreTextRun alloc]initWithRun:glyphRun withLine:self];
        
        [gjGlyphArray addObject:gjRun];
        
    
    }
    _glyphsArray = gjGlyphArray;
    _numberOfGlyphs = [gjGlyphArray count];
    _lineHeight = _ascent+_descent+_leading;
    
    _stringRange = CTLineGetStringRange(_line);
    
}

/* 获取某个索引位置的具体字形run */
- (MJCoreTextRun *)glyphRunAtIndex:(NSInteger)glyphIndex
{
    return [_glyphsArray objectAtIndex:glyphIndex];
}

- (CFIndex)getStringForPosition:(CGPoint)position
{
    return CTLineGetStringIndexForPosition(_line, position);
}

/* 获取字符串指定位置的区域 */
- (CGRect)rectForStringRange:(NSRange)range
{
    CFRange stringRange = CTLineGetStringRange(_line);
    
    NSRange convertStringRange = NSMakeRange(stringRange.location, stringRange.length);
    
    CGRect resultRect = CGRectZero;
    resultRect.origin.y = _origin.y-4;
    
    //结束字符的位置在字符串中,那么这个字符串也会在这一行中
    BOOL stringJustEndLocationInStringRange = NSLocationInRange(range.location+range.length, convertStringRange) && range.location < convertStringRange.location;
    
    if (NSLocationInRange(range.location, convertStringRange) || stringJustEndLocationInStringRange) {
        
        CGFloat offset = 0.f;
        CTLineGetOffsetForStringIndex(_line, range.location, &offset);
        
        //如果是结束字符在这行中
        if (stringJustEndLocationInStringRange) {
            CTLineGetOffsetForStringIndex(_line, convertStringRange.location, &offset);
        }
        
        resultRect.origin.x = offset;
        
        CGFloat width = 0.f;
        
        //获取结束位置
        if (NSLocationInRange(range.length+range.location, convertStringRange)) {
            
            CGFloat endOffset = 0.f;
            
            CTLineGetOffsetForStringIndex(_line, range.location+range.length, &endOffset);
                        
            width = endOffset - offset;
            
        }else{
            
            CGFloat endOffset = 0.f;
            CTLineGetOffsetForStringIndex(_line, stringRange.location+stringRange.length, &endOffset);
            
            width = endOffset - offset;

        }
        
        resultRect.size.width = width;
        resultRect.size.height = _lineHeight;
        
    }
    
    return resultRect.size.width == 0? CGRectZero:resultRect;
}

@end
