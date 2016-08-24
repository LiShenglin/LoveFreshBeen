//
//  AnimationTabBarController.m
//  baseFramework
//
//  Created by chenangel on 16/6/24.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "AnimationTabBarController.h"
#import "ShopCarRedDotView.h"
#import "RAMAnimatedTabBarItem.h"
@implementation AnimationTabBarController
- (NSMutableArray *)iconsImageName{
    if (_iconsImageName == nil) {
        _iconsImageName = [NSMutableArray array];
        NSArray *iconsImage = @[@"v2_home", @"v2_order", @"shopCart", @"v2_my"];
        [_iconsImageName addObjectsFromArray:iconsImage];
    }
    return _iconsImageName;
}
- (NSMutableArray *)iconsSelectedImageName{
    if (_iconsSelectedImageName == nil) {
        _iconsSelectedImageName = [NSMutableArray array];
        NSArray *selectImage = @[@"v2_home_r", @"v2_order_r", @"shopCart_r", @"v2_my_r"];
        [_iconsSelectedImageName addObjectsFromArray:selectImage];
    }
    return _iconsSelectedImageName;
}
- (NSMutableArray<IconItem *> *)iconViews{
    if (_iconViews == nil) {
        _iconViews = [NSMutableArray array];
    }
    return _iconViews;
}
- (NSMutableArray *)items{
    if (_items == nil) {
        _items = [NSMutableArray array];
    }
    return _items;
}

- (void)viewDidLoad{
    [super viewDidLoad];
   

    
    [AINotiCenter addObserver:self selector:@selector(searchViewControllerDeinit) name:LFBSearchViewControllerDeinit object:nil];
    
}
- (void)dealloc{
    [AINotiCenter removeObserver:self];
}
//当搜索框退出后，在tabar再次加入购物车徽章
- (void)searchViewControllerDeinit{
    if (self.shopCarIcon != nil) {
        ShopCarRedDotView * redDotView = [ShopCarRedDotView shareShopCarRedDotView];
        redDotView.frame = CGRectMake(21+1, -3, 15, 15);
        [self.shopCarIcon addSubview:redDotView];
    }
}

//创建单个tabbar按钮
- (UIView*)createViewcontainer:(NSInteger)index{
    CGFloat viewWidth = SCREEN_WIDTH / self.items.count;
    CGFloat viewHeight = self.tabBar.bounds.size.height;
    
    UIView * viewContainer = [[UIView alloc]initWithFrame:CGRectMake(viewWidth * index, 0, viewWidth, viewHeight)];
    viewContainer.backgroundColor = [UIColor clearColor];
    viewContainer.userInteractionEnabled = YES;
    
    [self.tabBar addSubview:viewContainer];
    viewContainer.tag = index;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tabBarClick:)];
    [viewContainer addGestureRecognizer:tap];
    
    return viewContainer;
}
- (void)tabBarClick:(UITapGestureRecognizer*)tap{
    CHLog(@"点击了");
}

//创建tabbar数组
- (NSMutableArray *)createViewcontainers{
    
    NSMutableArray *tempcontainersDict = [NSMutableArray array];
    CHLog(@"count总数----%ld",self.tabBar.items.count);
    for (NSInteger index; index < self.items.count; index ++) {
        UIView * view = [self createViewcontainer:index];
        
        [tempcontainersDict addObject:view];
        
    }
    return tempcontainersDict;
}

