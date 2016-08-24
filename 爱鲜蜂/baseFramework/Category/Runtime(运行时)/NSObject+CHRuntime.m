//
//  NSObject+CHRuntime.m
//  baseFramework
//
//  Created by chenangel on 16/5/27.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "NSObject+CHRuntime.h"
#import <objc/runtime.h>

@implementation NSObject (CHRuntime)
+ (IMP)sf_swizzleInstanceMethod:(SEL)originalSelector withMethod:(SEL)newSelector {
    Method originalMethod = class_getInstanceMethod(self, originalSelector);
    Method newMethod = class_getInstanceMethod(self, newSelector);
    
    if (originalMethod && newMethod) {
        IMP originalIMP = method_getImplementation(originalMethod);
        if (class_addMethod(self, originalSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))) {
            class_replaceMethod(self, newSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, newMethod);
        }
        return originalIMP;
    }
    return NULL;
}

#pragma mark -- 遍历成员变量
+ (NSDictionary *)objcPropertiesOfClass:(Class)clss stepController:(BOOL(^)(Class tmpClass, BOOL *stop))stepController {
    NSMutableDictionary *list = [NSMutableDictionary dictionary];
    
    Class tmpClass = clss;
    while (tmpClass) {
        if (stepController) {
            BOOL stop = NO;
            while (tmpClass && !stepController(tmpClass, &stop)) {
                if (stop) {
                    break;
                }
                tmpClass = class_getSuperclass(tmpClass);
            }
            if (stop) {
                break;
            }
        }
        
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList(tmpClass, &count);
        for (NSInteger i = 0; i < count; ++i) {
            Ivar ivar = ivars[i];
            const char *name =ivar_getName(ivar);
            const char *type = ivar_getTypeEncoding(ivar);
            [list setObject:[NSString stringWithUTF8String:name] forKey:[NSString stringWithUTF8String:type]];
        }
        
        tmpClass = class_getSuperclass(tmpClass);
    }
    
    return list;
}
/** 简单的打印 */
/** 运行时打印对象成员变量 */
- (void)runtimeObj:(Class)name{
    unsigned int count = 0;
    //获得所有成员变量
    Ivar *ivars = class_copyIvarList([name class], &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        const char *name =ivar_getName(ivar);
        const char *type = ivar_getTypeEncoding(ivar);
        NSLog(@"ivar---%d %s %s", i, name, type);
    }
}

#pragma mark -- 利用运行时快速进行模型归档和解档
- (void)encode:(NSCoder *)aCoder {
    // 一层层父类往上查找，对父类的属性执行归解档方法
    Class c = self.class;
    while (c &&c != [NSObject class]) {
        
        unsigned int outCount = 0;
        Ivar *ivars = class_copyIvarList([self class], &outCount);
        for (int i = 0; i < outCount; i++) {
            Ivar ivar = ivars[i];
            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
            
            // 如果有实现该方法再去调用c
            if ([self respondsToSelector:@selector(ignoredNames)]) {
                if ([[self ignoredNames] containsObject:key]) continue;
            }
            
            id value = [self valueForKeyPath:key];
            [aCoder encodeObject:value forKey:key];
        }
        free(ivars);
        c = [c superclass];
    }
}

- (void)decode:(NSCoder *)aDecoder {
    // 一层层父类往上查找，对父类的属性执行归解档方法
    Class c = self.class;
    while (c &&c != [NSObject class]) {
        
        unsigned int outCount = 0;
        Ivar *ivars = class_copyIvarList(c, &outCount);
        for (int i = 0; i < outCount; i++) {
            Ivar ivar = ivars[i];
            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
            
            // 如果有实现该方法再去调用
            if ([self respondsToSelector:@selector(ignoredNames)]) {
                if ([[self ignoredNames] containsObject:key]) continue;
            }
            
            id value = [aDecoder decodeObjectForKey:key];
            [self setValue:value forKey:key];
        }
        free(ivars);
        c = [c superclass];
    }
    
}


@end
