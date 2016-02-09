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
 *  普通转场效果
 *
 *  @param swipeBackView    要支持手势返回的view
 *  @param animated         是否需要转场动画
 *  @param completion       转场结束的回调
 */
+ (void)presentViewController:(UIViewController *)viewController
                     animated:(BOOL)animated
                   completion:(void (^)())completion;

/**
 *  增强转场效果（该模式强制开启动画）
 *
 *  @param swipeBackView    要支持手势返回的view
 *  @param sourceview       动画开始时，要进行放大展开的UIView对象，此对象应该是sourceVC的子View
 *  @param sourceVC         起始ViewController
 *  @param targetView       动画结束时，已经放大的UIView对象，此对象应该是targetVC的子view
 *  @param targetVC         目标ViewController
 *  @param targetFrame      动画结束时，targetView对象的frame，注意：坐标系基于targetVC的view
 *  @param completion       转场结束的回调
 */
+ (void)presentViewController:(UIViewController *)viewController
                   sourceView:(UIView *)sourceView
                     sourceVC:(UIViewController *)sourceVC
                   targetView:(UIView *)targetView
                     targetVC:(UIViewController *)targetVC
                  targetFrame:(CGRect)targetFrame
                   completion:(void (^)())completion;

/**
 *  dismiss时，会自动选择对应效果
 *
 *  @param animated         是否需要转场动画
 *  @param completion       转场结束的回调
 */
+ (void)dismissViewControllerAnimated:(BOOL)animated
                           completion:(void (^)())completion;

@end
