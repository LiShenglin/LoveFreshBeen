//
//  GuideCell.h
//  baseFramework
//
//  Created by chenangel on 16/6/24.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuideCell : UICollectionViewCell
@property(nonatomic,weak)UIImage * newimage;
- (void)setNextButtonHidden:(BOOL)hidden;
@end
