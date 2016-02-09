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

- (instancetype)initWithSwipeBackView:(UIView *)swipeBackView SourceView:(UIView *)sourceview targetFrame:(CGRect)targetFrame sourceVC:(UIViewController *)sourceVC {
    if (self = [super init]) {
        _type = SCTransitionTypePinterest;
        _pinterestPushTransition = [[SCPinterestPushTransition alloc] init];
        _pinterestPushTransition.sourceView = sourceview;
        _pinterestPushTransition.targetFrame = targetFrame;
        _pinterestPushTransition.sourceViewController = sourceVC;
        _dismissTransition = [[SCDismissTransition alloc] init];
        _interactionController = [[SCSwipeBackInteractionController alloc] initWithView:swipeBackView];
        SCGestureTransitionBackContext *context = [[SCGestureTransitionBackContext alloc] init];
        _interactionController.context = context;
        _dismissTransition.context = context;
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
    return self.dismissTransition;
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
    return self.interactionController.interactionInProgress ? self.interactionController : nil;
}

@end
