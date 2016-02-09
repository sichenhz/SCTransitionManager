//
//  SCPresentTransition.m
//  SCTransitionManager
//
//  Created by sichenwang on 16/2/7.
//  Copyright © 2016年 sichenwang. All rights reserved.
//

#import "SCPresentTransition.h"

@implementation SCPresentTransition

- (instancetype)init {
    if (self = [super init]) {
        _duration = 0.3;
    }
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
    return self.duration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    // toView
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = toViewController.view;
    [transitionContext.containerView addSubview:toView];
    CGRect toFinalFrame = [transitionContext finalFrameForViewController:toViewController];
    CGRect toInitFrame = CGRectOffset(toFinalFrame, [[UIScreen mainScreen] bounds].size.width, 0);
    toView.frame = toInitFrame;

    // fromView
    UIViewController *fromViewController = [transitionContext
                                            viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *fromView = fromViewController.view;
    CGRect fromInitFrame = [transitionContext initialFrameForViewController:fromViewController];
    CGRect fromFinalFrame = CGRectOffset(fromInitFrame, -fromInitFrame.size.width / 3, 0);
    
    // animate
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut|UIViewAnimationOptionOverrideInheritedOptions |UIViewAnimationOptionTransitionNone
                     animations:^{
                         toView.frame = toFinalFrame;
                         fromView.frame = fromFinalFrame;
                     } completion:^(BOOL finished) {
                         [transitionContext completeTransition:YES];
                     }];
}

@end