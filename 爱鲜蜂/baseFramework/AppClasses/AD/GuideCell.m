//
//  GuideCell.m
//  baseFramework
//
//  Created by chenangel on 16/6/24.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "GuideCell.h"

@interface GuideCell()
@property(nonatomic,strong)UIImageView *newimageView;
@property(nonatomic,strong)UIButton *nextButton;
@end
@implementation GuideCell
-(void)setNewimage:(UIImage *)newimage{
    self.newimageView.image = newimage;
}

-(UIImageView *)newimageView{
    if (_newimageView == nil) {
        _newimageView = [[UIImageView alloc]initWithFrame:ScreenBounds];
    }
    return _newimageView;
}
- (UIButton *)nextButton{
    if (_nextButton == nil) {
        _nextButton = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 100) * 0.5, SCREEN_HEIGHT - 110, 100, 33)];
    }
    return _nextButton;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.newimageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:self.newimageView];
        
        [self.nextButton setBackgroundImage:[UIImage imageNamed:@"icon_next"] forState:UIControlStateNormal];
        [self.nextButton addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
        self.nextButton.hidden = YES;
        [self.contentView addSubview:self.nextButton];
        
    }
    return self;
}

- (void)setNextButtonHidden:(BOOL)hidden{
    self.nextButton.hidden = hidden;
}
//通知appdelegate代理控制器
- (void)nextBtnClick{
    CHLog(@"----点击了");
    [AINotiCenter postNotificationName:GuideViewControllerDidFinish object:nil];
}

@end
