//
//  ShopCarRedDotView.m
//  baseFramework
//
//  Created by chenangel on 16/6/24.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "ShopCarRedDotView.h"

@interface ShopCarRedDotView()
@property(nonatomic,weak) UILabel * numberLabel;
@property(nonatomic,weak) UIImageView * redImageView;

@end
@implementation ShopCarRedDotView
SingleM(ShopCarRedDotView)
//设置徽章的数字
-(void)setBuyNumber:(NSInteger)buyNumber{
    _buyNumber = buyNumber;
    if (_buyNumber == 0) {
        self.numberLabel.text = @"";
        self.hidden = YES;
    }else{
        if (_buyNumber > 99) {
            self.numberLabel.font = [UIFont systemFontOfSize:8];
        }else{
            self.numberLabel.font = [UIFont systemFontOfSize:10];
        }
        self.hidden = NO;
        self.numberLabel.text = [NSString stringWithFormat:@"%ld",buyNumber];
    }
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, 20, 20)]) {
        self.backgroundColor = [UIColor clearColor];
        
        UIImageView *redImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"reddot"]];
        self.redImageView = redImage;
        [self addSubview:self.redImageView];
        
        UILabel *label = [[UILabel alloc]init];
        label.font = [UIFont systemFontOfSize:10];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        self.numberLabel = label;
        [self addSubview:self.numberLabel];
        
        self.hidden = YES;
    }
    
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.redImageView.frame = self.bounds;
    self.numberLabel.frame = CGRectMake(-3 , -3, self.width, self.height);
}

- (void)addProductToRedDotView:(BOOL)animaton {
    _buyNumber++;
    NSInteger tempInt = _buyNumber;
    self.buyNumber = tempInt;
    if (animaton) {
        [self reddotAnimation];
    }
}
- (void)reduceProductToRedDotView:(BOOL)animation {
    if (_buyNumber > 0) {
        _buyNumber--;
        NSInteger tempInt = _buyNumber;
        self.buyNumber = tempInt;

        
    }
    if (animation) {
        [self reddotAnimation];
    }
    
}
- (void)reddotAnimation{
    [UIView animateWithDuration:ShopCarRedDotAnimationDuration animations:^{
        self.transform = CGAffineTransformMakeScale(1.5, 1.5);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:ShopCarRedDotAnimationDuration animations:^{
            self.transform = CGAffineTransformIdentity;
        } completion:nil];
    }];
}





@end
