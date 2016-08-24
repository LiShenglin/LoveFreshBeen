//
//  HomeCollectionFooterView.h
//  baseFramework
//
//  Created by chenangel on 16/6/29.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeCollectionFooterView : UICollectionReusableView

- (void)hideLabel;
- (void)showLabel;
- (void)setFooterTitle:(NSString*)text textColor:(UIColor*)textColor;

@end
