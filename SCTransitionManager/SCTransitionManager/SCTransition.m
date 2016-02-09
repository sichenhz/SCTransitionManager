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
#import "SCGestureTransitionBackContext.h"
#import "SCSwipeBackInteractionController.h"

@interface SCTransition()

@property (nonatomic, strong) SCPresentTransition *presentTransition;
@property (nonatomic, strong) SCDismissTransition *dismissTransition;
@property (nonatomic, strong) SCSwipeBackInteractionController *interactionController;

@end

@implementation SCTransition

- (instancetype)initWithView:(UIView *)view {
    if (self = [super init]) {
        _presentTransition = [[SCPresentTransition alloc] init];
        _dismissTransition = [[SCDismissTransition alloc] init];
        _interactionController = [[SCSwipeBackInteractionController alloc] initWithView:view];
        SCGestureTransitionBackContext *context = [[SCGestureTransitionBackContext alloc] init];
        _interactionController.context = context;
        _dismissTransition.context = context;
    }
    return self;
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return self.presentTransition;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return self.dismissTransition;
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
    return self.interactionController.interactionInProgress ? self.interactionController : nil;
}

@end
