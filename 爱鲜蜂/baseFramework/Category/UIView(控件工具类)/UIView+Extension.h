//
//
//  Created by chenangel on 16/5/25.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)
#pragma mark -- size
@property(nonatomic,assign)CGFloat x;
@property(nonatomic,assign)CGFloat y;
@property(nonatomic,assign)CGFloat centerX;
@property(nonatomic,assign)CGFloat centerY;
@property(nonatomic,assign)CGFloat width;
@property(nonatomic,assign)CGFloat height;
@property(nonatomic,assign)CGSize size;
@property(nonatomic,assign)CGPoint origin;

#pragma mark -- UIView操作

/*
 *  获取该视图的控制器
 *
 */
- (UIViewController*) viewController;

/** 删除当前视图内的所有子视图 */
- (void) removeChildViews;

/** 删除tableview底部多余横线 */
- (void)setExtraCellLineHidden: (UITableView *)tableView;
/** 加载xib文件 */
+ (instancetype)loadFromNib:(NSInteger)num;

+ (instancetype)viewFromNib;


@end
