//
//  MJChatBarToolModel.m
//  MJChatBarTool
//
//  Created by linhua hu on 16/10/8.
//  Copyright © 2016年 linhua hu. All rights reserved.
//

#import "MJChatBarToolModel.h"

@implementation MJChatBarToolModel

+ (UIColor *)mainBackgroundColor
{
    return GJCFQuickRGBColor(242, 242, 242);
}


+ (UIColor *)colorFromHexString:(NSString *)hexString
{
    if (hexString&& [hexString isKindOfClass:[NSString class]]) {
        unsigned hexNum;
        if ( ![[NSScanner scannerWithString:hexString] scanHexInt:&hexNum] ) {
            return nil;
        }
        
        return [UIColor colorWithRed:((float)((hexNum & 0xFF0000) >> 16))/255.0 green:((float)((hexNum & 0xFF00) >> 8))/255.0 blue:((float)(hexNum & 0xFF))/255.0 alpha:1.0];
    }
    else
    {
        return nil;
    }
}

+ (BOOL)iPhone4Device
{
    return CGSizeEqualToSize((CGSize){320,480}, [self deviceScreenSize]);
}

+ (BOOL)iPhone5Device
{
    return CGSizeEqualToSize((CGSize){320,568}, [self deviceScreenSize]);
    
}

+ (BOOL)iPhone6Device
{
    return CGSizeEqualToSize((CGSize){375,667}, [self deviceScreenSize]);
}

+ (BOOL)iPhone6PlusDevice
{
    return CGSizeEqualToSize((CGSize){414,736}, [self deviceScreenSize]);
}

+ (CGSize)deviceScreenSize
{
    return [UIScreen mainScreen].bounds.size;
}


+ (BOOL)stringIsAllWhiteSpace:(NSString *)string
{
    if ([self isNullString:string]) {
        return YES;
    }else{
        
        NSString *trimString = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        if (trimString.length > 0) {
            return NO;
        }else{
            return YES;
        }
    }
}

+(BOOL)isNullString:(NSString*)string
{
    if (string&&[string isKindOfClass:[NSString class]]) {
        return NO;
    }else
    {
        return YES;
    }
}

/* 根据颜色创建图片 */
+ (UIImage *)imageForColor:(UIColor*)aColor withSize:(CGSize)aSize
{
    if (aColor && [aColor isKindOfClass:[UIColor class]]) {
        CGRect rect = CGRectMake(0, 0, aSize.width, aSize.height);
        
        UIGraphicsBeginImageContext(rect.size);
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextSetFillColorWithColor(context, aColor.CGColor);
        
        CGContextFillRect(context, rect);
        
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        return img;
    }
    else
    {
        return nil;
    }
    
    
}

+ (NSString *)currentTimeStamp
{
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970] * 1000000;
    
    NSString *timeString = [NSString stringWithFormat:@"%1.f",interval];
    
    return timeString;
}

+ (NSString *)mainBundlePath:(NSString*)fileName
{
    if ([self stringIsNull:fileName]) {
        return nil;
    }
    NSArray *fileArray = [fileName componentsSeparatedByString:@"."];
    if (fileArray.count < 2) {
        return nil;
    }
    return [[NSBundle mainBundle]  pathForResource:fileArray[0] ofType:fileArray[1]];
}

+ (BOOL)stringIsNull:(NSString *)string
{
    if (![string isKindOfClass:[NSString class]]) {
        return YES;
    }
    
    if (!string || [string isKindOfClass:[NSNull class]] || string.length == 0 || [string isEqualToString:@""]) {
        return YES;
    }else{
        return NO;
    }
}


@end
