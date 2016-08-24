//
//  ShopCartCell.h
//  baseFramework
//
//  Created by chenangel on 16/7/13.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopCartCell : UITableViewCell
@property(nonatomic,strong)Good *good;

+ (instancetype)shopCarCell:(UITableView*)tableView;

@end
