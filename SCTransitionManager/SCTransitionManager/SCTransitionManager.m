//
//  SCTransitionManager.m
//  SCTransitionManager
//
//  Created by sichenwang on 16/2/5.
//  Copyright © 2016年 sichenwang. All rights reserved.
//

#import "SCTransitionManager.h"
#import "SCTransition.h"
#import <objc/runtime.h>

@implementation SCTransitionManager

+ (SCTransitionManager *)sharedInstance {
    static SCTransitionManager *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[SCTransitionManager alloc] init];
    });
    return shared;
}

static const void *Transition = &Transition;
- (void)presentViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^)())completion {
    if (viewController == nil) {
        return;
    }
    UIView *swipeBackView = nil;
    if ([viewController isKindOfClass:[UINavigationController class]] &&
        ((UINavigationController *)viewController).viewControllers.count) {
        UIViewController *rootVC = ((UINavigationController *)viewController).viewControllers.firstObject;
        swipeBackView = rootVC.view;
    } else {
        swipeBackView = viewController.view;
    }
    SCTransition *transition = [[SCTransition alloc] initWithView:swipeBackView];
    viewController.transitioningDelegate = transition;
    objc_setAssociatedObject(viewController, &Transition, transition, OBJC_ASSOCIATION_RETAIN);
    
    UIViewController *topViewController = self.topViewController;
    if (!topViewController.isBeingDismissed &&
        !topViewController.isBeingPresented) {
        [topViewController presentViewController:viewController animated:animated completion:completion];
    }
}

- (void)dismissViewControllerAnimated:(BOOL)animated completion:(void (^)())completion {
    UIViewController *topViewController = self.topViewController;
    if (!topViewController.isBeingDismissed &&
        !topViewController.isBeingPresented) {
        [topViewController dismissViewControllerAnimated:animated completion:completion];
    }
}

- (UIViewController *)topViewController {
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
