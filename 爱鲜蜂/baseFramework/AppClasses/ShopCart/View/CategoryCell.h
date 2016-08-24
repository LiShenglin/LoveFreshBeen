//
//  CategoryCell.h
//  baseFramework
//
//  Created by chenangel on 16/7/8.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  分类列表
 */
@class Categorie;
@interface CategoryCell : UITableViewCell
//分类模型设置
@property(nonatomic,strong)Categorie *categorie;

+ (instancetype)cellWithTabelView:(UITableView *)tableView;
@end
