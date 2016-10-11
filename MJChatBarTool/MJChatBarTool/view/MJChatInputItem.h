//
//  IHFChatInputItem.h
//  IHFChat_PadDemo
//
//  Created by linhua hu on 16/9/29.
//  Copyright © 2016年 linhua hu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MJChatInputItem : UIButton

@property (nonatomic ,strong)UIImage *selectImage;
@property (nonatomic ,strong)UIImage *unSelectImage;

@property (nonatomic ,assign)BOOL itemIsSelect;

- (id)initWithSelectedIcon:(UIImage*)aUnSelectImg;

@end
