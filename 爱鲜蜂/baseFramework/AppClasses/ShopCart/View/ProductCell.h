//
//  ProductCell.h
//  baseFramework
//
//  Created by chenangel on 16/7/8.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  产品cell
 */
typedef void(^AddProductClick)(UIImageView* imageView);
@interface ProductCell : UITableViewCell
//商品信息
@property(nonatomic,strong)Good* good;
//商品点击保存的动画
@property(nonatomic,strong)AddProductClick addProductClick;
//cell点击
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
