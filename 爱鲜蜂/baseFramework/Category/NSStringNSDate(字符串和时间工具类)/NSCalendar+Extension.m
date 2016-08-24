//
//  NSCalendar+Extension.m
//  baseFramework
//
//  Created by chenangel on 16/6/3.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "NSCalendar+Extension.h"

@implementation NSCalendar (Extension)
+ (instancetype)calendar
{
    if ([NSCalendar respondsToSelector:@selector(calendarWithIdentifier:)]) {
        return [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    } else {
        return [NSCalendar currentCalendar];
    }
}
@end
