//
//  MJChatEmojiView.m
//  MJChatBarTool
//
//  Created by linhua hu on 16/10/13.
//  Copyright © 2016年 linhua hu. All rights reserved.
//

#import "MJChatEmojiView.h"
#import "MJChatBarToolModel.h"
#import "MJChatEmojiBar.h"
#import "MJhatInputExpandEmojiPanelPageItem.h"

@interface MJChatEmojiView ()<UIScrollViewDelegate>

@property (nonatomic , strong)UIScrollView *scrollView;
@property (nonatomic , strong)UIPageControl *pageControl;
@property (nonatomic , strong)MJChatEmojiBar *emojiBar;
@property (nonatomic , strong)UIButton *sendButton;
@property (nonatomic,assign)NSInteger pageCount;

@end

@implementation MJChatEmojiView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _scrollView = [self getScrollViewWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - 70)];
        [self addSubview:_scrollView];
        
        _pageControl = [self getPageControlL:frame];
        _pageControl.numberOfPages = 6;
        [self addSubview:_pageControl];
        
        UIImageView *bottomBarBack = [[UIImageView alloc]initWithFrame:CGRectMake(0, frame.size.height - 40.5, GJCFSystemScreenWidth, 40.5)];
        bottomBarBack.backgroundColor = [MJChatBarToolModel mainBackgroundColor];
        bottomBarBack.userInteractionEnabled = YES;
        [self addSubview:bottomBarBack];
        
        _emojiBar = [[MJChatEmojiBar alloc] init];
        [bottomBarBack addSubview:_emojiBar];
        
        UIImageView *seprateLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, GJCFSystemScreenWidth, 0.5)];
        seprateLine.backgroundColor = [MJChatBarToolModel colorFromHexString:@"0xacacac"];
        [bottomBarBack addSubview:seprateLine];
        
        _sendButton = [self getSendButtonWihtFrame:CGRectMake(frame.size.width - 72 ,0.5, 72, 40)];
        [bottomBarBack addSubview:_sendButton];
        [self loadDataFromEmojiBar];
    }
    return self;
}

- (UIScrollView *)getScrollViewWithFrame:(CGRect)frame
{
    UIScrollView *scrllv = [[UIScrollView alloc] initWithFrame:frame];
    scrllv.delegate = self;
    scrllv.showsVerticalScrollIndicator = NO;
    scrllv.showsHorizontalScrollIndicator = NO;
    scrllv.pagingEnabled = YES;
    return scrllv;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
//    self.pageControl.currentPage = page;
}


- (UIPageControl *)getPageControlL:(CGRect)frame
{
    UIPageControl *pc = [[UIPageControl alloc] initWithFrame:CGRectMake(0, frame.size.height - 60.5, 80, 20)];
    CGPoint ceterP = pc.center;
    ceterP.x = 0.5*frame.size.width;
    pc.center = ceterP;
    pc.pageIndicatorTintColor = [MJChatBarToolModel colorFromHexString:@"cccccc"];
    pc.currentPageIndicatorTintColor = [MJChatBarToolModel colorFromHexString:@"b3b3b3"];
    [_pageControl addTarget:self action:@selector(pageIndexChange:) forControlEvents:UIControlEventValueChanged];
    return pc;
}

- (UIButton*)getSendButtonWihtFrame:(CGRect)frame
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:@"发送" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor blueColor];
    [button addTarget:self action:@selector(sendEmojiAction) forControlEvents:UIControlEventTouchUpInside];
    return button;
    
}

- (void)loadDataFromEmojiBar
{
    MJEmogjiStyleModel *model = _emojiBar.emojiModel;
    if (!model.emojiArr) {
        model.emojiArr = [NSArray arrayWithContentsOfFile:model.emojiListFilePath];
    }
    NSInteger pageItemCount = 20;
    /* 分割页面 */
    NSMutableArray *pagesArray = [NSMutableArray array];
    
    self.pageCount = model.emojiArr.count%pageItemCount == 0? model.emojiArr.count/pageItemCount:model.emojiArr.count/pageItemCount+1;
    self.pageControl.numberOfPages = self.pageCount;
    NSInteger pageLastCount = model.emojiArr.count%pageItemCount;
    
    for (int i = 0; i < self.pageCount; i++) {
        NSMutableArray *pageItemArray = [NSMutableArray array];
        if (i != self.pageCount - 1) {
            
            [pageItemArray addObjectsFromArray:[model.emojiArr subarrayWithRange:NSMakeRange(i*pageItemCount,pageItemCount)]];
            [pageItemArray addObject:@{@"删除":@"删除"}];
        }else{
            [pageItemArray addObjectsFromArray:[model.emojiArr subarrayWithRange:NSMakeRange(i*pageItemCount, pageLastCount)]];
        }
        
        [pagesArray addObject:pageItemArray];
    }
    
    /* 创建 */
    for (int i = 0; i < pagesArray.count ; i++) {
        
        NSArray *pageNamesArray = [pagesArray objectAtIndex:i];
        
        MJhatInputExpandEmojiPanelPageItem *pageItem = [[MJhatInputExpandEmojiPanelPageItem alloc]initWithFrame:CGRectMake(i*self.frame.size.width, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height) withEmojiNameArray:pageNamesArray];
        [self.scrollView addSubview:pageItem];
    }
    
    self.scrollView.contentSize = CGSizeMake(self.pageCount * GJCFSystemScreenWidth, self.scrollView.frame.size.height);
}

- (void)sendEmojiAction
{
    
}

- (void)pageIndexChange:(UIPageControl *)pageControl
{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
