//
//  HotView.m
//  baseFramework
//
//  Created by chenangel on 16/6/28.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "HotView.h"
#import "IconImageTextView.h"
#define iconW ((SCREEN_WIDTH - 20) * 0.25)
#define iconH 80

@interface HotView()
@property(nonatomic,assign)NSInteger rows;
@end
@implementation HotView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

//设置模型
-(void)setHeadData:(HomeHeadData *)headData{
    if (_headData == nil) {
        
    if (headData.icons.count > 0) {
        if (headData.icons.count % 4 != 0) {//不足一行算一行
            self.rows = headData.icons.count / 4 + 1;
        }else{
            self.rows = headData.icons.count / 4;
        }
        CGFloat iconX = 0;
        CGFloat iconY = 0;
        
        for (NSInteger i = 0; i < headData.icons.count; i++) {
            iconX = (i % 4) * iconW + 10;
            iconY = (i / 4) * iconH;
            IconImageTextView * icon = [[IconImageTextView alloc] initWithFrame:CGRectMake(iconX, iconY, iconW, iconH) placeholderImage:[UIImage imageNamed:@"icon_icons_holder"]];

            icon.clipsToBounds = YES;
            
            icon.tag = i;
            icon.Activitie = headData.icons[i];
            
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(iconClick:)];
            [icon addGestureRecognizer:tap];
            [self addSubview:icon];
            }
        }
    }
    
    _headData = headData;

}

//rows数量
-(void)setRows:(NSInteger)rows{
    self.bounds = CGRectMake(0, 0, SCREEN_WIDTH, iconH * rows);
}

-(instancetype)initWithFrame:(CGRect)frame iconClick:(IconClick)iconClick{
    if (self = [super initWithFrame:frame]) {
        self.iconClick = iconClick;
    }
    return self;
}
//按钮block执行选中按钮点击事件
- (void)iconClick:(UITapGestureRecognizer*)tap{
    if (self.iconClick != nil) {
        self.iconClick(tap.view.tag);
    }
}


@end
