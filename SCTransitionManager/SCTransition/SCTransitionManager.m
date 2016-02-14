//
//  SCTransitionManager.m
//  SCTransitionManager
//
//  Created by sichenwang on 16/2/5.
//  Copyright © 2016年 sichenwang. All rights reserved.
//

#import "SCTransitionManager.h"
#import "SCNormalPresentTransition.h"
#import "SCNormalDismissTransition.h"
#import "SCZoomPresentTransition.h"
#import "SCZoomDismissTransition.h"
#import "SCGestureTransitionBackContext.h"
#import "SCSwipeBackInteractionController.h"

typedef enum {
    SCTransitionTypeNormal,
    SCTransitionTypeZoom
} SCTransitionType;

@interface SCTransitionManager()

@property (nonatomic, assign) SCTransitionType type;
@property (nonatomic, strong) SCNormalPresentTransition *normalPresentTrans;
@property (nonatomic, strong) SCNormalDismissTransition *normalDismissTrans;
@property (nonatomic, strong) SCZoomPresentTransition *zoomPresentTrans;
@property (nonatomic, strong) SCZoomDismissTransition *zoomDismissTrans;
@property (nonatomic, strong) SCSwipeBackInteractionController *interactionController;

@end

@implementation SCTransitionManager

- (instancetype)initWithView:(UIView *)view {
    if (self = [super init]) {
        _type = SCTransitionTypeNormal;
        _normalPresentTrans = [[SCNormalPresentTransition alloc] init];
        _normalDismissTrans = [[SCNormalDismissTransition alloc] init];
        _interactionController = [[SCSwipeBackInteractionController alloc] initWithView:view];
        SCGestureTransitionBackContext *context = [[SCGestureTransitionBackContext alloc] init];
        _interactionController.context = context;
        _normalDismissTrans.context = context;
    }
    return self;
}

- (instancetype)initWithView:(UIView *)view
                  sourceView:(UIView *)sourceView
                  targetView:(UIView *)targetView {
    if (self = [super init]) {
        _type = SCTransitionTypeZoom;
        UIView *visibleView = self.visibleView;
        _zoomPresentTrans = [[SCZoomPresentTransition alloc] init];
        _zoomDismissTrans = [[SCZoomDismissTransition alloc] init];
        _interactionController = [[SCSwipeBackInteractionController alloc] initWithView:view];
        SCGestureTransitionBackContext *context = [[SCGestureTransitionBackContext alloc] init];
        _interactionController.context = context;
        _zoomDismissTrans.context = context;

        _zoomPresentTrans.sourceView = sourceView;
        _zoomDismissTrans.sourceView = sourceView;
        _zoomPresentTrans.targetView = targetView;
        _zoomDismissTrans.targetView = targetView;
        _zoomPresentTrans.view = visibleView;
        _zoomDismissTrans.view = visibleView;
    }
    return self;
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    if (self.type == SCTransitionTypeZoom) {
        return self.zoomPresentTrans;
    } else {
        return self.normalPresentTrans;
    }
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    if (self.type == SCTransitionTypeZoom) {
        return self.zoomDismissTrans;
    } else {
        return self.normalDismissTrans;
    }
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
    return self.interactionController.interactionInProgress ? self.interactionController : nil;
}

#pragma mark - Private Method

- (UIView *)visibleView {
    UIViewController *topViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (YES) {
        if ([topViewController presentedViewController] == nil) {
            break;
        }
        topViewController = [topViewController presentedViewController];
    }
    if ([topViewController isKindOfClass:[UINavigationController class]] &&
        ((UINavigationController *)topViewController).viewControllers.count) {
        return ((UINavigationController *)topViewController).topViewController.view;
    } else {
        return topViewController.view;
    }
}
@end
