//
//  UITabBar+Runtime.m
//  CHTabbarDemo
//
//  Created by chenangel on 16/5/31.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "UITabBar+Runtime.h"
#import <objc/runtime.h>
#import "AppDelegate.h"
@interface UITabBar()
/** 徽章的字典 */
@property (nonatomic,strong)NSMutableDictionary *badgeValues;
@end
@implementation UITabBar (Runtime)
/** 静态 运行时交换方法 */
/**
 *  一般交换方法有两种，一种是直接替换类型，一种是直接交换！
 *
 *  @param originalSelector originalSelector 原始方法
 *  @param swizzledSelector swizzledSelector 要交换的方法
 *  @param class            class 要交换方法的类
 */
static void ExchangedMethod(SEL originalSelector,SEL swizzledSelector,Class class){
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    /** 查看类型是否可以直接覆盖 */
    BOOL didAddMethod = class_addMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    /**根据didaddmethod是否交换*/
    if (didAddMethod) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }else{//如果不能覆盖则直接交换
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}
/** 初始化加载load的时候运行 */
//----------》已加入就会运行，要调用此方法的话可以开启

//+ (void)load{//初始化的时候直接交换方法
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        Class class =[self class];
//        //交换自动布局的方法
//        ExchangedMethod(@selector(layoutSubviews), @selector(ch_layoutSubviews), class);
//        //交换屏幕触发事件的方法
//        ExchangedMethod(@selector(touchesBegan:withEvent:), @selector(ch_touchesBegan:withEvent:), class);
//        //交换hit点击最佳事件的方法
//        ExchangedMethod(@selector(hitTest:withEvent:), @selector(ch_hitTest:withEvent:), class);
//    });
//}


