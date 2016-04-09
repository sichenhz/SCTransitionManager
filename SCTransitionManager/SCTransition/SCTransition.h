//
//  SCTransition.h
//  SCTransitionManager
//
//  Created by sichenwang on 16/2/7.
//  Copyright © 2016年 sichenwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCTransition : NSObject

// present
+ (void)presentViewController:(UIViewController *)viewController
                     animated:(BOOL)animated
                   completion:(void (^)())completion;
+ (void)presentViewController:(UIViewController *)viewController
                   sourceView:(UIView *)sourceView
                   targetView:(UIView *)targetView
                     animated:(BOOL)animated
                   completion:(void (^)())completion;

// dismiss
+ (void)dismissViewControllerAnimated:(BOOL)animated
                           completion:(void (^)())completion;
+ (void)dismissToViewController:(UIViewController *)viewController
                       animated:(BOOL)animated
                     completion:(void (^)())completion;
+ (void)dismissToRootViewControllerAnimated:(BOOL)animated
                                 completion:(void (^)())completion;

// push
+ (void)pushViewController:(UIViewController *)viewController
                  animated:(BOOL)animated
                completion:(void (^)())completion;
+ (void)pushViewController:(UIViewController *)viewController
                sourceView:(UIView *)sourceView
                targetView:(UIView *)targetView
                  animated:(BOOL)animated
                completion:(void (^)())completion;
+ (void)pushViewControllers:(NSArray<UIViewController *> *)viewControllers
                   animated:(BOOL)animated
                 completion:(void (^)())completion;

// pop
+ (UIViewController *)popViewControllerAnimated:(BOOL)animated
                                     completion:(void (^)())completion;
+ (NSArray *)popToViewController:(UIViewController *)viewController
                        animated:(BOOL)animated
                      completion:(void (^)())completion;
+ (NSArray *)popToRootViewControllerAnimated:(BOOL)animated
                                  completion:(void (^)())completion;

@end
