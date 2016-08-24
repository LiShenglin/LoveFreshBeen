//
//  SupermarketHeadView.h
//  baseFramework
//
//  Created by chenangel on 16/7/8.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  头部header
 */
@interface SupermarketHeadView : UITableViewHeaderFooterView
@property(nonatomic,strong)UILabel *titleLabel;
-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;

@end
