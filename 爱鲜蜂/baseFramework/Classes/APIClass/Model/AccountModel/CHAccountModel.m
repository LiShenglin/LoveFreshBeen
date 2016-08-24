//
//  CHAccountModel.m
//  baseFramework
//
//  Created by chenangel on 16/5/26.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "CHAccountModel.h"

@implementation CHAccountModel
+ (instancetype)accountWithDict:(NSDictionary *)dict{
    CHAccountModel *accountModel = [[CHAccountModel alloc]init];
    //实际看接口数据，再单独调整KVC冲突key
    [accountModel setValuesForKeysWithDictionary:dict];
    return accountModel;
}

//在字典转换的时候自动把字典中对应的key转换成模型对应的属性
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"userid":@"id"
             };
}

//显示账号类型
-(CHAccountType)accountType{
    switch ([_type integerValue]) {
        case 1:
            return CHAccountZsType;
            break;
        case 2:
            return CHAccountHjType;
            break;
        case 3:
            return CHAccountByType;
            break;
        default:
            break;
    }
    return 0;
}
/**
 *  当一个对象要归档进沙盒中时，就会调用这个方法
 *  目的：在这个方法中说明这个对象的哪些属性要存进沙盒
 */
- (void)encodeWithCoder:(NSCoder *)encoder
{
    //基本信息
    [encoder encodeObject:self.userid forKey:@"userid"];
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.avatar forKey:@"avator"];
    [encoder encodeObject:self.phonenumber forKey:@"phonenumber"];
    
    //接口token
    [encoder encodeObject:self.userToken forKey:@"userToken"];
    [encoder encodeObject:self.created_time forKey:@"created_time"];
    [encoder encodeObject:self.expires_in forKey:@"expires_in"];
    
    //其他信息
    [encoder encodeObject:self.type forKey:@"type"];
    [encoder encodeObject:self.last_date forKey:@"last_date"];
    [encoder encodeObject:self.yokecount forKey:@"yokecount"];
    [encoder encodeObject:self.cityname forKey:@"cityname"];
    [encoder encodeObject:self.cityid forKey:@"cityid"];

}

/**
 *  当从沙盒中解档一个对象时（从沙盒中加载一个对象时），就会调用这个方法
 *  目的：在这个方法中说明沙盒中的属性该怎么解析（需要取出哪些属性）
 */
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.userid = [decoder decodeObjectForKey:@"userid"];
        self.name = [decoder decodeObjectForKey:@"name"];
        self.avatar = [decoder decodeObjectForKey:@"avator"];
        self.phonenumber = [decoder decodeObjectForKey:@"phonenumber"];
        
        //接口token
        self.userToken = [decoder decodeObjectForKey:@"userToken"];
        self.created_time = [decoder decodeObjectForKey:@"created_time"];
        self.expires_in = [decoder decodeObjectForKey:@"expires_in"];
        
        self.type = [decoder decodeObjectForKey:@"type"];
        self.last_date = [decoder decodeObjectForKey:@"last_date"];
        self.yokecount = [decoder decodeObjectForKey:@"yokecount"];
        self.cityname = [decoder decodeObjectForKey:@"cityname"];
        self.cityid = [decoder decodeObjectForKey:@"cityid"];
    }
    return self;
}

@end
