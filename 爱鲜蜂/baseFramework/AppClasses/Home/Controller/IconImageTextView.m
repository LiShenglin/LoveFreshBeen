//
//  IconImageTextView.m
//  baseFramework
//
//  Created by chenangel on 16/6/29.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "IconImageTextView.h"

@interface IconImageTextView()
@property(nonatomic,weak)UIImageView * imageView;
@property(nonatomic,weak)UILabel * textLabel;
@property(nonatomic,weak)UIImage * placeHolderImage;

@end
@implementation IconImageTextView
//设置数据模型
-(void)setActivitie:(Activities *)Activitie{
    _Activitie = Activitie;
    self.textLabel.text = Activitie.name;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:Activitie.img] placeholderImage:self.placeHolderImage];
}
- (UIImageView *)imageView{
    if (_imageView == nil) {
        UIImageView *imageView = [[UIImageView alloc]init];
        _imageView = imageView;
    }
    return _imageView;
}


- (instancetype)initWithFrame:(CGRect)frame placeholderImage:(UIImage *)placeholderImage{
    if (self = [super initWithFrame:frame]) {
        
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.userInteractionEnabled = NO;
        //imageView.contentMode = UIViewContentModeCenter;
        
        [self addSubview:imageView];
        self.imageView = imageView;
        
        
        self.imageView.frame = CGRectMake(5, 5, self.width - 25, self.height - 40);
        
        UILabel *textLabel = [[UILabel alloc]init];
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.font = [UIFont systemFontOfSize:12];
        textLabel.textColor = [UIColor blackColor];
        textLabel.userInteractionEnabled = NO;
        [self addSubview:textLabel];
        self.textLabel = textLabel;
        
        self.placeHolderImage = placeholderImage;
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(5, 5, self.width - 25, self.height - 40);
    self.textLabel.frame = CGRectMake(5, CGRectGetMaxY(self.imageView.frame), self.imageView.width, 20);
}



@end
