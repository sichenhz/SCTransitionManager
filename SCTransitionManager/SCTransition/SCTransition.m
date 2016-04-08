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

@implementation SCTransition

#pragma mark - Setter

+ (void)setDismissCompletion:(void (^)())completion {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIViewController *vcToDismiss = self.topViewController;
        SCTransitionManager *transMgr = (SCTransitionManager *)vcToDismiss.transitioningDelegate;
        transMgr.didDismiss = completion ? : nil;
    });
}

+ (void)setPopCompletion:(void (^)())completion {
    dispatch_async(dispatch_get_main_queue(), ^{
        UINavigationController *topViewController = (UINavigationController *)self.topViewController;
        if ([topViewController isKindOfClass:[UINavigationController class]] &&
            topViewController.viewControllers.count > 1) {
            SCTransitionManager *transMgr = (SCTransitionManager *)topViewController.delegate;
            transMgr.didPop = completion ? : nil;
        }
    });
}

#pragma mark - Present

+ (void)presentViewController:(UIViewController *)viewController {
    [self presentViewController:viewController animated:YES completion:nil];
}

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

#pragma mark - Dismiss

+ (void)dismissViewControllerAnimated:(BOOL)animated {
    UIViewController *vcToDismiss = self.topViewController;
    SCTransitionManager *transMgr = (SCTransitionManager *)vcToDismiss.transitioningDelegate;
    if (!vcToDismiss.isBeingDismissed &&
        !vcToDismiss.isBeingPresented) {
        [vcToDismiss dismissViewControllerAnimated:animated completion:transMgr.didDismiss];
    }
}

+ (void)dismissToViewController:(UIViewController *)viewController
                       animated:(BOOL)animated
                     completion:(void (^)())completion {
    UIViewController *topViewController = self.topViewController;
    UIViewController *vcToDismiss = viewController.presentedViewController;
    
    if (vcToDismiss != nil &&
        !vcToDismiss.isBeingDismissed &&
        !vcToDismiss.isBeingPresented) {
        vcToDismiss.view = topViewController.view.captureView;
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
        }
        [rootVC dismissViewControllerAnimated:animated completion:completion];
    }
}

#pragma mark - Push

+ (void)pushViewController:(UIViewController *)viewController {
    [self pushViewController:viewController animated:YES completion:nil];
}

+ (void)pushViewController:(UIViewController *)viewController
                  animated:(BOOL)animated
                completion:(void (^)())completion {
    if (viewController == nil) {
        return;
    }
    UIView *rootView = [self rootView:viewController];
    
    UINavigationController *topViewController = (UINavigationController *)self.topViewController;
    if ([topViewController isKindOfClass:[UINavigationController class]]) {
        SCTransitionManager *transMgr = [[SCTransitionManager alloc] initWithView:rootView isPush:YES];
        transMgr.didPush = completion ? : nil;
        topViewController.delegate = transMgr;
        objc_setAssociatedObject(viewController, TransitionKey, transMgr, OBJC_ASSOCIATION_RETAIN);
        [topViewController pushViewController:viewController animated:animated];
    }
}

+ (void)pushViewController:(UIViewController *)viewController
                sourceView:(UIView *)sourceView
                targetView:(UIView *)targetView
                  animated:(BOOL)animated
                completion:(void (^)())completion {
    if (viewController == nil) {
        return;
    }
    UIView *rootView = [self rootView:viewController];
    
    UINavigationController *topViewController = (UINavigationController *)self.topViewController;
    if ([topViewController isKindOfClass:[UINavigationController class]]) {
        SCTransitionManager *transMgr = [[SCTransitionManager alloc] initWithView:rootView sourceView:sourceView targetView:targetView isPush:YES];
        transMgr.didPush = completion ? : nil;
        topViewController.delegate = transMgr;
        objc_setAssociatedObject(viewController, TransitionKey, transMgr, OBJC_ASSOCIATION_RETAIN);
        [topViewController pushViewController:viewController animated:animated];
    }
}

#pragma mark - Pop

+ (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    UINavigationController *topViewController = (UINavigationController *)self.topViewController;
    if ([topViewController isKindOfClass:[UINavigationController class]] &&
        topViewController.viewControllers.count > 1) {
        SCTransitionManager *transMgr = (SCTransitionManager *)topViewController.delegate;
        transMgr.didPop = transMgr.didPop ? : nil;
        return [topViewController popViewControllerAnimated:animated];
    }
    return nil;
}

+ (NSArray *)popToViewController:(UIViewController *)viewController
                        animated:(BOOL)animated
                      completion:(void (^)())completion {
    UINavigationController *topViewController = (UINavigationController *)self.topViewController;
    if ([topViewController isKindOfClass:[UINavigationController class]] &&
        topViewController.viewControllers.count > 1) {
        SCTransitionManager *transMgr = (SCTransitionManager *)topViewController.delegate;
        transMgr.didPop = completion ? : nil;
        return [topViewController popToViewController:viewController animated:animated];
    }
    return nil;
}

+ (NSArray *)popToRootViewControllerAnimated:(BOOL)animated
                                  completion:(void (^)())completion {
    UINavigationController *topViewController = (UINavigationController *)self.topViewController;
    if ([topViewController isKindOfClass:[UINavigationController class]] &&
        topViewController.viewControllers.count > 1) {
        SCTransitionManager *transMgr = (SCTransitionManager *)topViewController.delegate;
        transMgr.didPop = completion ? : nil;
        return [topViewController popToRootViewControllerAnimated:animated];
    }
    return nil;
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
