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
 *  仿push效果，默认用根控制器下最后一个presentedViewController来调用
 *
 *  @param viewController   跳转的ViewController（可以是NavigationController，也可以是普通ViewController）
 *  @param animated         是否需要动画
 *  @param completion       完成后的回调
 */
+ (void)presentViewController:(UIViewController *)viewController
                     animated:(BOOL)animated
                   completion:(void (^)())completion;

/**
 *  zoom效果，默认用根控制器下最后一个presentedViewController来调用
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
 *  dismiss时，会自动选择跳转时对应的效果
 *
 *  @param animated         是否需要动画
 *  @param completion       完成后回调
 */
+ (void)dismissViewControllerAnimated:(BOOL)animated
                           completion:(void (^)())completion;

@end
