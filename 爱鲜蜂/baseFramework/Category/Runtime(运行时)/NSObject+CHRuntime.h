//
//  NSObject+CHRuntime.h
//  baseFramework
//
//  Created by chenangel on 16/5/27.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (CHRuntime)

//交换方法
+ (IMP)sf_swizzleInstanceMethod:(SEL)originalSelector withMethod:(SEL)newSelector;

#pragma mark -- 遍历成员变量
/** 类方法 遍历所有的成员变量的总方法
 classDecider: if return NO, tmpClass will be ignored, if *stop set to YES, searching will be stoped immediately
 */
+ (NSDictionary *)objcPropertiesOfClass:(Class)clss stepController:(BOOL(^)(Class tmpClass, BOOL *stop))stepController;

/** 运行时对象的打印 */
- (void)runtimeObj:(Class)name;

#pragma mark -- 利用运行时快速进行模型归档和解档
/**第一步 设置模型解档和归档时要忽略的属性 */
- (NSArray *)ignoredNames;
/**第二部 归档 */
- (void)encode:(NSCoder *)aCoder;
/**第三部 解档 */
- (void)decode:(NSCoder *)aDecoder;

#define CHCodingImplementation \
- (instancetype)initWithCoder:(NSCoder *)decoder \
{ \
if (self = [super init]) { \
[self decode:decoder]; \
} \
return self; \
} \
\
- (void)encodeWithCoder:(NSCoder *)encoder \
{ \
[self encode:encoder]; \
}

/**
 *  // 设置需要忽略的属性
 - (NSArray *)ignoredNames {
 return @[@"bone"];
 }
 
 // 在系统方法内来调用我们的方法
 - (instancetype)initWithCoder:(NSCoder *)aDecoder {
 if (self = [super init]) {
 [self decode:aDecoder];
 }
 return self;
 }
 
 - (void)encodeWithCoder:(NSCoder *)aCoder {
 [self encode:aCoder];
 }
 */
/******************* MJExtension的封装 ********************/



@end
