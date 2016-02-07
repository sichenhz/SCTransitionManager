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

@interface SCTransition()

@property (nonatomic, strong) SCPresentTransition *presentTransition;
@property (nonatomic, strong) SCDismissTransition *dismissTransition;

@end

@implementation SCTransition

- (instancetype)init {
    if (self = [super init]) {
        _presentTransition = [[SCPresentTransition alloc] init];
        _dismissTransition = [[SCDismissTransition alloc] init];
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

@end
