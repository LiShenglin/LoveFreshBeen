//
//  CHLabel.m
//  baseFramework
//
//  Created by chenangel on 16/6/14.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "CHLabel.h"

@implementation CHLabel

- (void)awakeFromNib{

    [super awakeFromNib];
    [self setup];
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
- (void)setup{
    self.userInteractionEnabled = YES;
}
/**
 * 让label有资格成为第一响应者
 */
- (BOOL)canBecomeFirstResponder
{
    return YES;
}


/**
 * label能执行哪些操作(比如copy, paste等等)
 * @return  YES:支持这种操作
 */
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(cut:) || action == @selector(copy:) || action == @selector(paste:)) return YES;
    
    return NO;
}

- (void)cut:(UIMenuController *)menu
{
    // 将自己的文字复制到粘贴板
    [self copy:menu];
    
    // 清空文字
    self.text = nil;
}

- (void)copy:(UIMenuController *)menu
{
    // 将自己的文字复制到粘贴板
    UIPasteboard *board = [UIPasteboard generalPasteboard];
    board.string = self.text;
}

- (void)paste:(UIMenuController *)menu
{
    // 将粘贴板的文字 复制 到自己身上
    UIPasteboard *board = [UIPasteboard generalPasteboard];
    self.text = board.string;
}


@end
