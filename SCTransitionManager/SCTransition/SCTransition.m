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
#import "UIView+Capture.h"
#import "SCTransitionManager.h"

@implementation SCTransition

+ (void)presentViewController:(UIViewController *)viewController
                     animated:(BOOL)animated
                   completion:(void (^)())completion {
    if (viewController == nil) {
        return;
    }
    UIView *rootView = [self rootView:viewController];
    SCTransitionManager *transMgr = [[SCTransitionManager alloc] initWithView:rootView isPush:NO];
    viewController.transitioningDelegate = transMgr;
    objc_setAssociatedObject(viewController, TransitionKey, transMgr, OBJC_ASSOCIATION_RETAIN);
    
    UIViewController *topViewController = self.topViewController;
    if (!topViewController.isBeingDismissed &&
        !topViewController.isBeingPresented) {
        [topViewController presentViewController:viewController animated:animated completion:completion];
    }
}

+ (void)presentViewController:(UIViewController *)viewController
                   sourceView:(UIView *)sourceView
                   targetView:(UIView *)targetView
                     animated:(BOOL)animated
                   completion:(void (^)())completion {
    if (viewController == nil) {
        return;
    }
    UIView *rootView = [self rootView:viewController];
    
    SCTransitionManager *transMgr = [[SCTransitionManager alloc] initWithView:rootView sourceView:sourceView targetView:targetView isPush:NO];
    
    viewController.transitioningDelegate = transMgr;
    objc_setAssociatedObject(viewController, TransitionKey, transMgr, OBJC_ASSOCIATION_RETAIN);
    
    UIViewController *topViewController = self.topViewController;
    if (!topViewController.isBeingDismissed &&
        !topViewController.isBeingPresented) {
        [topViewController presentViewController:viewController animated:animated completion:completion];
    }
}

+ (void)dismissViewControllerAnimated:(BOOL)animated completion:(void (^)())completion {
    UIViewController *topViewController = self.topViewController;
    if (!topViewController.isBeingDismissed &&
        !topViewController.isBeingPresented) {
        [topViewController.presentingViewController dismissViewControllerAnimated:animated completion:completion];
    }
}

+ (void)dismissToViewController:(UIViewController *)viewController
                       animated:(BOOL)animated
                     completion:(void (^)())completion{
    UIViewController *topViewController = self.topViewController;
    UIViewController *vcToDismiss = viewController.presentedViewController;
    
    if (vcToDismiss != nil &&
        !vcToDismiss.isBeingDismissed &&
        !vcToDismiss.isBeingPresented) {
        vcToDismiss.view = topViewController.view.captureView;
        SCTransitionManager *transMgr = (SCTransitionManager *)vcToDismiss.transitioningDelegate;
        if (transMgr.type == SCTransitionTypeZoom) {
            SCTransitionManager *newTransMgr = [[SCTransitionManager alloc] initWithView:nil isPush:NO];
            vcToDismiss.transitioningDelegate = newTransMgr;
        }
        [viewController dismissViewControllerAnimated:animated completion:completion];
    }
}

+ (void)dismissToRootViewControllerAnimated:(BOOL)animated
                                 completion:(void (^)())completion {
    UIViewController *topViewController = self.topViewController;
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *vcToDismiss = rootVC.presentedViewController;

    if (vcToDismiss != nil &&
        !vcToDismiss.isBeingDismissed &&
        !vcToDismiss.isBeingPresented) {
        if (![vcToDismiss isEqual:topViewController]) {
            vcToDismiss.view = topViewController.view.captureView;
            SCTransitionManager *transMgr = (SCTransitionManager *)vcToDismiss.transitioningDelegate;
            if (transMgr.type == SCTransitionTypeZoom) {
                SCTransitionManager *newTransMgr = [[SCTransitionManager alloc] initWithView:nil isPush:NO];
                vcToDismiss.transitioningDelegate = newTransMgr;
            }
        }
        [rootVC dismissViewControllerAnimated:animated completion:completion];
    }
}

+ (void)pushViewController:(UIViewController *)viewController
                  animated:(BOOL)animated {
    if (viewController == nil) {
        return;
    }
    UIView *rootView = [self rootView:viewController];
    
    UINavigationController *topViewController = (UINavigationController *)self.topViewController;
    if ([topViewController isKindOfClass:[UINavigationController class]]) {
        SCTransitionManager *transMgr = [[SCTransitionManager alloc] initWithView:rootView isPush:YES];
        topViewController.delegate = transMgr;
        objc_setAssociatedObject(viewController, TransitionKey, transMgr, OBJC_ASSOCIATION_RETAIN);
        [topViewController pushViewController:viewController animated:animated];
    }
}

+ (void)pushViewController:(UIViewController *)viewController
                sourceView:(UIView *)sourceView
                targetView:(UIView *)targetView
                  animated:(BOOL)animated {
    if (viewController == nil) {
        return;
    }
    UIView *rootView = [self rootView:viewController];
    
    UINavigationController *topViewController = (UINavigationController *)self.topViewController;
    if ([topViewController isKindOfClass:[UINavigationController class]]) {
        SCTransitionManager *transMgr = [[SCTransitionManager alloc] initWithView:rootView sourceView:sourceView targetView:targetView isPush:YES];
        topViewController.delegate = transMgr;
        objc_setAssociatedObject(viewController, TransitionKey, transMgr, OBJC_ASSOCIATION_RETAIN);
        [topViewController pushViewController:viewController animated:animated];
    }
}

+ (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    UINavigationController *topViewController = (UINavigationController *)self.topViewController;
    if ([topViewController isKindOfClass:[UINavigationController class]] &&
        topViewController.viewControllers.count > 1) {
        return [topViewController popViewControllerAnimated:animated];
    } else {
        return nil;
    }
}


+ (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    UINavigationController *topViewController = (UINavigationController *)self.topViewController;
    if ([topViewController isKindOfClass:[UINavigationController class]] &&
        topViewController.viewControllers.count > 1) {
        SCTransitionManager *transMgr = (SCTransitionManager *)topViewController.delegate;
        if (transMgr.type == SCTransitionTypeZoom) {
            SCTransitionManager *newTransMgr = [[SCTransitionManager alloc] initWithView:nil isPush:YES];
            topViewController.delegate = newTransMgr;
        }
        return [topViewController popToViewController:viewController animated:animated];
    } else {
        return nil;
    }
}

+ (NSArray *)popToRootViewControllerAnimated:(BOOL)animated {
    UINavigationController *topViewController = (UINavigationController *)self.topViewController;
    if ([topViewController isKindOfClass:[UINavigationController class]] &&
        topViewController.viewControllers.count > 1) {
        SCTransitionManager *transMgr = (SCTransitionManager *)topViewController.delegate;
        if (transMgr.type == SCTransitionTypeZoom) {
            SCTransitionManager *newTransMgr = [[SCTransitionManager alloc] initWithView:nil isPush:YES];
            topViewController.delegate = newTransMgr;
        }
        return [topViewController popToRootViewControllerAnimated:animated];
    } else {
        return nil;
    }
}

#pragma mark - Private Method

+ (UIView *)rootView:(UIViewController *)viewController {
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
