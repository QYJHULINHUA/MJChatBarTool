//
//  MJTextFrame.h
//  MJChatBarTool
//
//  Created by linhua hu on 16/10/11.
//  Copyright © 2016年 linhua hu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MJTextFrame : NSObject

/* 内容字符串 */
@property (nonatomic,readonly)NSAttributedString *contentAttributedString;

@property (nonatomic,assign)BOOL needLineSetup;

/* 所有行GJCFCoreTextLine对象 */
@property (nonatomic,readonly)NSArray *linesArray;

/* 读取内容的适配高度 */
@property (nonatomic,readonly)CGFloat suggestHeigh;

/* 读取内容适配的宽度 */
@property (nonatomic,readonly)CGFloat suggestWidth;

- (id)initWithAttributedString:(NSAttributedString *)attributedString withDrawRect:(CGRect)textRect isNeedSetupLine:(BOOL)isLineNeed;

- (void)drawInContext:(CGContextRef)context;
@end
