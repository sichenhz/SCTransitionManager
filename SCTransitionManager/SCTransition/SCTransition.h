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
 *  仿push的present效果，默认用根控制器下最后一个presentedViewController来调用
 *
 *  @param viewController   跳转的ViewController（可以是NavigationController，也可以是普通ViewController）
 *  @param animated         是否需要动画
 *  @param completion       完成后回调
 */
+ (void)presentViewController:(UIViewController *)viewController
                     animated:(BOOL)animated
                   completion:(void (^)())completion;

/**
 *  zoom效果，默认用根控制器下最后一个presentedViewController来调用
 *
 *  @param viewController   跳转的ViewController（可以是NavigationController，也可以是普通ViewController）
 *  @param view             当前ViewController.view
 *  @param sourceView       动画开始时，要进行放大的UIView对象，此对象应该是当前ViewController的子View
 *  @param targetView       动画结束时，已经放大的UIView对象，此对象应该是跳转后ViewController的子view
 *  @param targetFrame      动画结束时，targetView对象的frame，坐标系基于跳转后ViewController.view
 *  @param completion       完成后回调
 */
+ (void)presentViewController:(UIViewController *)viewController
                         view:(UIView *)view
                   sourceView:(UIView *)sourceView
                   targetView:(UIView *)targetView
                  targetFrame:(CGRect)targetFrame
                   completion:(void (^)())completion;

/**
 *  dismiss时，会自动选择对应效果
 *
 *  @param animated         是否需要动画
 *  @param completion       完成后回调
 */
+ (void)dismissViewControllerAnimated:(BOOL)animated
                           completion:(void (^)())completion;

@end
