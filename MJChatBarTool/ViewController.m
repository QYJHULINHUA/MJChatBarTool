//
//  ViewController.m
//  MJChatBarTool
//
//  Created by linhua hu on 16/10/8.
//  Copyright © 2016年 linhua hu. All rights reserved.
//

#import "ViewController.h"
#import "MJChatBarToolView.h"

@interface ViewController ()
{
    MJChatBarToolView *chatBarToolView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.view addGestureRecognizer:tap];
    
    
    chatBarToolView = [[MJChatBarToolView alloc] init];
    chatBarToolView.frame = (CGRect){0,GJCFSystemScreenHeight - chatBarToolView.barToolHeight + 216,GJCFSystemScreenWidth,chatBarToolView.barToolHeight};
    [self.view addSubview:chatBarToolView];
}


- (void)tapAction:(UITapGestureRecognizer *)tap
{
    [chatBarToolView cancleInputState];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
