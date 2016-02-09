//
//  SCTransition.m
//  SCTransitionManager
//
//  Created by sichenwang on 16/2/7.
//  Copyright © 2016年 sichenwang. All rights reserved.
//

#import "SCTransition.h"
#import "SCPresentTransition.h"
#import "SCDismissTransition.h"
#import "SCPinterestPushTransition.h"
#import "SCPinterestPopTransition.h"
#import "SCGestureTransitionBackContext.h"
#import "SCSwipeBackInteractionController.h"


typedef enum {
    SCTransitionTypeNormal,
    SCTransitionTypePinterest
} SCTransitionType;

@interface SCTransition()

@property (nonatomic, assign) SCTransitionType type;
@property (nonatomic, strong) SCPresentTransition *presentTransition;
@property (nonatomic, strong) SCPinterestPushTransition *pinterestPushTransition;
@property (nonatomic, strong) SCDismissTransition *dismissTransition;
@property (nonatomic, strong) SCPinterestPopTransition *pinterestPopTransition;
@property (nonatomic, strong) SCSwipeBackInteractionController *interactionController;

@end

@implementation SCTransition

- (instancetype)initWithSwipeBackView:(UIView *)swipeBackView {
    if (self = [super init]) {
        _type = SCTransitionTypeNormal;
        _presentTransition = [[SCPresentTransition alloc] init];
        _dismissTransition = [[SCDismissTransition alloc] init];
        _interactionController = [[SCSwipeBackInteractionController alloc] initWithView:swipeBackView];
        SCGestureTransitionBackContext *context = [[SCGestureTransitionBackContext alloc] init];
        _interactionController.context = context;
        _dismissTransition.context = context;
    }
    return self;
}

- (instancetype)initWithSwipeBackView:(UIView *)swipeBackView
                           sourceView:(UIView *)sourceView
                             sourceVC:(UIViewController *)sourceVC
                          sourceFrame:(CGRect)sourceFrmae
                           targetView:(UIView *)targetView
                             targetVC:(UIViewController *)targetVC
                          targetFrame:(CGRect)targetFrame
                           completion:(void (^)())completion {
    if (self = [super init]) {
        _type = SCTransitionTypePinterest;
        _pinterestPushTransition = [[SCPinterestPushTransition alloc] init];
        _pinterestPushTransition.sourceView = sourceView;
        _pinterestPushTransition.targetFrame = targetFrame;
        _pinterestPushTransition.sourceViewController = sourceVC;
        _pinterestPopTransition = [[SCPinterestPopTransition alloc] init];
        _pinterestPopTransition.sourceView = targetView;
        _pinterestPopTransition.targetFrame = sourceFrmae;
        _pinterestPopTransition.sourceViewController = targetVC;
        _pinterestPopTransition.destinationViewController = sourceVC;
        _pinterestPopTransition.destinationView = sourceView;
        _interactionController = [[SCSwipeBackInteractionController alloc] initWithView:swipeBackView];
        SCGestureTransitionBackContext *context = [[SCGestureTransitionBackContext alloc] init];
        _interactionController.context = context;
        _pinterestPopTransition.context = context;
    }
    return self;
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    if (self.type == SCTransitionTypePinterest) {
        return self.pinterestPushTransition;
    } else {
        return self.presentTransition;
    }
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    if (self.type == SCTransitionTypePinterest) {
        return self.pinterestPopTransition;
    } else {
        return self.dismissTransition;
    }
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
    return self.interactionController.interactionInProgress ? self.interactionController : nil;
}

@end
