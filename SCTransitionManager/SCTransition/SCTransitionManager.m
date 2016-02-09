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

- (instancetype)initWithSwipeBackView:(UIView *)swipeBackView {
    if (self = [super init]) {
        _type = SCTransitionTypeNormal;
        _normalPresentTrans = [[SCNormalPresentTransition alloc] init];
        _normalDismissTrans = [[SCNormalDismissTransition alloc] init];
        _interactionController = [[SCSwipeBackInteractionController alloc] initWithView:swipeBackView];
        SCGestureTransitionBackContext *context = [[SCGestureTransitionBackContext alloc] init];
        _interactionController.context = context;
        _normalDismissTrans.context = context;
    }
    return self;
}

- (instancetype)initWithSwipeBackView:(UIView *)swipeBackView
                                 view:(UIView *)view
                           sourceView:(UIView *)sourceView
                           targetView:(UIView *)targetView
                          targetFrame:(CGRect)targetFrame
                           completion:(void (^)())completion {
    if (self = [super init]) {
        _type = SCTransitionTypeZoom;
        _zoomPresentTrans = [[SCZoomPresentTransition alloc] init];
        _zoomPresentTrans.sourceView = sourceView;
        _zoomPresentTrans.targetFrame = targetFrame;
        _zoomPresentTrans.view = view;
        _zoomDismissTrans = [[SCZoomDismissTransition alloc] init];
        _zoomDismissTrans.sourceView = targetView;
        _zoomDismissTrans.view = swipeBackView;
        _zoomDismissTrans.destinationView = view;
        _zoomDismissTrans.targetView = sourceView;
        _interactionController = [[SCSwipeBackInteractionController alloc] initWithView:swipeBackView];
        SCGestureTransitionBackContext *context = [[SCGestureTransitionBackContext alloc] init];
        _interactionController.context = context;
        _zoomDismissTrans.context = context;
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

@end
