//
//  HomeCell.h
//  baseFramework
//
//  Created by chenangel on 16/7/2.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, HomeCellType) {
    HomeCellTypeHorizontal = 0,
    HomeCellTypeVertical = 1
};

typedef void(^AddButtonClick)(UIImageView * imageView);
@interface HomeCell : UICollectionViewCell
@property(nonatomic,strong)AddButtonClick addButtonClick;

@property(nonatomic,strong)Activities *activities;
@property(nonatomic,strong)Good *good;
@end
