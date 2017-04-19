//
//  UIViewController+Active.m
//
//  Created by JuLiaoyuan on 16/8/18.
//  Copyright © 2016年 Spark. All rights reserved.
//

#import "UIViewController+LYActive.h"

@implementation UIViewController (LYActive)

+ (UIViewController *)activeViewController {
    UIViewController *viewController = [[UIViewController alloc] init];
    id rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [viewController activeViewController:rootVC];
}
- (UIViewController *)activeViewController:(id)viewController {
    if ([viewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tab = (UITabBarController *)viewController;
        return [self activeViewController:tab.selectedViewController];
    }
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)viewController;
        return [nav visibleViewController];
    }
    if ([viewController isKindOfClass:[UIViewController class]]) {
        UIViewController *active = viewController;
        while (active.presentedViewController) {
            active = active.presentedViewController;
        }
        return active;
    }
    return nil;
}
@end
