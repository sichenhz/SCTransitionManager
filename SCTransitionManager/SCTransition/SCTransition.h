//
//  SCTransition.h
//  SCTransitionManager
//
//  Created by sichenwang on 16/2/7.
//  Copyright © 2016年 sichenwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCTransition : NSObject

/**
 *  dismiss完成时调用（包括dismiss方法和手势划回）
 */
+ (void)setDismissCompletion:(void (^)())completion;

/**
 *  pop完成时调用（包括pop方法和手势划回、不包括点击返回按钮）
 */
+ (void)setPopCompletion:(void (^)())completion;

/**
 *  调用该方法present会使用模仿NavigationController的push效果
 *
 *  @param viewController   跳转的ViewController（可以是NavigationController，也可以是普通ViewController）
 */
+ (void)presentViewController:(UIViewController *)viewController;

/**
 *  调用该方法present会使用模仿NavigationController的push效果
 *
 *  @param viewController   跳转的ViewController（可以是NavigationController，也可以是普通ViewController）
 *  @param animated         是否需要动画
 *  @param completion       完成后的回调
 */
+ (void)presentViewController:(UIViewController *)viewController
                     animated:(BOOL)animated
                   completion:(void (^)())completion;

/**
 *  调用该方法present会使用缩放效果，由sourceView缩放至targetView
 *
 *  @param viewController   跳转的ViewController（可以是NavigationController，也可以是普通ViewController）
 *  @param sourceView       动画开始时，进行缩放动画的UIView对象
 *  @param targetView       动画结束时，缩放动画完成的UIView对象
 *  @param animated         是否需要动画
 *  @param completion       完成后的回调
 */
+ (void)presentViewController:(UIViewController *)viewController
                   sourceView:(UIView *)sourceView
                   targetView:(UIView *)targetView
                     animated:(BOOL)animated
                   completion:(void (^)())completion;

/**
 *  调用该方法dismiss时，会自动选择present时对应的效果
 *
 *  @param animated         是否需要动画
 */
+ (void)dismissViewControllerAnimated:(BOOL)animated;

/**
 *  dismiss至栈内特定的ViewController
 *
 *  @param viewController   dissmis至某个栈内的控制器
 *  @param animated         是否需要动画
 *  @param completion       完成后回调
 */
+ (void)dismissToViewController:(UIViewController *)viewController
                       animated:(BOOL)animated
                     completion:(void (^)())completion;

/**
 *  dismiss至RootViewController
 *
 *  @param animated         是否需要动画
 *  @param completion       完成后回调
 */
+ (void)dismissToRootViewControllerAnimated:(BOOL)animated
                                 completion:(void (^)())completion;

/**
 *  调用该方法push会使用默认的效果
 *
 *  @param viewController   跳转的ViewController
 */
+ (void)pushViewController:(UIViewController *)viewController;

/**
 *  调用该方法push会使用默认的效果
 *
 *  @param viewController   跳转的ViewController
 *  @param animated         是否需要动画
 */
+ (void)pushViewController:(UIViewController *)viewController
                  animated:(BOOL)animated
                completion:(void (^)())completion;

/**
 *  调用该方法push会使用缩放效果，由sourceView缩放至targetView
 *
 *  @param viewController   跳转的ViewController
 *  @param sourceView       动画开始时，进行缩放动画的UIView对象
 *  @param targetView       动画结束时，缩放动画完成的UIView对象
 *  @param animated         是否需要动画
 */
+ (void)pushViewController:(UIViewController *)viewController
                sourceView:(UIView *)sourceView
                targetView:(UIView *)targetView
                  animated:(BOOL)animated
                completion:(void (^)())completion;

/**
 *  调用该方法pop时，会自动选择push时对应的效果
 *
 *  @param animated         是否需要动画
 */
+ (UIViewController *)popViewControllerAnimated:(BOOL)animated;

/**
 *  pop至栈内特定的ViewController
 *
 *  @param viewController   pop至某个栈内的控制器
 *  @param animated         是否需要动画
 */
+ (NSArray *)popToViewController:(UIViewController *)viewController
                        animated:(BOOL)animated
                      completion:(void (^)())completion;

/**
 *  pop至RootViewController
 *
 *  @param animated         是否需要动画
 */
+ (NSArray *)popToRootViewControllerAnimated:(BOOL)animated
                                  completion:(void (^)())completion;

@end
