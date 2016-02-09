//
//  SCTransition.h
//  SCTransitionManager
//
//  Created by sichenwang on 16/2/7.
//  Copyright © 2016年 sichenwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCTransition : NSObject<UIViewControllerTransitioningDelegate>

/**
 *  普通转场效果
 *
 *  @param swipeBackView 要支持手势返回的view
 */
- (instancetype)initWithSwipeBackView:(UIView *)swipeBackView;

/**
 *  视图放大转场效果
 *
 *  @param swipeBackView    要支持手势返回的view
 *  @param sourceview       要进行放大展开的UIView对象，此对象应该是sourceViewController的子View
 *  @param targetFrame      动画结束时，view对象的frame，注意：坐标系基于sourceViewController.view
 *  @param sourceVC         起始ViewController
 *  @param targetVC         目标ViewController
 */
- (instancetype)initWithSwipeBackView:(UIView *)swipeBackView SourceView:(UIView *)sourceview targetFrame:(CGRect)targetFrame sourceVC:(UIViewController *)sourceVC;

@end
