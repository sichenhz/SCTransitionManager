//
//  SCTransition.m
//  SCTransitionManager
//
//  Created by sichenwang on 16/2/7.
//  Copyright © 2016年 sichenwang. All rights reserved.
//

#import "SCTransition.h"
#import "SCTransitionManager.h"
#import <objc/runtime.h>

@implementation SCTransition

static const void *Transition = &Transition;

+ (void)presentViewController:(UIViewController *)viewController
                     animated:(BOOL)animated
                   completion:(void (^)())completion {
    if (viewController == nil) {
        return;
    }
    UIView *swipeBackView = [self swipeBackView:viewController];
    SCTransitionManager *transMgr = [[SCTransitionManager alloc] initWithSwipeBackView:swipeBackView];
    viewController.transitioningDelegate = transMgr;
    objc_setAssociatedObject(viewController, &Transition, transMgr, OBJC_ASSOCIATION_RETAIN);
    
    UIViewController *topViewController = self.topViewController;
    if (!topViewController.isBeingDismissed &&
        !topViewController.isBeingPresented) {
        [topViewController presentViewController:viewController animated:animated completion:completion];
    }
}

+ (void)presentViewController:(UIViewController *)viewController
                         view:(UIView *)view
                   sourceView:(UIView *)sourceView
                   targetView:(UIView *)targetView
                  targetFrame:(CGRect)targetFrame
                   completion:(void (^)())completion {
    if (viewController == nil) {
        return;
    }
    UIView *swipeBackView = [self swipeBackView:viewController];
    SCTransitionManager *transMgr = [[SCTransitionManager alloc] initWithSwipeBackView:swipeBackView view:view sourceView:sourceView targetView:targetView targetFrame:targetFrame completion:nil];
    
    viewController.transitioningDelegate = transMgr;
    objc_setAssociatedObject(viewController, &Transition, transMgr, OBJC_ASSOCIATION_RETAIN);
    
    UIViewController *topViewController = self.topViewController;
    if (!topViewController.isBeingDismissed &&
        !topViewController.isBeingPresented) {
        [topViewController presentViewController:viewController animated:YES completion:nil];
    }
}

+ (void)dismissViewControllerAnimated:(BOOL)animated completion:(void (^)())completion {
    UIViewController *topViewController = self.topViewController;
    if (!topViewController.isBeingDismissed &&
        !topViewController.isBeingPresented) {
        [topViewController dismissViewControllerAnimated:animated completion:completion];
    }
}

+ (UIView *)swipeBackView:(UIViewController *)viewController {
    if ([viewController isKindOfClass:[UINavigationController class]] &&
        ((UINavigationController *)viewController).viewControllers.count) {
        UIViewController *rootVC = ((UINavigationController *)viewController).viewControllers.firstObject;
        return rootVC.view;
    } else {
        return viewController.view;
    }
}

+ (UIViewController *)topViewController {
    UIViewController *topViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (YES) {
        if ([topViewController presentedViewController] == nil) {
            break;
        }
        topViewController = [topViewController presentedViewController];
    }
    return topViewController;
}

@end
