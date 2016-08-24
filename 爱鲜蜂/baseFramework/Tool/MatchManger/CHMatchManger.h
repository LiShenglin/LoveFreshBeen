//
//  CHMatchManger.h
//  baseFramework
//
//  Created by chenangel on 16/5/30.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHMatchManger : NSObject
/**
 *  collectionView高度计算场景:内边距加1边框的线，根据 总cell数，和cell长宽高，每行的个数计算collectionView高度
 *
 *  @param wh     wh description cell的长宽高
 *  @param num    num description 每一行放多少个cell
 *  @param count  count description 总cell数
 *  @param margin margin description 每个cell的边距
 *
 *  @return return value  是collectionViewH的高度
 */
+ (CGFloat)collectionCellWH:(CGFloat)wh rowCount:(NSInteger)num totalCells:(NSInteger)count cellMargin:(CGFloat)margin;

@end