/** 重写set和get运行时添加徽章属性 */
-(NSMutableDictionary *)badgeValues{
    return objc_getAssociatedObject(self, @selector(badgeValues));
}
-(void)setBadgeValues:(NSMutableDictionary *)badgeValues{
    objc_setAssociatedObject(self, @selector(badgeValues), badgeValues, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
/** 调用自定义的自动布局方法 */
- (void)ch_layoutSubviews{
    [self ch_layoutSubviews];
    NSInteger index = 0;
    //按钮线上的距离、和按钮底部文字的高度
    CGFloat space = 12,tabBarButtonLabelHeight = 16;
    //遍历两次，第一次找出tabbarButton,第二次遍历tabbarButton内部的交替图片、文字、徽章
    for (UIView *childView in self.subviews) {
        if (![childView isKindOfClass:NSClassFromString(@"UITabBarButton")]) {continue;}
        //tabbar选中的指示器图片
        self.selectionIndicatorImage = [[UIImage alloc]init];
        [self bringSubviewToFront:childView];
        
        UIView *tabBarImageView,*tabBarButtonLabel,*tabBarBadgeView;
        for (UIView *cTabBarItem in childView.subviews) {
            if ([cTabBarItem isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
                tabBarImageView = cTabBarItem;
            }
            else if([cTabBarItem isKindOfClass:NSClassFromString(@"UITabBarButtonLabel")]){
                tabBarButtonLabel = cTabBarItem;
            }
            else if([cTabBarItem isKindOfClass:NSClassFromString(@"_UIBadgeView")]){
                tabBarBadgeView = cTabBarItem;
            }
        }
        
        NSString *tabBarButtonLabelText = ((UILabel *)tabBarButtonLabel).text;
        //计算tabbar按钮自身的高度 “减去” 每个按钮文字和图片的总高度 == y
        CGFloat y = CGRectGetHeight(self.bounds) - (CGRectGetHeight(tabBarButtonLabel.bounds) + CGRectGetHeight(tabBarImageView.bounds));
        if(y < 0){//按钮文字和图片超出了范围
            if (!tabBarButtonLabelText.length) {
                space -= tabBarButtonLabelHeight;
            }else{
                space = 12;
            }
            /** 中间按钮的位置 */
            childView.frame = CGRectMake(childView.frame.origin.x, y - space, childView.frame.size.width, childView.frame.size.height-y+space);
            
        }else{//没有超出范围,则让space最小
            space = MIN(space, y);}
        //计算徽章的宽高\X偏移、Y偏移
        CGFloat badgeW_H = 8;
        CGFloat bandgeX = CGRectGetMaxX(childView.frame) - (CGRectGetWidth(childView.frame) - CGRectGetWidth(tabBarImageView.frame) - badgeW_H) /2.0;
        CGFloat bandgeY = y < 0? CGRectGetWidth(childView.frame) + 10:CGRectGetMinY(childView.frame)+8;
        if(!self.badgeValues)
            self.badgeValues = [NSMutableDictionary dictionary];
        
        NSString *key = @(index).stringValue;
        UILabel *currentBadgeValue = self.badgeValues[key];
        
        if (tabBarBadgeView && y <0 && CGRectGetWidth(self.frame)>0 && CGRectGetHeight(self.frame)>0){//如果tababr图片超出了范围
            tabBarBadgeView.hidden = YES;
            if (!currentBadgeValue){//如果当前徽章没有被加入徽章的字典,则加入----》目的是避开重复添加徽章
                currentBadgeValue = [self cloneBadgeViewWithOldBadge:tabBarBadgeView];
                self.badgeValues[key] = currentBadgeValue;
            }
            
            CGSize size = [currentBadgeValue.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 18) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:currentBadgeValue.font} context:nil].size;
            currentBadgeValue.frame = CGRectMake((bandgeX - (ceilf(size.width))+20)/2, bandgeY, ceilf(size.width)+10, CGRectGetHeight(currentBadgeValue.frame)+20);
            [self addSubview:currentBadgeValue];
        }else{//如果没有超出范围,则直接从键值对取消
            if (currentBadgeValue) {
                [currentBadgeValue removeFromSuperview];
                [self.badgeValues removeObjectForKey:key];
            }
        }
        
        index++;
    }
}
/** 克隆复制徽章的标签的值 */
- (UILabel *)cloneBadgeViewWithOldBadge:(UIView *)badgeView{
    if (!badgeView) {//如果徽章没有则返回空
        return nil;
    }
    UILabel *oldLabel;
    for (UIView *cView in badgeView.subviews) {//查找有没有徽章label，有则直接返回就的label，没有则退出执行下一步
        if ([cView isKindOfClass:[UILabel class]]) {
            oldLabel = (UILabel *)cView;
            break;
        }
    }
    
    UILabel *newLabel = [[UILabel alloc]init];
    newLabel.text = oldLabel.text;
    newLabel.font = oldLabel.font;
    CGSize size = [newLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 18) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:oldLabel.font} context:nil].size;
    //ceilf：向下取整
    newLabel.frame = CGRectMake(0, 0, ceilf(size.width)+10, size.height);
    newLabel.textColor = [UIColor whiteColor];
    newLabel.textAlignment = NSTextAlignmentCenter;
    newLabel.backgroundColor = [UIColor redColor];
    newLabel.layer.masksToBounds = YES;
    newLabel.layer.cornerRadius = CGRectGetHeight(newLabel.frame) / 2;
    return newLabel;
}
/** 屏幕触发点击的方法*/
-(void)ch_touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self ch_touchesBegan:touches withEvent:event];
    NSSet *alltouches = [event allTouches];
    UITouch *touch = [alltouches anyObject];
    CGPoint point = [touch locationInView:[touch view]];
    
    NSInteger tabCount = 0;
    for (UIView *childView in self.subviews) {
        if (![childView isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            continue;
        }
        tabCount++;
    }
    //根据按钮个数算出每块按钮的平均宽度，然后用偏移位置X 除以 平均宽度，得到的整数就当前的索引
    CGFloat width = [UIScreen mainScreen].bounds.size.height / tabCount;
    NSUInteger clickIndex = point.x / (NSUInteger)width;
    
    //前提是tabbarController 是根控制器
    UITabBarController *controller = (UITabBarController *)[(AppDelegate *)[[UIApplication sharedApplication] delegate] window].rootViewController;
            [controller setSelectedIndex:clickIndex];
    
}
/** 事件传递经过的hitTest方法 */
-(UIView *)ch_hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
    if (!self.clipsToBounds && !self.hidden &&self.alpha > 0) {//判断当前视图结构层是否符合要求
        //符合后则从后往前查找最合适视图层
        UIView *result = [super hitTest:point withEvent:event];
        if (result) {
            return result;
        }else{
            for (UIView *subview in self.subviews.reverseObjectEnumerator) {
                CGPoint subPoint = [subview convertPoint:point fromView:self];
                result =[subview hitTest:subPoint withEvent:event];
                if (result) {
                    return result;
                }
                
            }
        }
    }
    return nil;
}

@end

