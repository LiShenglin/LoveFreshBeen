//
//  CHLabelVC.m
//  baseFramework
//
//  Created by chenangel on 16/6/14.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "CHLabelVC.h"
#import "CHLabel.h"
@interface CHLabelVC ()
@property (strong,nonatomic)CHLabel *label;

@end

@implementation CHLabelVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.label = [[CHLabel alloc]init];
    
    self.label.text = @"sdasdasdjfsdlfnaljfkdjsnvlkas";
    self.label.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.label];
    [self.label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)]];
}
- (void)tapClick:(UITapGestureRecognizer*)tap{
    // 1.label要成为第一响应者(作用是:告诉UIMenuController支持哪些操作, 这些操作如何处理)
    [self.label becomeFirstResponder];
    // 2.显示MenuController
    UIMenuController *menu = [UIMenuController sharedMenuController];
    // 添加MenuItem
    UIMenuItem *ding = [[UIMenuItem alloc] initWithTitle:@"顶" action:@selector(ding:)];
    UIMenuItem *replay = [[UIMenuItem alloc] initWithTitle:@"顶" action:@selector(replay:)];
    UIMenuItem *report = [[UIMenuItem alloc] initWithTitle:@"顶" action:@selector(report:)];
    
    menu.menuItems = @[ding,replay,report];
    
    [menu setTargetRect:self.label.bounds inView:self.view];
    [menu setMenuVisible:YES animated:YES];
    
    
}

- (void)ding:(UIMenuController *)menu
{
    NSLog(@"%s %@", __func__ , menu);
}

- (void)replay:(UIMenuController *)menu
{
    NSLog(@"%s %@", __func__ , menu);
}

- (void)report:(UIMenuController *)menu
{
    NSLog(@"%s %@", __func__ , menu);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