//创建tababr按钮具体细节，并返回数组
- (void)createCustomIcons:(NSMutableArray *)containersDict{
    if (self.items.count>0) {
        
        for (NSInteger index; index < self.items.count; index ++) {
            RAMAnimatedTabBarItem *item = self.items[index];
            
            //取出每个按钮的容器视图
            UIView * containerView = containersDict[index];
            containerView.tag = index;
            
            //创建并布局按钮图片
            CGFloat imageW = 21.0;
            CGFloat imageH = 21.0;
            CGFloat imageX = ((SCREEN_WIDTH / self.tabBar.items.count) - imageW)* 0.5;
            CGFloat imageY = 8.0;
            
            UIImageView * icon = [[UIImageView alloc]initWithFrame:CGRectMake(imageX, imageY, imageW, imageH)];
            icon.image = item.image;
            icon.tintColor = [UIColor clearColor];
            
            //创建并布局按钮文字
            UILabel * textLabel = [[UILabel alloc]init];
            textLabel.frame = CGRectMake(0, 32, (SCREEN_WIDTH / self.tabBar.items.count), 49 -32);
            textLabel.text = item.title;
            textLabel.backgroundColor = [UIColor clearColor];
            textLabel.font = [UIFont systemFontOfSize:10];
            textLabel.textAlignment = NSTextAlignmentCenter;
            textLabel.textColor = [UIColor grayColor];
            textLabel.translatesAutoresizingMaskIntoConstraints = NO;
            
            [containerView addSubview:icon];
            [containerView addSubview:textLabel];
            
            //给购物车按钮布局徽章
            if (self.tabBar.items) {
                CGFloat textlabelWidth = self.view.frame.size.width / self.items.count;
                textLabel.width = textlabelWidth;
            }
            
            if (index == 2) {
                ShopCarRedDotView *redDotView = [ShopCarRedDotView shareShopCarRedDotView];
                redDotView.frame = CGRectMake(imageW + 1, -3 , 15, 15);
                [icon addSubview:redDotView];
                self.shopCarIcon = icon;
            }
            IconItem * iconitem = [[IconItem alloc]init];
            iconitem.icon = icon;
            iconitem.textLabel = textLabel;
            
            [self.iconViews addObject:iconitem];
        
            item.image = nil;
            item.title = @"";
        
            if (index == 0) {
                self.selectedIndex = 0;
               //[self selectItem:0];
            }
        }
    }
}
//tabbar代理
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    [self setSelectIndexFrom:self.selectedIndex toIndex:item.tag];
}

//按钮选中的效果
- (void)selectItem:(NSInteger)index{
    UIImageView *selectIcon = self.iconViews[index].icon;
    UILabel *textlabel = self.iconViews[index].textLabel;
    selectIcon.image = [UIImage imageNamed:self.iconsSelectedImageName[index]];
    RAMAnimatedTabBarItem * item = self.items[index];
    item.selectedImage = selectIcon.image;
    
    [item selectedAnimationIcon:selectIcon textLabel:textlabel];
}

- (void)setSelectIndexFrom:(NSInteger)fromIndex toIndex:(NSInteger)toIndex{
    
    if (toIndex == 2) {
        id vc = self.childViewControllers[self.selectedIndex];
        //购物车
        UIViewController * shopVC = [[UIViewController alloc]init];
        UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:shopVC];
        [vc presentViewController:nav animated:YES completion:nil];
        return;
    }
    
    self.selectedIndex = toIndex;
    
    UIImageView * fromImage = self.iconViews[fromIndex].icon;
    UILabel *fromLabel = self.iconViews[fromIndex].textLabel;
    
    fromImage.image = [UIImage imageNamed:self.iconsImageName[fromIndex]];
    RAMAnimatedTabBarItem * fromitem = self.items[fromIndex];
    
    [fromitem deselectAnimationIcon:fromImage textLabel:fromLabel defaultTextColor:[UIColor grayColor]];
    
    UIImageView * toImage = self.iconViews[toIndex].icon;
    UILabel * toLabel = self.iconViews[toIndex].textLabel;
    
    toImage.image = [UIImage imageNamed:self.iconsImageName[toIndex]];
    RAMAnimatedTabBarItem * toitem = (RAMAnimatedTabBarItem*)self.items[toIndex];
    [toitem playAnimationIcon:toImage textLabel:toLabel];
    
}


@end
