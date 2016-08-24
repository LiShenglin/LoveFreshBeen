//
//  iconsViewItem.h
//  baseFramework
//
//  Created by chenangel on 16/6/24.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IconItem : NSObject
@property(nonatomic,strong)UIImageView * icon;
@property(nonatomic,strong)UILabel *textLabel;

- (instancetype)initWithDict:(NSDictionary*)dict;
@end
